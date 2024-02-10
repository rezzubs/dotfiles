# Test for an interactive shell.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

eval "$(starship init bash)"

. "${HOME}/.local/state/nix/profile/etc/profile.d/nix.sh"

. "${HOME}/.cargo/env"

PATH="${HOME}/scripts/:${HOME}/.config/emacs/bin:${HOME}/.local/bin:${PATH}:"

alias ll="ls -la"

export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
