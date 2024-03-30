if status is-interactive
    set fish_greeting

    starship init fish | source
    zoxide init fish --cmd cd | source
    source "$HOME/.cargo/env.fish"
end
