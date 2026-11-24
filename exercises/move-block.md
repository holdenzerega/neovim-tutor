---
id: move-block
subskill: 7
level: 2
title: Select two lines, move them, and indent them
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/move-block.txt <<'EOF'
== Done ==
- write the parser
- fix the login bug
- add retry logic

== To do ==
- ship version 2
EOF
cat > ~/nvim-dojo/.expected/move-block.txt <<'EOF'
== Done ==
- write the parser

== To do ==
- ship version 2
  - fix the login bug
  - add retry logic
EOF
```

## Goal

In `~/nvim-dojo/move-block.txt` the two items `- fix the login bug` and
`- add retry logic` have moved from Done to the end of To do, below
`- ship version 2`, and are indented two spaces as its sub-items.

## Check

```bash
diff -u ~/nvim-dojo/.expected/move-block.txt ~/nvim-dojo/move-block.txt
```

## Solution

1. `nvim ~/nvim-dojo/move-block.txt` `Enter`
2. `:3` `Enter`
3. `V` — start selecting whole lines; the corner shows V-LINE
4. `j` — extend the selection one line down
5. `d` — cut the selected lines
6. `G` — last line
7. `p` — put the two lines below it; the cursor lands on the first of them
8. `V`
9. `j`
10. `>` — indent the selection one level; LazyVim keeps the lines selected
11. `Esc` — drop the selection
12. `:wq` `Enter`

## Mistakes

- **Pressed `v` instead of `V`.** Only part of each line was cut and the rest was
  left behind. Ask: "What does the bottom-left corner say: VISUAL or V-LINE? What
  was highlighted?"
- **Forgot `j`.** Only one item moved. Ask: "How many lines were highlighted when `d`
  was pressed?"
- **Typed `:wq` with the lines still selected.** The command line showed `:'<,'>wq`
  and Neovim asked `Write partial file?`. Ask: "What does the bottom-left corner
  say? What ends a selection?" Answer the prompt with `n`, then `Esc`.
