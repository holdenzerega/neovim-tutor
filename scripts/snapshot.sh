#!/usr/bin/env bash
# snapshot.sh <file>   copy <file> into ~/nvim-dojo/snapshots/ before an edit; prints the copy's path
set -euo pipefail
f="$(realpath "$1")"
[ -f "$f" ] || { echo "no such file: $1" >&2; exit 2; }
# The snapshot tree mirrors the file's own path, so the printed path reads as a plain path.
dir="$HOME/nvim-dojo/snapshots$(dirname "$f")"
mkdir -p "$dir"
snap="$dir/$(basename "$f").$(date +%Y%m%d-%H%M%S)"
cp -p "$f" "$snap"
echo "${snap/#"$HOME"/\~}"
