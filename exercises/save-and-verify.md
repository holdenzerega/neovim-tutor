---
id: save-and-verify
subskill: 8
level: 2
title: Write the buffer and confirm the change reached the disk
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/save-and-verify.txt <<'EOF'
changed in the buffer: yes
written to disk: no
EOF
sed '2s/no$/yes/' ~/nvim-dojo/save-and-verify.txt > ~/nvim-dojo/.expected/save-and-verify.txt
```

## Goal

Line 2 of `~/nvim-dojo/save-and-verify.txt` reads `written to disk: yes` on disk.
Neovim stays open: the point is that a change exists only in the buffer until it
is written, and that the check reads the disk, not the screen.

## Check

```bash
diff -u ~/nvim-dojo/.expected/save-and-verify.txt ~/nvim-dojo/save-and-verify.txt
```

## Solution

1. `nvim ~/nvim-dojo/save-and-verify.txt` `Enter`
2. `:2` `Enter`
3. `$` — end of the line, on the word no
4. `ciw` — change the word under the cursor
5. `yes`
6. `Esc`
7. `:w` `Enter` — write the buffer; a message reports the file as written
8. `:messages` `Enter` — the message history opens with that report in it
9. `q` — close the history; Neovim stays open on the file

## Mistakes

- **Said done before `:w`.** The screen shows `yes` but the diff still shows `no`.
  Ask: "Where does the change live right now: in the buffer or in the file? What
  moves it to the file?"
- **Typed `:w` while still in INSERT.** The line reads `yes:w`. Ask: "What did the
  bottom-left corner say? Which key was missing?"
- **Pressed `q` with no message window open.** The statusline shows `recording @`.
  Ask: "What did `q` start? Which key stops it?"
