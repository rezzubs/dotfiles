# Test for an interactive shell.
if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now!
	return
fi

eval "$(starship init bash)"

PATH="${HOME}/scripts/:${HOME}/.local/bin:${PATH}:"

export QT_QPA_PLATFORM=xcb

alias ll="ls -la"

alias lg="lazygit"

eval "$(zoxide init bash --cmd cd)"

[ -f "/home/rezzubs/.ghcup/env" ] && . "/home/rezzubs/.ghcup/env" # ghcup-env
