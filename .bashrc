# Test for an interactive shell.
if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now!
	return
fi

eval "$(starship init bash)"

PATH="${HOME}/scripts/:${HOME}/.local/bin:${PATH}:"

export QT_QPA_PLATFORM=xcb

alias ll="ls -la"

# Change directory interactively
d() {
	path=$(fd . ${1:-.} -td -H | fzf)
	if [[ -n $path ]]; then
		cd $path
	fi
}
alias dr="d /"
alias dh="d ~"

alias lg="lazygit"
