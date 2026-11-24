---
id: first-save
subskill: 1
level: 2
title: Add a line, save, and get back to the shell
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/.expected/first-save.txt <<'EOF'
mode when Neovim opens: NORMAL
mode after pressing i: INSERT
mode after pressing Esc: NORMAL
EOF
sed '$d' ~/nvim-dojo/.expected/first-save.txt > ~/nvim-dojo/first-save.txt
```

## Goal

`~/nvim-dojo/first-save.txt` has a third line reading exactly
`mode after pressing Esc: NORMAL`, the file is saved, and Neovim is closed so the
terminal shows a shell prompt again.

## Check

```bash
diff -u ~/nvim-dojo/.expected/first-save.txt ~/nvim-dojo/first-save.txt
# A swap file means Neovim still has the file open: the count printed must be 0.
! ls "${XDG_STATE_HOME:-$HOME/.local/state}/nvim/swap" 2>/dev/null | grep -c 'nvim-dojo%first-save\.txt\.sw'
```

## Solution

1. `nvim ~/nvim-dojo/first-save.txt` `Enter` — typed at the shell prompt; the bottom-left corner now shows NORMAL
2. `G` — jump to the last line
3. `o` — open a new line below; the corner now shows INSERT
4. `mode after pressing Esc: NORMAL` — typed as text
5. `Esc` — the corner shows NORMAL again
6. `:wq` `Enter` — write the file and quit; the shell prompt is back

## Mistakes

- **Typed the sentence without pressing `o` first.** The letters ran as NORMAL-mode
  commands, so the diff shows mangled lines instead of one new line. Ask: "What did
  the bottom-left corner say when the first letter was typed?"
- **Typed `:wq` while still in INSERT.** The file ends in `:wq` and the swap count is 1
  because Neovim is still open. Ask: "Is the terminal showing a shell prompt or a
  statusline right now? Which key leaves INSERT?"
- **Quit without writing (`:q!`).** The diff shows the third line missing. Ask: "Which
  of `:q!` and `:wq` puts the buffer on disk?"
