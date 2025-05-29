set -gx PATH $HOME/.local/bin $PATH
set -gx PATH /usr/local/bin $PATH
set -gx EZA_CONFIG_DIR $HOME/.config/eza
set -gx EDITOR nvim
set fish_greeting ""

starship init fish | source
zoxide init fish | source

alias ls "eza --icons=always"
alias tree "eza --tree --icons --git"
alias vim nvim
alias cat bat
