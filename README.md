# dotfiles

Personal macOS dotfiles, themed end to end with the [Tokyo Night](https://github.com/folke/tokyonight.nvim) "night" palette.

Each utility directory is a [GNU Stow](https://www.gnu.org/software/stow/) package that mirrors the layout of `$HOME`. Repository metadata such as `.atuin/` is not a Stow package.

## Tools

| Package    | Tool                                                          | Description                                                                                     |
| ---------- | ------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `aerospace` | [AeroSpace](https://github.com/nikitabobko/AeroSpace)        | Tiling window manager for macOS                                                                 |
| `atuin`    | [Atuin](https://atuin.sh)                                     | Shell history search and sync, with Tokyo Night theme                                           |
| `bat`      | [bat](https://github.com/sharkdp/bat)                         | `cat` replacement with syntax highlighting, with Tokyo Night theme                              |
| `borders`  | [JankyBorders](https://github.com/FelixKratz/JankyBorders)    | Active-window border for AeroSpace, with a Tokyo Night gradient                                  |
| `eza`      | [eza](https://github.com/eza-community/eza)                   | `ls` replacement with icons and git status, with custom theme                                   |
| `ghostty`  | [Ghostty](https://ghostty.org)                                | Terminal emulator: Tokyo Night theme, hidden titlebar, global quick terminal (`cmd+\``)    |
| `git`      | [Git](https://git-scm.com) + [delta](https://github.com/dandavison/delta) | Shared Git settings and Tokyo Night diffs                                              |
| `lazygit`  | [lazygit](https://github.com/jesseduffield/lazygit)           | Terminal UI for git                                                                             |
| `pi`       | [Pi](https://pi.dev)                                        | AI coding agent settings and default model                                                     |
| `posting`  | [Posting](https://posting.sh)                                 | Terminal HTTP client, with Tokyo Night theme                                                    |
| `tealdeer` | [tealdeer](https://github.com/tealdeer-rs/tealdeer)           | Cached tldr command examples with Tokyo Night colors                                            |
| `tmux`     | [tmux](https://github.com/tmux/tmux)                          | Terminal multiplexer with TPM, session persistence, a sessionizer script, and AI key macros     |
| `wallpapers` | Omarchy backgrounds                                          | Tokyo Night wallpaper set from [Omarchy](https://github.com/omacom/omarchy), stowed to `~/Pictures/Wallpapers` |
| `yazi`     | [Yazi](https://yazi-rs.github.io)                             | Terminal file manager with the sshfs plugin                                                     |
| `zsh`      | [Zsh](https://www.zsh.org)                                    | Shell with Powerlevel10k, fzf, fzf-tab, autosuggestions, syntax highlighting, zoxide, fnm       |

## Platform support

**This is a macOS-first configuration, not a macOS-only toolset.** Many tools
also run on Linux (and some on Windows), but that does not mean these Stow
packages work unchanged on every OS. The platform assessment below is based on
the repository's configuration; it is not a Linux or Windows runtime test.

| Packages | Platform considerations |
| --- | --- |
| `aerospace`, `borders` | **macOS-only tools.** AeroSpace uses macOS window management and launches Ghostty with `open -na`. Its startup hook hardcodes `/opt/homebrew/bin/borders` (Apple Silicon Homebrew). |
| `zsh` | Zsh and most shell dependencies are available on macOS and Linux, but **this config assumes Apple Silicon Homebrew**: `/opt/homebrew/bin/brew` and plugin paths under `$HOMEBREW_PREFIX`. It also hardcodes `/Users/z/.local/bin` and sources `~/.local/bin/env`. Adapt these paths and install the dependencies before reuse, including on Intel Macs. |
| `ghostty` | Ghostty runs on macOS and Linux, but this config includes `macos-titlebar-style`, `macos-option-as-alt`, and a global `cmd+grave_accent` quick-terminal binding. Review platform-specific settings and shortcut support before using it on Linux. |
| `lazygit` | Cross-platform tool, **macOS-specific Stow layout**: `~/Library/Application Support/lazygit/config.yml`. On Linux, place the config under its Linux config directory (normally `~/.config/lazygit/config.yml`). Requires `delta` for the configured diff renderer. |
| `tmux` | Available on macOS and Linux; not a native Windows setup (use a Unix environment such as WSL). Uses Bash, Git/TPM, zoxide, fzf, Lazygit, and Pi. Clipboard integration needs the appropriate OS backend. The hidden clock is a macOS menu-bar preference, not a runtime dependency. Use a recent tmux compatible with the configured options. |
| `yazi` | Cross-platform tool, but configured helpers include Unix shell commands, `chmod`, `diff`, and SSHFS. SSHFS requires an OS-appropriate installation (including a FUSE implementation where needed); custom openers also require `tw` (tabiew). Not an unchanged native Windows configuration. |
| `atuin`, `bat`, `eza`, `git`, `pi`, `posting`, `tealdeer` | No hardcoded macOS executable or config path found in these packages. They are candidates for reuse on Linux with their dependencies installed. Shared Git settings require delta and its Tokyo Night syntax theme. Pi still needs local authentication and access to the configured model. Tool availability on Windows does not make this Unix-style Stow layout a tested Windows setup. |
| `wallpapers` | Image files and the `~/Pictures/Wallpapers` destination are reusable. The System Settings / `osascript` instructions below are **macOS-only**; use your desktop environment's wallpaper setter elsewhere. |

For Linux, select packages individually, skip `aerospace` and `borders`, and
adapt `zsh`, `ghostty`, and `lazygit` before using them. Do not blindly stow every
directory. The full desktop/shell setup is not intended for native Windows;
assess CLI packages separately in WSL or another suitable environment.

## Install (macOS)

Install [Homebrew](https://brew.sh), then install Stow:

```sh
brew install stow
```

Clone the repository and symlink the packages you want:

```sh
git clone <repo-url> ~/.dotfiles
cd ~/.dotfiles
stow zsh tmux ghostty    # or any other package names
```

### Notes

- **tmux**: TPM and its plugins install automatically on first start.
- **yazi**: run `ya pkg install` to install plugins from `package.toml`.
- **borders**: install with `brew tap felixkratz/formulae && brew install borders`. AeroSpace starts it via `after-startup-command`.
- **wallpapers**: set one from System Settings > Wallpaper, or `osascript -e 'tell application "System Events" to tell every desktop to set picture to "$HOME/Pictures/Wallpapers/omarchy-tokyo-night/0-winding-road.webp"'`.
- **lazygit**: the config lives under `~/Library/Application Support/lazygit`, the macOS default path.

### Pi

```sh
stow pi
```

Stows `pi/.pi/agent/settings.json` to `~/.pi/agent/settings.json`, with
`openai/gpt-6.1-sol` as the default model. The package also stows
`~/.pi/agent/themes/tokyonight-night.json` and selects the Tokyo Night "night"
color scheme for Pi's interface, syntax highlighting, diffs, and HTML exports.
Install Pi separately using the
[official instructions](https://pi.dev), then run `/login` to authenticate.

If `settings.json` already exists, move it outside the repository before stowing
and merge any preferences you want to keep. Run `/reload` in an existing Pi
session after editing the config.

#### Keybindings

`Alt+Shift+Enter` queues a follow-up message after Pi finishes its current task,
replacing Pi's default `Alt+Enter` so AeroSpace can keep that shortcut for opening
Ghostty. The override lives in `pi/.pi/agent/keybindings.json`. Run `/reload` to
apply it and `/hotkeys` to inspect the active bindings. The terminal must forward
the modifiers distinctly.

#### Statusline

The stowed `extensions/statusline/` extension replaces Pi's footer automatically:

```text
.dotfiles · main*           gpt-6.1-sol · high · ctx 48k/200k (24%)
```

Numbers above are illustrative. The footer shows the project directory, Git
branch (`*` means uncommitted changes, including untracked files), model,
thinking level, and estimated context usage/capacity. It wraps onto two lines
in narrow panes. Unknown context usage is shown as `ctx ?`, not zero.
Git state refreshes on startup, branch changes, and when the agent settles;
external edits may not appear until one of those refreshes.

If OpenAI supplies default Codex allowance telemetry in response headers or
`codex.rate_limits` stream events, an additional line shows the usage-window
length, percentage **remaining**, and reset countdown. This is separate from
context usage. It makes no additional HTTP requests, reads no credential files,
and stores no quota data on disk. Missing telemetry is hidden, not estimated.
Observations older than 15 minutes or past their reported reset are hidden;
new responses must supply updated values. Access through Pi's current ChatGPT
login is not guaranteed. API cost and cumulative token totals are omitted;
use `/session` for detailed session statistics.

Run `/reload` to activate the extension in an existing session. Parser and
formatting tests (Node.js 24):

```sh
node --test .tests/pi-statusline.test.ts
```

Credentials (`auth.json`), sessions, model caches, and installation files
remain local; they are not part of this package.
Pi may write runtime fields such as `deviceId` and `lastChangelogVersion` into
its settings file. Review changes before committing and omit those fields.

## To-do

- [ ] Replace tmux with Superlogical's terminal multiplexer once it is released. Its beta is not out yet; Superlogical's terminal, Rex, started public testing on 5 October 2026. See [the announcement](https://www.superlogical.com/updates/public-testing-beginning) and join the waitlist there to get notified.
