---
id: global-delete
subskill: 7
level: 5
title: Delete every matching line within a keystroke budget
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
for i in $(seq 1 40); do
  if [ $((i % 3)) -eq 0 ]; then echo "DEBUG cache probe $i"; else echo "INFO request $i served"; fi
done > ~/nvim-dojo/global-delete.log
grep -v '^DEBUG' ~/nvim-dojo/global-delete.log > ~/nvim-dojo/.expected/global-delete.log
```

## Goal

`~/nvim-dojo/global-delete.log` has 40 lines, 13 of them starting with `DEBUG`. Those
13 are gone and the 27 `INFO` lines remain, in their original order.

Budget: 12 keystrokes, counting `Enter`, between opening the file and `:w`.

## Check

```bash
diff -u ~/nvim-dojo/.expected/global-delete.log ~/nvim-dojo/global-delete.log
```

## Solution

1. `nvim ~/nvim-dojo/global-delete.log` `Enter`
2. `:g/^DEBUG/d` `Enter` — on every line that matches the pattern, run the d command
3. `:wq` `Enter`

A sound explanation says that g marks every line matching the pattern between the
slashes and then runs the command after the second slash on each marked line, and
that d as a command deletes a whole line.

## Mistakes

- **Typed `:g/DEBUG/` with no command after it.** Neovim only listed the matching
  lines. Ask: "What does `:g` do with the lines it finds when no command follows the
  pattern?"
- **Used `:%s/DEBUG.*//`.** The diff shows 13 empty lines left behind. Ask: "What
  remains where each line was? Which command removes a whole line?"
- **Deleted line by line with `dd` and `.`.** It works but takes far more than 12
  keystrokes. Ask: "What do the 13 lines have in common that a single command could
  use?"
