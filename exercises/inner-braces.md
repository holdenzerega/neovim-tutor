---
id: inner-braces
subskill: 5
level: 5
title: Replace everything inside one pair of braces within a budget
---

## Setup

```bash
mkdir -p ~/nvim-dojo
cat > ~/nvim-dojo/inner-braces.json <<'EOF'
{
  "name": "demo",
  "scripts": {
    "build": "make all",
    "test": "make check",
    "lint": "make lint"
  },
  "private": true
}
EOF
```

## Goal

In `~/nvim-dojo/inner-braces.json` the `"scripts"` object holds exactly one entry,
`"start": "node ."`. `"name"` and `"private"` are unchanged and the file is valid
JSON.

Budget: 8 keystrokes plus the replacement text, between opening the file and `:w`.

## Check

```bash
jq -e '. == {"name": "demo", "scripts": {"start": "node ."}, "private": true}' ~/nvim-dojo/inner-braces.json
```

## Solution

1. `nvim ~/nvim-dojo/inner-braces.json` `Enter`
2. `:4` `Enter` — any line inside the scripts braces
3. `ci{` — change everything inside the nearest pair of braces around the cursor
4. `"start": "node ."`
5. `Esc`
6. `:wq` `Enter`

A sound explanation says that c is the change operator, that the object after it
means the inside of the innermost braces enclosing the cursor, and that the cursor
therefore has to be between the scripts braces and not merely somewhere in the file.

## Mistakes

- **Ran `ci{` with the cursor on line 2 or line 8.** The innermost braces around
  those lines are the outer pair, so the whole file was emptied. Ask: "Which pair of
  braces is the nearest one around the cursor?" Then `u`.
- **Left a trailing comma after the new entry.** `jq` reports a parse error. Ask:
  "What comes after the last entry of a JSON object?"
- **Deleted the three lines with `dd` and typed a new one.** It works but breaks the
  budget. Ask: "Which single object covers all three lines at once?"
