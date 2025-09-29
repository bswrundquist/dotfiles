# Custom Git helper functions (Bash)
# This file is intended to be sourced by interactive shells.
# Keep it free of shell option changes; only define functions and aliases.

# Example helpers (commented):

# Change to repo root
# groot() {
#   local repo_root
#   repo_root=$(git rev-parse --show-toplevel 2>/dev/null) || {
#     echo "Not inside a git repository" >&2
#     return 1
#   }
#   cd "$repo_root" || return
# }

# Quick add+commit
# gcm() {
#   if [ $# -eq 0 ]; then
#     echo "Usage: gcm <message>" >&2
#     return 2
#   fi
#   git add -A && git commit -m "$*"
# }

# Git Worktree Shortcuts - Add to ~/.bashrc, ~/.zshrc, or ~/.bash_profile
# Avoid alias/function conflicts (e.g., from oh-my-zsh git plugin)
unalias gwt 2>/dev/null || true
unalias gws 2>/dev/null || true
unalias gwr 2>/dev/null || true
unalias gwl 2>/dev/null || true
unalias gwm 2>/dev/null || true
unalias gwi 2>/dev/null || true
unalias gwt-move 2>/dev/null || true
unalias gwt-clean 2>/dev/null || true
unalias gwt-status 2>/dev/null || true
unalias gwt-temp 2>/dev/null || true

# Function to get the worktree base directory for the current repo
get_worktree_base() {
    local repo_name=$(basename "$(git rev-parse --show-toplevel 2>/dev/null)")
    echo "../${repo_name}.worktrees"
}

# Create a new worktree (gwt = git worktree)
gwt() {
    local branch_name="$1"
    local start_point="${2:-HEAD}"
    
    if [ -z "$branch_name" ]; then
        echo "Usage: gwt <branch-name> [start-point]"
        echo "Example: gwt feature/new-feature"
        echo "Example: gwt bugfix/issue-123 origin/main"
        return 1
    fi
    
    local worktree_base=$(get_worktree_base)
    local worktree_path="${worktree_base}/${branch_name//\//-}"
    
    mkdir -p "$(dirname "$worktree_path")"
    
    if git rev-parse --verify "$branch_name" >/dev/null 2>&1; then
        git worktree add "$worktree_path" "$branch_name"
    else
        git worktree add -b "$branch_name" "$worktree_path" "$start_point"
    fi
    
    echo "✓ Created worktree at: $worktree_path"
    echo "  To switch to it, run: gws $branch_name"
}

# Switch to a worktree (gws = git worktree switch)
gws() {
    local branch_name="$1"
    
    if [ -z "$branch_name" ]; then
        echo "Available worktrees:"
        git worktree list | column -t
        return 0
    fi
    
    local worktree_base=$(get_worktree_base)
    local worktree_path="${worktree_base}/${branch_name//\//-}"
    
    if [ -d "$worktree_path" ]; then
        cd "$worktree_path"
        echo "✓ Switched to worktree: $(pwd)"
    else
        echo "✗ Worktree not found: $worktree_path"
        echo "Available worktrees:"
        git worktree list | column -t
        return 1
    fi
}

# Remove a worktree (gwr = git worktree remove)
gwr() {
    local branch_name="$1"
    
    if [ -z "$branch_name" ]; then
        echo "Usage: gwr <branch-name>"
        return 1
    fi
    
    local worktree_base=$(get_worktree_base)
    local worktree_path="${worktree_base}/${branch_name//\//-}"
    
    git worktree remove "$worktree_path" --force
    echo "✓ Removed worktree: $worktree_path"
}

# List all worktrees (gwl = git worktree list)
alias gwl='git worktree list'

# Move uncommitted changes to a new worktree
gwt_move() {
    local new_branch="$1"
    
    if [ -z "$new_branch" ]; then
        echo "Usage: gwt-move <new-branch-name>"
        echo "This will move current directory to a new worktree branch"
        return 1
    fi
    
    # Get current changes status
    local changes=$(git status --porcelain)
    
    if [ -z "$changes" ]; then
        echo "No uncommitted changes to move"
        return 1
    fi
    
    # Create temporary patch
    local patch_file="/tmp/gwt-move-$(date +%s).patch"
    git diff HEAD > "$patch_file"
    
    # Reset current worktree
    git reset --hard HEAD
    
    # Create new worktree
    gwt "$new_branch"
    
    # Switch to new worktree
    gws "$new_branch"
    
    # Apply the patch
    if [ -s "$patch_file" ]; then
        git apply "$patch_file"
        rm "$patch_file"
        echo "✓ Moved changes to new worktree: $new_branch"
    fi
}

