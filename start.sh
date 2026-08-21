#!/usr/bin/env bash
# Start (or attach to) preset tmux sessions: NOTES and MISC.
# Idempotent: only creates a session if it does not already exist.
#
# This script lives in the tmux config git repo, but is expected to be
# symlinked onto PATH so it can be invoked as `tmux-start` from anywhere:
#
#     ln -sf ~/.config/tmux/start.sh ~/.local/bin/tmux-start
#
# Re-run that command on any new machine after cloning this repo.

set -euo pipefail

SESSIONS=(NOTES MISC)

for session in "${SESSIONS[@]}"; do
    if ! tmux has-session -t="$session" 2>/dev/null; then
        tmux new-session -d -s "$session"
    fi
done

# Attach to NOTES (or switch to it if already inside tmux).
if [ -n "${TMUX:-}" ]; then
    tmux switch-client -t NOTES
else
    tmux attach-session -t NOTES
fi
