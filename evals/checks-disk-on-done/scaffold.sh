#!/usr/bin/env bash
# Plant the file this case is about and snapshot it, as the tutor would have.
set -eu
mkdir -p "$(dirname ~/work/settings.json)"
cat > ~/work/settings.json <<'FILE'
{
  "editor": {
    "theme": "tokyonight",
    "fontSize": 13,
    "lineNumbers": true,
    "wordWrap": false
  },
  "terminal": {
    "shell": "bash",
    "scrollback": 10000,
    "cursorBlink": true
  },
  "files": {
    "autoSave": false,
    "trimTrailingWhitespace": true,
    "exclude": [
      ".git",
      "node_modules",
      "dist"
    ]
  },
  "git": {
    "autoFetch": true,
    "confirmSync": false,
    "defaultBranch": "main",
    "pruneOnFetch": true
  ,}
  "telemetry": {
    "enabled": false
  }
}
FILE
bash "$(dirname "$0")/../../scripts/snapshot.sh" ~/work/settings.json > /dev/null
