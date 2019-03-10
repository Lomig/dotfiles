# tmux aliases
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'

# Detach instead of exit if tmux
exit() {
    if [[ -z $TMUX ]]; then
        builtin exit
    else
        tmux detach
    fi
}
