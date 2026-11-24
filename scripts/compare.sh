#!/usr/bin/env bash
# compare.sh <file>   diff the latest snapshot of <file> against the file on disk
# Prints the diff, then CHANGED or UNCHANGED, and OPEN if Neovim still has the file open.
set -uo pipefail
f="$(realpath "$1")"
key="$(printf %s "$f" | tr / %)"
snap="$(ls -1 "$HOME/nvim-dojo/snapshots/$key".* 2>/dev/null | tail -1)"
[ -n "$snap" ] || { echo "no snapshot of $f; run snapshot.sh first" >&2; exit 2; }
echo "snapshot: $snap"
if diff -u --label before --label "on disk" "$snap" "$f"; then echo UNCHANGED; else echo CHANGED; fi
# Neovim names a file's swap file after its path, with / replaced by %.
if ls "${XDG_STATE_HOME:-$HOME/.local/state}/nvim/swap" 2>/dev/null | grep -qF "$key.sw"; then
  echo "OPEN: Neovim still has this file open"
fi
