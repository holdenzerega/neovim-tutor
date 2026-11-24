---
id: undo-reload
subskill: 8
level: 3
title: Undo, redo, and reload from disk before making one fix
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/undo-reload.txt <<'EOF'
alpha
bravo
charlie
state = BROKEN
delta
EOF
sed 's/BROKEN/OK/' ~/nvim-dojo/undo-reload.txt > ~/nvim-dojo/.expected/undo-reload.txt
```

## Goal

On disk, `~/nvim-dojo/undo-reload.txt` differs from its starting state in one place
only: line 4 reads `state = OK`.

On the way there, practise two recoveries in the open file. First delete the first
three lines one at a time and bring them all back with undo. Then make any unsaved
change and throw it away by reloading the file from disk. Only then make the fix.

## Check

```bash
diff -u ~/nvim-dojo/.expected/undo-reload.txt ~/nvim-dojo/undo-reload.txt
```

## Solution

1. `nvim ~/nvim-dojo/undo-reload.txt` `Enter`
2. `gg` — jump to the first line; Neovim reopens a file where the cursor last was
3. `dd` — delete alpha
4. `dd`
5. `dd`
6. `u` — undo the last change
7. `u`
8. `u` — all three lines are back
9. `Ctrl-r` — redo: alpha is deleted again
10. `u`
11. `x` — an unsaved change
12. `:e!` `Enter` — reload the file from disk, discarding everything unsaved
13. `:4` `Enter`
14. `$` — end of the line, on the word BROKEN
15. `ciw`
16. `OK`
17. `Esc`
18. `:wq` `Enter`

## Mistakes

- **Wrote the file in the middle of the damage.** After a `:w`, reloading brings back
  the damaged version, because that is now what is on disk. Ask: "Which version
  does `:e!` read? Which command still walks back through changes after a save?"
- **Pressed `U` instead of `u`.** Capital `U` restores a single line in its own way
  and confuses the undo history. Ask: "Is Caps Lock on? What does `Ctrl-r` do after
  one `u` too many?"
- **Stopped undoing too early or too late.** The diff shows missing lines. Ask: "How
  many changes were made, and how many have been undone?"
