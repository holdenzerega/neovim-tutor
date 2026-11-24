---
id: clipboard-in
subskill: 6
level: 2
title: Put a line from the system clipboard into a file
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/.expected/clipboard-in.conf <<'EOF'
app_env = staging
api_url = https://api.example.test
log_level = info
EOF
sed '2d' ~/nvim-dojo/.expected/clipboard-in.conf > ~/nvim-dojo/clipboard-in.conf
sed -n '2p' ~/nvim-dojo/.expected/clipboard-in.conf | wl-copy > /dev/null 2>&1
```

## Goal

The system clipboard holds one line, as if it had just been copied in a browser.
That line is line 2 of `~/nvim-dojo/clipboard-in.conf`, between the `app_env` and
`log_level` lines.

## Check

```bash
diff -u ~/nvim-dojo/.expected/clipboard-in.conf ~/nvim-dojo/clipboard-in.conf
```

## Solution

1. `nvim ~/nvim-dojo/clipboard-in.conf` `Enter`
2. `gg` — jump to the first line; Neovim reopens a file where the cursor last was
3. `"+p` — put from the plus register, which is the system clipboard; a whole copied line lands below the cursor line
4. `:wq` `Enter`

## Mistakes

- **Yanked or deleted something before pasting.** LazyVim sends every yank and
  delete to the system clipboard, so the copied line was replaced. Ask: "What was
  the last thing yanked or deleted? Where did that go?" Run setup again to refill
  the clipboard.
- **Pasted with the terminal's paste key in NORMAL mode.** The text went in at the
  cursor character and split line 1. Ask: "Where was the cursor? What is the
  difference between inserting characters at the cursor and putting a whole line?"
- **Used `"+P`.** The line landed above line 1. Ask: "Which side of the cursor line
  does capital `P` put on?"
