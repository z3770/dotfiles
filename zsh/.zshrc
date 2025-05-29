autoload -U compinit && compinit
export EDITOR="nvim"
export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export EZA_CONFIG_DIR="$HOME/.config/eza"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

alias ls="eza --icons=always"
alias tree="eza --tree --icons --git"
alias vim=nvim
alias cat="bat"

. "$HOME/.local/bin/env"
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
