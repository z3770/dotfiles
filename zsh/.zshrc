bindkey -e

# Powerlevel10k instant prompt. Keep it near the top: anything that prints output must go above.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Homebrew PATH, FPATH and HOMEBREW_PREFIX for every shell, not only login shells.
# Must run before compinit (brew completions) and anything that calls a brew binary.
eval "$(/opt/homebrew/bin/brew shellenv zsh)"
typeset -U path fpath

# Completion init with full security audit at most once a day
autoload -Uz compinit
for _zcompdump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
unset _zcompdump

# Show full option/argument descriptions in completions, grouped by type
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''
# Let fzf-tab drive the completion menu instead of zsh's built-in one
zstyle ':completion:*' menu no

# Tokyonight night colors for fzf (also used by fzf-tab)
export FZF_DEFAULT_OPTS="--color=bg+:#283457,bg:-1,border:#27a1b9,fg:#c0caf5,gutter:-1 \
  --color=header:#ff9e64,hl+:#2ac3de,hl:#2ac3de,info:#545c7e,marker:#ff007c \
  --color=pointer:#ff007c,prompt:#2ac3de,query:#c0caf5:regular,scrollbar:#27a1b9 \
  --color=separator:#ff9e64,spinner:#ff007c,fg+:#c0caf5,label:#c0caf5"
zstyle ':fzf-tab:*' use-fzf-default-opts yes

# fzf key bindings (loads before fzf-tab)
source <(fzf --zsh)

# fzf-tab completion menu (loads before autosuggestions and syntax highlighting)
source "$HOMEBREW_PREFIX/opt/fzf-tab/share/fzf-tab/fzf-tab.zsh"

export PATH=$PATH:$HOME/go/bin
export EDITOR="nvim"
export EZA_CONFIG_DIR="$HOME/.config/eza"
. "$HOME/.local/bin/env"

source "$HOMEBREW_PREFIX/share/powerlevel10k/powerlevel10k.zsh-theme"
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
eval "$(zoxide init zsh)"

# Node version manager, auto-switches versions from .nvmrc/.node-version on cd
eval "$(fnm env --use-on-cd)"

# Tokyonight night colors for autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#565f89'

source "$HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Tokyonight night colors for syntax highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[default]='fg=#c0caf5'
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=#f7768e'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=#bb9af7'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=#7aa2f7,underline'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=#7dcfff'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=#9d7cd8,underline'
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=#89ddff'
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=#7dcfff,underline'
ZSH_HIGHLIGHT_STYLES[path]='fg=#7dcfff'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=#89ddff'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=#89ddff'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=#ff9e64'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=#bb9af7'
ZSH_HIGHLIGHT_STYLES[command-substitution]='fg=#c0caf5'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=#565f89'
ZSH_HIGHLIGHT_STYLES[process-substitution]='fg=#c0caf5'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=#565f89'
ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=#c0caf5'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=#565f89'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=#9ece6a'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=#e0af68'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=#ff9e64'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=#ff9e64'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=#ff9e64'
ZSH_HIGHLIGHT_STYLES[assign]='fg=#c0caf5'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=#89ddff'
ZSH_HIGHLIGHT_STYLES[comment]='fg=#565f89'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=#c0caf5'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=#c0caf5'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=#7aa2f7'

setopt autocd
autoload zmv
alias ls="eza --icons=always"
alias tree="eza --tree --icons --git"
alias vim=nvim
alias cat="bat"

bindkey '^f' autosuggest-accept

autoload edit-command-line
zle -N edit-command-line
bindkey '^x^e' edit-command-line

function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}

eval "$(atuin init zsh)"
export PATH="/Users/z/.local/bin:$PATH"  # Added by Deck.app
