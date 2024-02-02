# Test for an interactive shell.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

eval "$(starship init bash)"

[ -f "/home/rezzubs/.cargo/env" ] && . "$HOME/.cargo/env" # rustup env

PATH="${HOME}/scripts/:${HOME}/.config/emacs/bin:${HOME}/.local/state/nix/profile/bin:${HOME}/.local/bin:${PATH}:"
XDG_DATA_DIRS="${XDG_DATA_DIRS}:${HOME}/.local/state/nix/profile/share"

alias cm=chezmoi
alias r=ranger
alias xclip="xclip -selection clipboard"
alias ll="ls -la"
alias e="emacsclient -t"
alias ec="emacsclient -c"
export EDITOR=vim

export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx

[ -f "/home/rezzubs/.ghcup/env" ] && source "/home/rezzubs/.ghcup/env" # ghcup-env