#!/usr/bin/env bash
# snapshot.sh <file>   copy <file> into ~/nvim-dojo/snapshots/ before an edit; prints the copy's path
set -euo pipefail
f="$(realpath "$1")"
[ -f "$f" ] || { echo "no such file: $1" >&2; exit 2; }
dir="$HOME/nvim-dojo/snapshots"
mkdir -p "$dir"
snap="$dir/$(printf %s "$f" | tr / %).$(date +%Y%m%d-%H%M%S)"
cp -p "$f" "$snap"
echo "$snap"
