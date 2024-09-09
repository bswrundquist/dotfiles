# General shortcuts
alias ll="ls -alF"           # Detailed list with file types
alias la="ls -A"             # List all except . and ..
alias l="ls -CF"             # Compact list format
alias ..="cd .."             # Go up one directory
alias ...="cd ../.."         # Go up two directories
alias ....="cd ../../.."     # Go up three directories
alias .....="cd ../../../.." # Go up four directories
alias c="clear"              # Clear terminal

# Git aliases
alias gst="git status"
alias gco="git checkout"
alias gcm="git commit -m"
alias gaa="git add --all"
alias gca="git commit --amend"
alias gcb="git checkout -b"
alias gp="git pull"
alias gup="git fetch && git rebase"
alias gps="git push"
alias gl="git log --oneline --graph --decorate"
alias gd="git diff"
alias gds="git diff --staged"
alias grm="git rm"
alias gcl="git clone"

# Docker aliases
alias dps="docker ps"
alias di="docker images"
# alias drm="docker rm $(docker ps -a -q)"        # Remove all stopped containers
# alias drmi="docker rmi $(docker images -q)"     # Remove all images
alias dstart="docker start"
alias dstop="docker stop"
alias dlogs="docker logs"
alias dexec="docker exec -it"
alias dbash="docker exec -it bash"              # Access a running container with bash

# Kubernetes aliases (if kubectl is installed)
alias k="kubectl"
alias kgp="kubectl get pods"
alias kgd="kubectl get deployments"
alias kgsvc="kubectl get svc"
alias kgns="kubectl get namespaces"
alias kd="kubectl describe"
alias kdel="kubectl delete"
alias kl="kubectl logs"
alias ke="kubectl exec -it"
alias kctx="kubectl config use-context"         # Switch contexts

# Networking
alias ping="ping -c 5"                          # Limit pings to 5 packets
alias myip="curl ifconfig.me"                   # Get your public IP address
alias netinfo="ifconfig | grep 'inet ' | grep -v 127.0.0.1"  # Show network info

# System monitoring
alias topcpu="ps aux --sort=-%cpu | head -n 10"  # Top processes by CPU usage
alias topmem="ps aux --sort=-%mem | head -n 10"  # Top processes by memory usage
alias dfh="df -h"                               # Disk usage in human-readable format
alias duh="du -h --max-depth=1"                 # Disk usage per folder

# Shortcuts for common tasks
alias untar="tar -xvzf"
alias zipit="zip -r"                                  # Compress a folder
alias unzipe="unzip"                                  # Extract a zip file

# Neovim
alias vim="nvim"
alias v="nvim"

# Tmux
alias ta="tmux attach -t"          # Attach to an existing session
alias tn="tmux new -s"             # Create a new session
alias tls="tmux ls"                # List tmux sessions

# Custom directory navigation
alias docs="cd ~/Documents"
alias dls="cd ~/Downloads"
alias desk="cd ~/Desktop"
alias proj="cd ~/Projects"

# GitHub shortcuts (using gh CLI if installed)
alias ghrepo="gh repo view --web"   # View current GitHub repo in browser
alias ghissue="gh issue view --web" # View issues in browser
alias ghpr="gh pr view --web"       # View pull request in browser

# Python and environment management
alias venv="python3 -m venv venv && source venv/bin/activate"
alias act="source .venv/bin/activate"
alias pipup="pip install --upgrade pip setuptools"

# Clipboard management
alias copy="pbcopy"    # macOS clipboard copy
alias paste="pbpaste"  # macOS clipboard paste
alias clipcopy="xclip -selection clipboard"  # Linux clipboard copy

# Find files quickly
alias ffind="find . -name"  # Example: ffind '*.txt'

# Search within files
alias fgrep="grep -rnw ."   # Search recursively within current directory

# Create and extract compressed files
alias extract="tar -xvzf"   # Extract a tarball
alias compress="tar -cvzf"  # Compress into a tarball

# System management
alias reboot="sudo reboot"
alias shutdown="sudo shutdown now"
alias suspend="systemctl suspend"

# Node.js & NPM shortcuts
alias npmi="npm install"
alias npms="npm start"
alias npmt="npm test"

# Aliases for better default settings
alias grep="grep --color=auto"
alias diff="diff --color=auto"
alias df="df -h"          # More readable disk space usage
alias free="free -h"      # More readable memory usage
alias rm="rm -I"          # Confirm deletion for large file sets

# Shortcuts for fun
alias please="sudo"
alias fuck="sudo !!"       # Run previous command as sudo

