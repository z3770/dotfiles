# Neovim configuration

These instructions apply to this configuration directory and its descendants.
Also follow the repository-wide instructions in `../../../AGENTS.md`.

## Goal and current state

- Build a personal Neovim configuration from
  [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), not LazyVim.
- Start clean: Neovim and the previous LazyVim setup were removed. Do not assume
  the editor, plugins, language servers, or formatters are installed.
- This directory contains the Kickstart template. Customize configuration and
  install tools only when requested; these instructions are not permission to bootstrap them.
- Read the current Kickstart template before adopting it. Record the upstream
  revision in `Changelog.md`, not in `init.lua` or a separate provenance file,
  and retain its license when incorporating source code.

## Change log

- Record every change to this Neovim configuration in `Changelog.md` in this
  directory, including changes to instructions and documentation.
- Update the log as part of the same task without waiting for a reminder.
- Add concise entries describing what changed and why, and the checks performed.
  Preserve existing history; distinguish completed changes from planned work.
- Keep upstream revision information in this log. Do not add revision comments
  to `init.lua` or create a separate `UPSTREAM.md`.

## Configuration principles

- Keep the configuration understandable, with concise comments explaining
  non-obvious choices. Prefer small, explicit Lua modules as it grows.
- Do not introduce a LazyVim dependency or use `LazyVim.*` helpers.
- Choose plugins deliberately; do not restore the previous plugin set wholesale.
- Use Tokyo Night "night" throughout. Retain the previous preference for
  transparent editor, floating-window, and statusline backgrounds when practical.
- Desired integrations to implement when requested: Oil file navigation and a
  persistent Pi terminal split toggled by `<leader>ap` from the project root.
- Pi must receive Escape unchanged. Use `Ctrl+\\`, then `Ctrl+n` to leave terminal
  input; hiding the Pi pane must not terminate its process.
- Keep paths portable and derive project roots without LazyVim.
- Keep credentials, installed plugins, caches, sessions, and other generated
  runtime data outside the repository. Track the chosen plugin manager's lockfile.

## Stow layout and scope

- Package: `neovim/`; configuration source: `neovim/.config/nvim/`.
- From the repository root, `stow neovim` targets `~/.config/nvim`.
- Keep this file here, not at `neovim/AGENTS.md`: the latter would be stowed to
  `~/AGENTS.md` and unintentionally apply instructions outside this project.
- To load these instructions automatically, start Pi in this source directory.
  When starting Pi at the repository root, explicitly ask it to read this file.

## Verification

- Inspect the working tree and preserve unrelated changes.
- Simulate Stow before applying it; do not overwrite conflicting configurations.
- Once Neovim is available, check Lua syntax, headless startup, and relevant
  mappings. Do not launch a real Pi request just to test a terminal toggle.
- Run `git diff --check`. Distinguish static checks from interactive validation.
- Do not commit or push unless requested.
