---
id: stray-marks
subskill: 3
level: 2
title: Jump to three exact spots and delete a stray character
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
seq -f 'row %g: nothing to see here' 1 40 > ~/nvim-dojo/.expected/stray-marks.txt
sed -e '1s/^/@/' -e '27s/to see/to @see/' -e '40s/$/@/' ~/nvim-dojo/.expected/stray-marks.txt > ~/nvim-dojo/stray-marks.txt
```

## Goal

`~/nvim-dojo/stray-marks.txt` has 40 lines and three stray `@` characters: one in the
middle of line 27, one at the very end of the last line, and one as the very first
character of line 1. All three are gone and nothing else has changed.

## Check

```bash
diff -u ~/nvim-dojo/.expected/stray-marks.txt ~/nvim-dojo/stray-marks.txt
```

## Solution

1. `nvim ~/nvim-dojo/stray-marks.txt` `Enter`
2. `:27` `Enter` — jump to line 27
3. `f@` — jump forward to the next @ on this line
4. `x` — delete the character under the cursor
5. `G` — jump to the last line
6. `$` — jump to the end of the line
7. `x`
8. `gg` — jump to the first line
9. `0` — jump to the first column
10. `x`
11. `:wq` `Enter`

## Mistakes

- **Typed `27` and `Enter` without the colon.** A bare count before `Enter` moves
  down that many lines, so the cursor lands on line 28. Ask: "Which line number does
  the statusline show? What does the colon change?"
- **`f@` did nothing.** There is no `@` to the right of the cursor on that line. Ask:
  "Which line is the cursor on? Which direction does `f` search?"
- **`x` removed the wrong character.** The diff shows a missing letter and an `@`
  still there. Ask: "What was under the cursor when `x` was pressed?" Then `u`.
