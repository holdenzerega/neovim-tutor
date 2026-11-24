---
id: popup-escape
subskill: 1
level: 3
title: Get out of the message window and edit the real file
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/popup-escape.txt <<'EOF'
line 1: keep
line 2: keep
line 3: DELETE THIS LINE
line 4: keep
EOF
sed '3d' ~/nvim-dojo/popup-escape.txt > ~/nvim-dojo/.expected/popup-escape.txt
```

## Goal

Line 3 of `~/nvim-dojo/popup-escape.txt` is gone, the file is saved, and Neovim is
closed.

The route matters here: after opening the file, save it once and open the message
history. The history takes over the bottom of the screen and the cursor moves into
it. The edit has to happen in the file, not in that window.

## Check

```bash
diff -u ~/nvim-dojo/.expected/popup-escape.txt ~/nvim-dojo/popup-escape.txt
# A swap file means Neovim still has the file open: the count printed must be 0.
! ls "${XDG_STATE_HOME:-$HOME/.local/state}/nvim/swap" 2>/dev/null | grep -c 'nvim-dojo%popup-escape\.txt\.sw'
```

## Solution

1. `nvim ~/nvim-dojo/popup-escape.txt` `Enter`
2. `:w` `Enter` — saving leaves a message in the history
3. `:messages` `Enter` — the history opens at the bottom and the cursor moves into it
4. `q` — closes that window; the cursor is back in the file
5. `:3` `Enter` — line 3 of the file
6. `dd` — delete the line
7. `:wq` `Enter`

## Mistakes

- **Ran `:3` and `dd` with the cursor still in the message window.** The file is
  unchanged and Neovim complained that the buffer is not modifiable. Ask: "Which
  window is the cursor in? What name does the statusline show for it?"
- **Pressed `q` when no popup was open.** The statusline shows `recording @` and
  later keys behave oddly, because `q` starts recording a macro. Ask: "What does the
  statusline say? Which key stops what `q` started?"
- **Left with `:q!` after deleting the line.** The diff shows line 3 still there. Ask:
  "What does the `!` in `:q!` throw away?"
