# Test for an interactive shell.
if [[ $- != *i* ]]; then
	# Shell is non-interactive.  Be done now!
	return
fi

eval "$(starship init bash)"

add_to_path=(
    "${HOME}/scripts"
    "${HOME}/.local/bin"
)

for p in "${add_to_path[@]}"; do
    PATH="${p}:${PATH}"
done

export EDITOR=nvim
export VISUAL="$EDITOR"


alias vimdiff="nvim -d"
alias ls="ls --color=auto"
alias ll="ls -la"
alias lg="lazygit"

eval "$(zoxide init bash --cmd cd)"
