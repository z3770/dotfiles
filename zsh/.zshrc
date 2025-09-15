export EDITOR="nvim"
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
    zsh-autosuggestions
    zsh-syntax-highlighting
    git
)

source $ZSH/oh-my-zsh.sh

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
alias ls="eza --icons=always"
alias tree="eza --tree --icons --git"
alias vim=nvim
alias cat="bat"
alias cd="z"
alias cdi="zi"



[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


. "$HOME/.local/bin/env"
