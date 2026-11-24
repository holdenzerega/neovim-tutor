#!/usr/bin/env bash
# check.sh <id>   run the Check block of exercises/<id>.md
# Prints the block's output, then PASS <id> (exit 0) or FAIL <id> (exit 1).
set -uo pipefail
file="$(dirname "$0")/../exercises/$1.md"
[ -f "$file" ] || { echo "no exercise '$1'; run setup.sh with no id to list them" >&2; exit 2; }
block="$(awk '$0 == "## Check" { s = 1; next } s && /^```/ { if (++c == 2) exit; next } c == 1' "$file")"
if bash -euo pipefail -c "$block"; then
  echo "PASS $1"
else
  echo "FAIL $1"
  exit 1
fi