# Clean up worktrees with deleted branches
gwt_clean() {
    echo "Cleaning up worktrees..."
    git worktree prune
    
    git worktree list --porcelain | grep '^worktree' | cut -d' ' -f2 | while read -r worktree_path; do
        if ! git -C "$worktree_path" symbolic-ref HEAD >/dev/null 2>&1; then
            echo "Removing broken worktree: $worktree_path"
            git worktree remove "$worktree_path" --force
        fi
    done
    
    echo "✓ Cleanup complete"
}

# Quick status of all worktrees
gwt_status() {
    echo "Worktree Status Overview:"
    echo "========================="
    
    git worktree list --porcelain | grep '^worktree' | cut -d' ' -f2 | while read -r worktree_path; do
        if [ -d "$worktree_path" ]; then
            local branch=$(git -C "$worktree_path" branch --show-current 2>/dev/null || echo "detached")
            local changes=$(git -C "$worktree_path" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
            
            echo ""
            echo "📁 $(basename "$worktree_path")"
            echo "   Branch: $branch"
            echo "   Uncommitted changes: $changes file(s)"
        fi
    done
}

# Create a temporary worktree for experiments
gwt_temp() {
    local temp_name="temp-$(date +%Y%m%d-%H%M%S)"
    gwt "$temp_name"
    gws "$temp_name"
    echo "✓ Created temporary worktree: $temp_name"
    echo "  Remember to clean up with: gwr $temp_name"
}

# Go back to main worktree
gwm() {
    local main_branch=$(git symbolic-ref refs/remotes/origin/HEAD 2>/dev/null | sed 's@^refs/remotes/origin/@@')
    main_branch=${main_branch:-main}
    
    local main_path=$(git worktree list --porcelain | grep -B2 "branch refs/heads/$main_branch" | grep '^worktree' | cut -d' ' -f2 | head -1)
    
    if [ -z "$main_path" ]; then
        main_path=$(git rev-parse --show-toplevel)
    fi
    
    if [ -d "$main_path" ]; then
        cd "$main_path"
        echo "✓ Switched to main worktree: $(pwd)"
    else
        echo "✗ Could not find main worktree"
        return 1
    fi
}

# Interactive worktree switcher (requires fzf)
gwi() {
    if ! command -v fzf >/dev/null 2>&1; then
        echo "This command requires fzf. Install it with: brew install fzf (macOS) or apt install fzf (Linux)"
        return 1
    fi
    
    local selected=$(git worktree list | fzf --height=10 --layout=reverse --border | awk '{print $1}')
    
    if [ -n "$selected" ]; then
        cd "$selected"
        echo "✓ Switched to: $(pwd)"
    fi
}

# Provide hyphenated command aliases for convenience
alias 'gwt-move'=gwt_move
alias 'gwt-clean'=gwt_clean
alias 'gwt-status'=gwt_status
alias 'gwt-temp'=gwt_temp

# Bash completion for gws (switch worktree)
if [ -n "$BASH_VERSION" ]; then
    _gws_completion() {
        local cur="${COMP_WORDS[COMP_CWORD]}"
        local worktrees=$(git worktree list 2>/dev/null | awk '{print $NF}' | sed 's/[][]//g' | xargs -I{} basename {})
        COMPREPLY=($(compgen -W "$worktrees" -- "$cur"))
    }
    complete -F _gws_completion gws
    complete -F _gws_completion gwr
fi

# Help command
gwt-help() {
    cat << 'HELP'
Git Worktree Shortcuts
=======================
All worktrees are stored in: ../repo-name.worktrees/

BASIC COMMANDS:
  gwt <branch> [start]  Create new worktree for branch
  gws <branch>         Switch to existing worktree
  gwr <branch>         Remove worktree
  gwl                  List all worktrees
  gwm                  Go to main/master worktree

ADVANCED:
  gwt-move <branch>    Move current uncommitted changes to new worktree
  gwt-clean            Clean up broken worktrees
  gwt-status           Show status of all worktrees
  gwt-temp             Create temporary worktree for experiments
  gwi                  Interactive worktree switcher (needs fzf)

EXAMPLES:
  gwt feature/login              # Create worktree for new feature
  gwt bugfix/crash origin/main   # Create bugfix branch from origin/main
  gws feature/login              # Switch to existing worktree
  gwt-move experimental          # Move current changes to new worktree

NO STASHING NEEDED! Each worktree has its own working directory,
so you can have uncommitted changes in multiple worktrees simultaneously.
HELP
}

echo "Git worktree shortcuts loaded! Type 'gwt-help' for usage information."
