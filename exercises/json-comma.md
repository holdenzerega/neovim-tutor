---
id: json-comma
subskill: 4
level: 2
title: Move a comma to the right side of a brace
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/.expected/json-comma.json <<'EOF'
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
  },
  "telemetry": {
    "enabled": false
  }
}
EOF
sed '27s/},/,}/' ~/nvim-dojo/.expected/json-comma.json > ~/nvim-dojo/json-comma.json
```

## Goal

`~/nvim-dojo/json-comma.json` is valid JSON again. Line 27 closes the `"git"` block
and has its comma on the wrong side of the brace: it reads `,}` and must read `},`.

## Check

```bash
jq -e . ~/nvim-dojo/json-comma.json > /dev/null   # must parse as JSON
diff -u ~/nvim-dojo/.expected/json-comma.json ~/nvim-dojo/json-comma.json
```

## Solution

1. `nvim ~/nvim-dojo/json-comma.json` `Enter`
2. `:27` `Enter` — jump to line 27
3. `cc` — clear the line and enter INSERT; the indent is kept
4. `},` — brace first, then the comma
5. `Esc`
6. `:wq` `Enter`

## Mistakes

- **Typed `,}` again.** `jq` reports a parse error near line 27. Ask: "What does a
  comma separate in JSON: does it belong before the closing brace, or between the
  brace and the next key?"
- **Ran `:27` with the cursor in a popup or message window.** The file is unchanged.
  Ask: "Which window is the cursor in? What name does the statusline show?"
- **Typed `},` without `cc`.** In NORMAL mode `}` jumps a paragraph and `,` repeats a
  character search, so nothing was typed. Ask: "What did the bottom-left corner say
  when the brace was typed?"
