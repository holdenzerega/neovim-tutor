#!/usr/bin/env bash
# setup.sh <id>   run the Setup block of exercises/<id>.md
# setup.sh        list every exercise: subskill, level, id, title
set -euo pipefail
dir="$(dirname "$0")/../exercises"

if [ $# -eq 0 ]; then
  for f in "$dir"/*.md; do
    awk '/^---$/ { if (++n == 2) exit; next }
         { i = index($0, ": "); v[substr($0, 1, i - 1)] = substr($0, i + 2) }
         END { printf "%s\t%s\t%s\t%s\n", v["subskill"], v["level"], v["id"], v["title"] }' "$f"
  done | sort
  exit
fi

file="$dir/$1.md"
[ -f "$file" ] || { echo "no exercise '$1'; run setup.sh with no id to list them" >&2; exit 2; }
block="$(awk '$0 == "## Setup" { s = 1; next } s && /^```/ { if (++c == 2) exit; next } c == 1' "$file")"
bash -euo pipefail -c "$block"
echo "SETUP OK $1"
