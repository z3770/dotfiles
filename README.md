# dotfiles

Personal macOS dotfiles, themed with the [Catppuccin](https://catppuccin.com) **Mocha** palette.

Each utility directory is a [GNU Stow](https://www.gnu.org/software/stow/) package that mirrors the layout of `$HOME`. Repository metadata such as `.atuin/` is not a Stow package.

## Tools

| Package    | Tool                                                          | Description                                                                                     |
| ---------- | ------------------------------------------------------------- | ----------------------------------------------------------------------------------------------- |
| `aerospace` | [AeroSpace](https://github.com/nikitabobko/AeroSpace)        | Tiling window manager for macOS                                                                 |
| `atuin`    | [Atuin](https://atuin.sh)                                     | Shell history search and sync, with Catppuccin Mocha theme                                           |
| `bat`      | [bat](https://github.com/sharkdp/bat)                         | `cat` replacement with syntax highlighting, with Catppuccin Mocha theme                              |
| `borders`  | [JankyBorders](https://github.com/FelixKratz/JankyBorders)    | Active-window border for AeroSpace, with a Catppuccin Mocha gradient                                  |
| `eza`      | [eza](https://github.com/eza-community/eza)                   | `ls` replacement with icons and git status, with custom theme                                   |
| `ghostty`  | [Ghostty](https://ghostty.org)                                | Terminal emulator: Catppuccin Mocha theme, hidden titlebar, global quick terminal (`cmd+\``)    |
| `git`      | [Git](https://git-scm.com) + [delta](https://github.com/dandavison/delta) | Shared Git settings and Catppuccin Mocha diffs                                              |
| `lazygit`  | [lazygit](https://github.com/jesseduffield/lazygit)           | Terminal UI for git                                                                             |
| `pi`       | [Pi](https://pi.dev)                                        | AI coding agent settings and default model                                                     |
| `rex`      | [Rex](https://www.superlogical.com/rex)                     | Terminal multiplexer configuration scaffold                                                    |
| `posting`  | [Posting](https://posting.sh)                                 | Terminal HTTP client, with Catppuccin Mocha theme                                                    |
| `tealdeer` | [tealdeer](https://github.com/tealdeer-rs/tealdeer)           | Cached tldr command examples with Catppuccin Mocha colors                                            |
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
| `aerospace`, `borders` | **macOS-only tools.** AeroSpace uses macOS window management and launches Rex by bundle ID; Rex windows are assigned to workspace 2. Its startup hook hardcodes `/opt/homebrew/bin/borders` (Apple Silicon Homebrew). |
| `zsh` | Zsh and most shell dependencies are available on macOS and Linux, but **this config assumes Apple Silicon Homebrew**: `/opt/homebrew/bin/brew` and plugin paths under `$HOMEBREW_PREFIX`. It also hardcodes `/Users/z/.local/bin` and sources `~/.local/bin/env`. Adapt these paths and install the dependencies before reuse, including on Intel Macs. |
| `ghostty` | Ghostty runs on macOS and Linux, but this config includes `macos-titlebar-style`, `macos-option-as-alt`, and a global `cmd+grave_accent` quick-terminal binding. Review platform-specific settings and shortcut support before using it on Linux. |
| `lazygit` | Cross-platform tool, **macOS-specific Stow layout**: `~/Library/Application Support/lazygit/config.yml`. On Linux, place the config under its Linux config directory (normally `~/.config/lazygit/config.yml`). Requires `delta` for the configured diff renderer. |
| `yazi` | Cross-platform tool, but configured helpers include Unix shell commands, `chmod`, `diff`, and SSHFS. SSHFS requires an OS-appropriate installation (including a FUSE implementation where needed); custom openers also require `tw` (tabiew). Not an unchanged native Windows configuration. |
| `atuin`, `bat`, `eza`, `git`, `pi`, `posting`, `tealdeer` | No hardcoded macOS executable or config path found in these packages. They are candidates for reuse on Linux with their dependencies installed. Shared Git settings require delta and its Catppuccin Mocha syntax theme. Pi still needs local authentication and access to the configured model. Tool availability on Windows does not make this Unix-style Stow layout a tested Windows setup. |
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
stow zsh ghostty    # or any other package names
```

### Theme

Active tool themes use Catppuccin Mocha, the darkest Catppuccin variant. This
covers Ghostty, Pi, Zsh/Powerlevel10k, fzf and completions, Atuin, bat, delta,
Lazygit, eza, Posting, tealdeer, Yazi, and Borders. The Neovim configuration is
excluded from this palette change. Existing wallpaper assets retain their
original colors and names; they are not recolored or selected automatically.

The previous Tokyo Night theme files remain available but are not selected.
The bat theme is vendored from
[catppuccin/bat](https://github.com/catppuccin/bat/tree/6810349b28055dce54076712fc05fc68da4b8ec0)
(revision `6810349b28055dce54076712fc05fc68da4b8ec0`), with its MIT license.
After adding themes, run `bat cache --build` so bat and delta discover them.

Open a new shell for Zsh/fzf colors; reload Ghostty's configuration, use
`/reload` in Pi, and restart other running TUIs to apply their new selections.

Theme selection and palette consistency tests:

```sh
python3 .tests/themes.test.py
```

### Notes

- **yazi**: run `ya pkg install` to install plugins from `package.toml`.
- **borders**: install with `brew tap felixkratz/formulae && brew install borders`. AeroSpace starts it via `after-startup-command`.
- **wallpapers**: set one from System Settings > Wallpaper, or `osascript -e 'tell application "System Events" to tell every desktop to set picture to "$HOME/Pictures/Wallpapers/omarchy-tokyo-night/0-winding-road.webp"'`.
- **lazygit**: the config lives under `~/Library/Application Support/lazygit`, the macOS default path.

### Rex

```sh
stow --simulate rex
stow rex
rex config check
```

### Pi

```sh
stow pi
```

Stows `pi/.pi/agent/settings.json` to `~/.pi/agent/settings.json`, with
`openai/gpt-6.1-sol` as the default model. The package also stows
`~/.pi/agent/themes/catppuccin-mocha.json` and selects the Catppuccin Mocha
color scheme for Pi's interface, syntax highlighting, diffs, and HTML exports.
Install Pi separately using the
[official instructions](https://pi.dev), then run `/login` to authenticate.
The Pi package list pins Superpowers v7.0.2 (skills and session bootstrap) and
Caveman v4.1.0 (skills only). The stowed `APPEND_SYSTEM.md` enables Caveman's
`ultracave` response style by default in every Pi session; "stop caveman"
switches that session back to normal prose. Caveman's separate CLI/agent-routing installer is
not run; package checkouts stay under Pi's local agent directory, outside Git.

If `settings.json` already exists, move it outside the repository before stowing
and merge any preferences you want to keep. Run `/reload` in an existing Pi
session after editing the config.

#### Keybindings

`Alt+Shift+Enter` queues a follow-up message after Pi finishes its current task,
replacing Pi's default `Alt+Enter` so AeroSpace can keep that shortcut for opening
Rex. The override lives in `pi/.pi/agent/keybindings.json`. Run `/reload` to
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
