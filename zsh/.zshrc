bindkey -e
autoload -U compinit && compinit
export EDITOR="nvim"
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export EZA_CONFIG_DIR="$HOME/.config/eza"

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export PATH="/opt/homebrew/bin:$PATH"

source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

setopt autocd
autoload zmv
alias ls="eza --icons=always"
alias tree="eza --tree --icons --git"
alias vim=nvim
alias cat="bat"
source <(fzf --zsh)

bindkey '^f' autosuggest-accept

autoload edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

chpwd() {
    ls -a
}

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}
