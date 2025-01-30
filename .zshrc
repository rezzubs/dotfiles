eval "$(starship init zsh)"

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname $ZINIT_HOME)"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

. "${ZINIT_HOME}/zinit.zsh"

zinit ice depth=1

zinit light zsh-users/zsh-syntax-highlighting

zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

zinit light zsh-users/zsh-autosuggestions

bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

add_to_path=(
    "${HOME}/scripts"
    "${HOME}/.local/bin"
)
for p in "${add_to_path[@]}"; do
    PATH="${p}:${PATH}"
done

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_dups
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

alias ls="ls --color"
alias ll="ls -lah"
alias lg="lazygit"
alias hx="helix"
alias zb="zig build"
alias zbr="zig build run"

export EDITOR=helix
export VISUAL=helix

eval "$(fzf --zsh)"
eval "$(zoxide init zsh --cmd cd)"
