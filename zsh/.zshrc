if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git zsh-syntax-highlighting zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export NVM_DIR=/Users/a-/.nvm
  [ -s /usr/local/opt/nvm/nvm.sh ] && \. /usr/local/opt/nvm/nvm.sh  # This loads nvm
  [ -s /usr/local/opt/nvm/etc/bash_completion.d/nvm ] && \. /usr/local/opt/nvm/etc/bash_completion.d/nvm  # This loads nvm bash_completion

source <(fzf --zsh)
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"

eval "$(zoxide init zsh)"
export PATH=$PATH:$HOME/go/bin
export PATH="$PATH:/Applications/WezTerm.app/Contents/MacOS"

alias ls="eza --icons=always"
alias tree="eza --tree --icons --git"
alias vim=nvim
alias lg="lazygit"
alias cd="z"
alias cdi="zi"
alias cat="bat"
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
eval "$(alias sketchybar="$HOME/.config/sketchybar/set-bar-mode.sh")"
eval "$(alias sketchybar="$HOME/.config/sketchybar/set-bar-mode.sh")"

export PATH=$PATH:/Users/a-/.spicetify
