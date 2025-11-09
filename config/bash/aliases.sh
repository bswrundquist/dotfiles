# shellcheck shell=sh

# Single entrypoint for interactive helpers (formerly aliases) as shell functions.
# Keep POSIX-y so it works in both bash and zsh.

# --- aliases that must remain aliases ---
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
# "-" needs "--" to avoid being parsed as an option to alias(1)
alias -- -='cd -'

# --- navigation ---
unalias cds 2>/dev/null || true
cds() { cd "$HOME/smithy" || return; }

unalias cdf 2>/dev/null || true
cdf() { cd "$HOME/smithy/forge" || return; }

unalias cdd 2>/dev/null || true
cdd() { cd "$HOME/smithy/dotfiles" || return; }

unalias cdh 2>/dev/null || true
cdh() { cd "$HOME/smithy/homepage" || return; }

unalias cdn 2>/dev/null || true
cdn() { cd "$HOME/smithy/notebooks" || return; }

unalias cdtr 2>/dev/null || true
cdtr() { cd "$HOME/smithy/template_repository" || return; }

unalias cddl 2>/dev/null || true
cddl() { cd "$HOME/Downloads" || return; }

unalias cddo 2>/dev/null || true
cddo() { cd "$HOME/Documents" || return; }

# --- general wrappers ---
unalias d 2>/dev/null || true
d() { docker "$@"; }

unalias dc 2>/dev/null || true
dc() { docker compose "$@"; }

unalias m 2>/dev/null || true
m() { make "$@"; }

unalias v 2>/dev/null || true
v() { nvim "$@"; }

unalias lg 2>/dev/null || true
lg() { lazygit "$@"; }

unalias g 2>/dev/null || true
g() { git "$@"; }

unalias gs 2>/dev/null || true
gs() { git status "$@"; }

unalias gcs 2>/dev/null || true
gcs() { gcloud storage "$@"; }

unalias gca 2>/dev/null || true
gca() {
  gcloud auth login "$@" || return
  gcloud auth application-default login "$@"
}

unalias h 2>/dev/null || true
h() { history "$@"; }

unalias hg 2>/dev/null || true
hg() { history | rg "$@"; }

unalias k 2>/dev/null || true
k() { kubectl "$@"; }

unalias kgpo 2>/dev/null || true
kgpo() { kubectl get pod "$@"; }

unalias kdpo 2>/dev/null || true
kdpo() { kubectl describe pod "$@"; }

unalias kgs 2>/dev/null || true
kgs() { kubectl get svc "$@"; }

unalias kds 2>/dev/null || true
kds() { kubectl describe svc "$@"; }

unalias kgn 2>/dev/null || true
kgn() { kubectl get nodes "$@"; }

unalias kdn 2>/dev/null || true
kdn() { kubectl describe nodes "$@"; }

unalias kctx 2>/dev/null || true
kctx() { kubectx "$@"; }

unalias kns 2>/dev/null || true
kns() { kubens "$@"; }

unalias kpf 2>/dev/null || true
kpf() { kubectl port-forward "$@"; }

unalias l 2>/dev/null || true
l() { ls -l "$@"; }

unalias ll 2>/dev/null || true
ll() { ls -lha "$@"; }

# --- python / jupyter helpers ---
unalias ipython 2>/dev/null || true
ipython() { command uvx --with polars --with pyarrow --with matplotlib --with seaborn --with scikit-learn --with gcsfs ipython "$@"; }

unalias scratchpad 2>/dev/null || true
scratchpad() { command uv run --with jupyter-core --with polars --with pyarrow --with gcsfs --with seaborn --with scikit-learn --with catboost jupyter notebook --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.notebook_dir="$HOME/scratchpad" "$@"; }

unalias notebook 2>/dev/null || true
notebook() { command uv run --with jupyter-core --with polars --with pyarrow --with gcsfs --with seaborn --with scikit-learn --with catboost jupyter notebook --NotebookApp.token='' --NotebookApp.password='' "$@"; }

