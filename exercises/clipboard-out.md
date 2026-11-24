---
id: clipboard-out
subskill: 6
level: 3
title: Copy a line out of Neovim to the system clipboard
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/clipboard-out.conf <<'EOF'
[core]
editor = nvim
[remote "origin"]
url = git@example.test:team/shop.git
fetch = +refs/heads/*:refs/remotes/origin/*
EOF
sed -n '4p' ~/nvim-dojo/clipboard-out.conf > ~/nvim-dojo/.expected/clipboard-out.txt
echo 'nothing copied yet' | wl-copy > /dev/null 2>&1
```

## Goal

The system clipboard holds the whole `url = ...` line of
`~/nvim-dojo/clipboard-out.conf`, ready to paste into another program. The file
itself does not change. The check reads the clipboard, so nothing else may be
copied before saying done.

## Check

```bash
# wl-paste prints the system clipboard; trailing newlines are normalised to one.
diff -u ~/nvim-dojo/.expected/clipboard-out.txt <(echo "$(wl-paste -n)")
```

## Solution

1. `nvim ~/nvim-dojo/clipboard-out.conf` `Enter`
2. `/url` `Enter` — jump to the line
3. `"+yy` — yank the line into the plus register, which is the system clipboard
4. `:q` `Enter`

On LazyVim a plain yy reaches the clipboard too, because LazyVim sets the clipboard
option to unnamedplus. Naming the register works in any Vim.

## Mistakes

- **Dragged with the mouse and used the terminal's copy key.** The clipboard holds
  line numbers or nothing at all. Ask: "What extra characters came along? Which
  register is the system clipboard?"
- **Yanked a different line.** The diff shows which one. Ask: "Which line was the
  cursor on when the yank happened?"
- **Copied something else before the check.** Ask: "What is on the clipboard now?"
  Yank the line again.
