bindkey -v

export EDITOR="nvim"
export EZA_CONFIG_DIR="$HOME/.config/eza"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

alias ls="eza --icons=always"
alias tree="eza --tree --icons --git"
alias vim=nvim
alias cat="bat"


