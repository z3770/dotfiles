# dotfiles

Personal macOS dotfiles, themed end to end with the [Tokyo Night](https://github.com/folke/tokyonight.nvim) "night" palette.

Each top-level directory is a [GNU Stow](https://www.gnu.org/software/stow/) package that mirrors the layout of `$HOME`.

## Tools

| Package    | Tool                                                          | Description                                                                                     |
| ---------- | ------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `aerospace` | [AeroSpace](https://github.com/nikitabobko/AeroSpace)        | Tiling window manager for macOS                                                                 |
| `atuin`    | [Atuin](https://atuin.sh)                                     | Shell history search and sync, with Tokyo Night theme                                           |
| `bat`      | [bat](https://github.com/sharkdp/bat)                         | `cat` replacement with syntax highlighting, with Tokyo Night theme                              |
| `borders`  | [JankyBorders](https://github.com/FelixKratz/JankyBorders)    | Active-window border for AeroSpace, with a Tokyo Night gradient                                  |
| `chrome`   | Google Chrome                                                 | Unpacked Tokyo Night browser theme                                                              |
| `claude`   | [Claude Code](https://claude.com/claude-code)                 | Tokyo Night theme for Claude Code                                                               |
| `eza`      | [eza](https://github.com/eza-community/eza)                   | `ls` replacement with icons and git status, with custom theme                                   |
| `ghostty`  | [Ghostty](https://ghostty.org)                                | Terminal emulator: translucent background, hidden titlebar, global quick terminal (`cmd+\``)    |
| `lazygit`  | [lazygit](https://github.com/jesseduffield/lazygit)           | Terminal UI for git                                                                             |
| `nvim`     | [Neovim](https://neovim.io) + [LazyVim](https://lazyvim.org)  | Editor with transparent Tokyo Night, oil.nvim explorer, and vim-tmux-navigator                  |
| `posting`  | [Posting](https://posting.sh)                                 | Terminal HTTP client, with Tokyo Night theme                                                    |
| `tmux`     | [tmux](https://github.com/tmux/tmux)                          | Terminal multiplexer with TPM, session persistence, a sessionizer script, and AI key macros     |
| `yazi`     | [Yazi](https://yazi-rs.github.io)                             | Terminal file manager with the sshfs plugin                                                     |
| `zsh`      | [Zsh](https://www.zsh.org)                                    | Shell with Powerlevel10k, fzf, fzf-tab, autosuggestions, syntax highlighting, zoxide, fnm       |

## Install

Install [Homebrew](https://brew.sh), then install Stow:

```sh
brew install stow
```

Clone the repository and symlink the packages you want:

```sh
git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles
stow zsh tmux nvim ghostty    # or any other package names
```

### Notes

- **tmux**: TPM and its plugins install automatically on first start.
- **nvim**: LazyVim installs plugins on first launch, pinned by `lazy-lock.json`.
- **yazi**: run `ya pkg install` to install plugins from `package.toml`.
- **borders**: install with `brew tap felixkratz/formulae && brew install borders`. AeroSpace starts it via `after-startup-command`.
- **chrome**: open `chrome://extensions`, enable Developer mode, and choose "Load unpacked" with `chrome/tokyonight-night`. This package is not stowed.
- **lazygit**: the config lives under `~/Library/Application Support/lazygit`, the macOS default path.
