# Dotfiles

Personal macOS-first dotfiles managed with GNU Stow and themed with the Tokyo
Night "night" palette. These instructions apply to this repository, not to Pi
globally. This file stays at the repository root; do not stow it into
`~/.pi/agent/AGENTS.md`.

## Repository conventions

- Each utility package mirrors its target layout under `$HOME`. Repository
  metadata such as `.git/` and `.atuin/` is not a Stow package.
- Edit the source configuration in this repository rather than its symlinked
  home-directory destination.
- Keep credentials, sessions, caches, installed plugins, and runtime state out
  of Git. Review Pi settings changes for generated fields before committing.
- Inspect the working tree first and preserve unrelated changes.
- Follow existing configuration style and use Tokyo Night "night" colors for
  themes. Keep changes focused; do not commit or push unless requested.

## Autonomy and applying changes

- Make requested edits and run non-destructive validation without asking for
  approval at every step.
- Apply straightforward Stow changes needed for the task after a successful
  simulation, provided there are no conflicts.
- Reload affected configurations when safe and relevant to the requested task.
- Ask before overwriting conflicting files, deleting unrelated data, or applying
  changes that could interrupt the active terminal session.
- These rules are working guidance, not a technical permission boundary.

## Platform boundaries

The toolset is not exclusively macOS-only. Distinguish upstream tool support
from portability of this repository's configuration. See README.md's platform
support table for user-facing details; keep it in sync with platform changes.

- **macOS-only tools:** `aerospace` (AeroSpace) and `borders` (JankyBorders).
  AeroSpace uses `open -na Ghostty` and starts Borders through the Apple Silicon
  Homebrew path `/opt/homebrew/bin/borders`.
- **Zsh is currently Apple Silicon Homebrew-specific:** `.zshrc` invokes
  `/opt/homebrew/bin/brew`, sources plugins under `$HOMEBREW_PREFIX`, hardcodes
  `/Users/z/.local/bin`, and sources `~/.local/bin/env`. Zsh itself is not
  macOS-only. Intel Macs and Linux require path/dependency adaptation.
- **Ghostty supports macOS and Linux**, but this config includes `macos-*`
  settings and a global Command-key quick-terminal binding. Review these when
  targeting Linux; do not assume identical shortcut support.
- **Lazygit is cross-platform**, but its package targets the macOS directory
  `~/Library/Application Support/lazygit`. Linux normally uses
  `~/.config/lazygit`; do not claim the current Stow layout covers both.
- **tmux targets Unix-like environments**, including macOS and Linux. Its
  sessionizer requires Bash, zoxide, and fzf; popups invoke Lazygit and Pi.
  Clipboard backends are platform-dependent. Native Windows is not the target.
- **Yazi is cross-platform**, but custom helpers assume Unix commands and
  SSHFS/FUSE support. Custom data-file openers require tabiew (`tw`).
- **Wallpapers are portable assets**; System Settings and `osascript` wallpaper
  instructions are macOS-only.
- **Other packages** (`atuin`, `bat`, `eza`, `git`, `pi`,
  `posting`, `tealdeer`) have no identified hardcoded macOS executable/config
  path. Do not equate this with tested Linux or native Windows support.
  Dependencies, authentication, model access, fonts, and terminal capabilities
  still need to be available. Git/Lazygit use delta; tmux clock removal
  is a macOS-oriented UI choice, not an OS restriction.

Do not introduce additional hardcoded machine paths unnecessarily. If adding
platform-specific behavior, document it and use OS guards or separate config
where appropriate. Do not turn a documentation task into an unsolicited
cross-platform rewrite.

## Verification

- Read relevant configuration and scripts, including hidden package paths.
- Simulate Stow operations before applying them; select packages explicitly.
- Run relevant syntax/configuration checks when available and `git diff --check`.
- Report what was checked, any untested platform assumptions, and whether a
  reload or restart is needed. Do not claim cross-platform runtime validation
  based only on static inspection.
