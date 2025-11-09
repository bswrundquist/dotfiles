{pkgs, config, ... }: {
  # export common ignore args so they can be reused by rg, fzf, rsync
  home.sessionVariables = {
    RG_IGNORE_GLOBS = "--glob '!node_modules/**' --glob '!venv/**' --glob '!.venv/**' --glob '!env/**' --glob '!__pycache__/**' --glob '!dist/**' --glob '!build/**'";
    RSYNC_EXCLUDES = "--exclude=node_modules --exclude=venv --exclude=.venv --exclude=env --exclude=__pycache__ --exclude=dist --exclude=build";
    FZF_DEFAULT_COMMAND = "rg --files --hidden --follow \$RG_IGNORE_GLOBS";
    FZF_DEFAULT_OPTS = "--height=40% --layout=reverse --border --preview 'bat --style=numbers --color=always --line-range :200 {}' --preview-window=right:60%:wrap";
  };

}
