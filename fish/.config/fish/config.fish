if status is-interactive
    # Commands to run in interactive sessions can go here
end

starship init fish | source
zoxide init fish | source

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."
alias .......="cd ../../../../../.."

alias v='nvim'

alias g='git'

alias d='docker'

alias z='zoxide'

alias mv='mv -v'
alias rm='rm -i -v'
alias cp='cp -v'

alias h='history'
alias hg='history | rg' # Requires ripgrep

alias l="exa --sort Name"
alias ls="exa --sort Name"
alias ll="exa --sort Name --long"
alias la="exa --sort Name --long --all"

alias sudo='sudo ' # Allow for aliases to be sudo'ed

function backup --argument filename
    cp -a $filename $filename.backup
end