unalias nb2md 2>/dev/null || true
nb2md() { command uvx --with jupyter-core jupyter nbconvert --to markdown --no-input "$@"; }

unalias nb2html 2>/dev/null || true
nb2html() { command uvx --with jupyter-core jupyter nbconvert --to html --no-input "$@"; }

unalias ansible 2>/dev/null || true
ansible() { command uvx --with ansible-core ansible "$@"; }

# --- date/time helpers ---
unalias day 2>/dev/null || true
day() { date +%A; }

unalias dow 2>/dev/null || true
dow() { date +%u; }

unalias week 2>/dev/null || true
week() { date +%V; }

unalias month 2>/dev/null || true
month() { date +%B; }

unalias date 2>/dev/null || true
date() { command date +'%Y-%m-%d %H:%M:%S'; }

unalias time 2>/dev/null || true
time() { command date +'%H:%M:%S'; }

# --- tmux helpers ---
unalias tls 2>/dev/null || true
tls() { tmux ls "$@"; }

unalias tn 2>/dev/null || true
tn() { tmux new -s "$@"; }

unalias ta 2>/dev/null || true
ta() { tmux attach -t "$@"; }

unalias tk 2>/dev/null || true
tk() { tmux kill-session -t "$@"; }

unalias ts 2>/dev/null || true
ts() { tmux new -s smithy || tmux attach -t smithy; }

unalias tnb 2>/dev/null || true
tnb() { tmux new -s notebook -c "$HOME/.notebook" || tmux attach -t notebook; }

# --- notes helpers ---
unalias nn 2>/dev/null || true
nn() { nvim "$HOME/.notebook/notes.md"; }

unalias nt 2>/dev/null || true
nt() { nvim "$HOME/.notebook/tasks.md"; }

unalias nr 2>/dev/null || true
nr() { nvim "$HOME/.notebook/rolodex.md"; }

unalias na 2>/dev/null || true
na() { nvim "$HOME/.notebook/admin.md"; }

# --- misc helpers ---
unalias ss 2>/dev/null || true
ss() { sesh connect "$(sesh list | fzf)"; }

unalias urldecode 2>/dev/null || true
urldecode() {
  python3 - "$@" <<'PY'
import sys, urllib.parse as ul
data = sys.stdin.read() if not sys.argv[1:] else " ".join(sys.argv[1:])
print(ul.unquote_plus(data))
PY
}

unalias urlencode 2>/dev/null || true
urlencode() {
  python3 - "$@" <<'PY'
import sys, urllib.parse as ul
data = sys.stdin.read() if not sys.argv[1:] else " ".join(sys.argv[1:])
print(ul.quote_plus(data))
PY
}

# ripgrep: search code but use global ignore args from environment
unalias rgc 2>/dev/null || true
rgc() { rg --line-number --color=auto ${RG_IGNORE_GLOBS:-} "$@"; }

# fzf helper to open fzf in a tmux popup
unalias fzp 2>/dev/null || true
fzp() { tmux popup -E 'fzf'; }

# rsync: copy/sync but use global exclude args from environment
unalias rsyncc 2>/dev/null || true
rsyncc() { rsync -av --progress ${RSYNC_EXCLUDES:-} "$@"; }

# rsync wrapper to sync only files with given extensions (usage: rsyncs py md js SRC DEST)
unalias rsyncs 2>/dev/null || true
rsyncs() {
  if [ "$#" -lt 3 ]; then
    printf '%s\n' "Usage: rsyncs ext1 [ext2 ...] SRC DEST" >&2
    return 2
  fi
  exts=""
  while [ "$#" -gt 2 ]; do
    exts="$exts --include=*.$1"
    shift
  done
  src="$1"; dest="$2"
  # shellcheck disable=SC2086
  eval rsync -av --progress ${RSYNC_EXCLUDES:-} $exts --exclude='*' "\"$src\"" "\"$dest\""
}


