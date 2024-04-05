if status is-interactive
    set fish_greeting

    starship init fish | source
    zoxide init fish --cmd cd | source

    fish_add_path ~/.local/bin

    set EDITOR nvim

    source "$HOME/.cargo/env.fish"
end
