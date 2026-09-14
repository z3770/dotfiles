#!/usr/bin/env bash
# Fuzzy-pick a directory from zoxide's history (or type a new path) and jump
# to it as a tmux session, creating one if it doesn't exist yet.
set -euo pipefail

selected=$(zoxide query -l | fzf --prompt="Session > ")
[ -z "${selected:-}" ] && exit 0

session_name=$(basename "$selected" | tr '.:' '__')

if ! tmux has-session -t "=$session_name" 2>/dev/null; then
  tmux new-session -ds "$session_name" -c "$selected"
fi

if [ -n "${TMUX:-}" ]; then
  tmux switch-client -t "=$session_name"
else
  tmux attach-session -t "=$session_name"
fi
