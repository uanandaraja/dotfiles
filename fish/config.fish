eval (/opt/homebrew/bin/brew shellenv)

if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias vim='nvim'
alias t="tmux"
alias c="clear"
alias f="fcd"
alias gg='lazygit'
alias la="ls -la"

export FZF_DEFAULT_OPTS='--height 40%'

function fcd
    set dir (zoxide query -l | fzf --height 40% --reverse)
    if test -n "$dir"
        cd $dir
    end
end

function fish_greeting
    set_color cyan
    echo '███▄▄▄▄    ▄█   ▄███████▄   ▄███████▄  ▄██   ▄'
    echo '███▀▀▀██▄ ███  ██▀     ▄██ ██▀     ▄██ ███   ██▄'
    echo '███   ███ ███▌       ▄███▀       ▄███▀ ███▄▄▄███'
    echo '███   ███ ███▌  ▀█▀▄███▀▄▄  ▀█▀▄███▀▄▄ ▀▀▀▀▀▀███'
    echo '███   ███ ███▌   ▄███▀   ▀   ▄███▀   ▀ ▄██   ███'
    echo '███   ███ ███  ▄███▀       ▄███▀       ███   ███'
    echo '███   ███ ███  ███▄     ▄█ ███▄     ▄█ ███   ███'
    echo ' ▀█   █▀  █▀    ▀████████▀  ▀████████▀  ▀█████▀'
    echo
    set_color yellow
    echo "Welcome back, "(whoami)"!"
    echo "Today is "(date)
    set_color normal
end

starship init fish | source
set -gx PATH $PATH $HOME/.bun/bin
