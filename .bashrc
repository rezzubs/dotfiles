# Test for an interactive shell.
if [[ $- != *i* ]] ; then
    # Shell is non-interactive.  Be done now!
    return
fi

eval "$(starship init bash)"

PATH="${HOME}/scripts/:${HOME}/.config/emacs/bin:${HOME}/.local/bin:${PATH}:"

alias ll="ls -la"
