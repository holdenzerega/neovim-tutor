---
id: help-yourself
subskill: 8
level: 4
title: Find an untaught command in the built-in help and use it
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/help-yourself.txt <<'EOF'
The command for this task is not taught in this course.
Find it in the built-in help, then use it.
first half of the sentence,
second half of the sentence.
EOF
sed -e '3s/$/ second half of the sentence./' -e '4d' ~/nvim-dojo/help-yourself.txt > ~/nvim-dojo/.expected/help-yourself.txt
```

## Goal

Lines 3 and 4 of `~/nvim-dojo/help-yourself.txt` are joined into the single line
`first half of the sentence, second half of the sentence.` with one space at the
join.

The command that joins lines is not part of this course. Find it in Neovim's own
help, starting from `:help join`, then close the help and use it.

## Check

```bash
diff -u ~/nvim-dojo/.expected/help-yourself.txt ~/nvim-dojo/help-yourself.txt
```

## Solution

1. `nvim ~/nvim-dojo/help-yourself.txt` `Enter`
2. `:help join` `Enter` — the help opens in a window above the file, in the section on joining lines
3. `:q` `Enter` — close the window the cursor is in, which is the help
4. `:3` `Enter`
5. `J` — join this line with the next, with one space between them
6. `:wq` `Enter`

## Mistakes

- **Tried to edit with the cursor still in the help window.** Neovim refused because
  help is not modifiable. Ask: "Which window is the cursor in? How is a window
  closed?"
- **Joined from the wrong line.** Line 2 and 3, or 4 and nothing, were joined. Ask:
  "Which line does the join start from, and which one does it pull up?" Then `u`.
- **Could not find the command in the help text.** Ask: "What is the heading of the
  section on screen? What do the entries just above and below the cursor describe?"
