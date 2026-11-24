---
id: checklist
subskill: 4
level: 3
title: Repair a checklist with small line edits
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/checklist.txt <<'EOF'
Release checklist
run the tests
bump the versionn
obsolete step
push the tag
EOF
cat > ~/nvim-dojo/.expected/checklist.txt <<'EOF'
Release checklist
update the changelog
run the tests
bump the version
push the tag
announce the release
EOF
```

## Goal

`~/nvim-dojo/checklist.txt` reads, in this order: the title, `update the changelog`,
`run the tests`, `bump the version` (one `n`), `push the tag`,
`announce the release`. The `obsolete step` line is gone.

## Check

```bash
diff -u ~/nvim-dojo/.expected/checklist.txt ~/nvim-dojo/checklist.txt
```

## Solution

1. `nvim ~/nvim-dojo/checklist.txt` `Enter`
2. `:2` `Enter`
3. `O` — open a new line above and enter INSERT
4. `update the changelog`
5. `Esc`
6. `:4` `Enter` — the versionn line has moved down to line 4
7. `$` — end of the line, on the extra n
8. `x` — delete that character
9. `:5` `Enter` — the obsolete step
10. `dd` — delete the line; the cursor is now on the last line
11. `o` — open a new line below and enter INSERT
12. `announce the release`
13. `Esc`
14. `:wq` `Enter`

## Mistakes

- **Used `o` on line 2 instead of `O`.** The changelog line landed below
  `run the tests`. Ask: "Which of `o` and `O` opens the line above the cursor?"
- **Stayed in INSERT and typed `dd` or `:5`.** Those characters are now in the file.
  Ask: "What has to be pressed between typing text and giving a command?"
- **`x` took off more than the one extra `n`.** Ask: "What was under the cursor? What
  does `u` do, and what brings a change back after one `u` too many?"
