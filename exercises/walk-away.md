---
id: walk-away
subskill: 1
level: 4
title: Type in the wrong mode, then leave without saving the damage
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/walk-away.txt <<'EOF'
service: billing
owner: platform team
status: broken
EOF
sed 's/broken/fixed/' ~/nvim-dojo/walk-away.txt > ~/nvim-dojo/.expected/walk-away.txt
```

## Goal

Line 3 of `~/nvim-dojo/walk-away.txt` reads `status: fixed`, nothing else in the file
has changed, and Neovim is closed.

Before fixing anything: open the file and type `hello world` straight away, without
pressing any other key first. Get rid of whatever that did, then make the fix.

## Check

```bash
diff -u ~/nvim-dojo/.expected/walk-away.txt ~/nvim-dojo/walk-away.txt
# A swap file means Neovim still has the file open: the count printed must be 0.
! ls "${XDG_STATE_HOME:-$HOME/.local/state}/nvim/swap" 2>/dev/null | grep -c 'nvim-dojo%walk-away\.txt\.sw'
```

## Solution

1. `nvim ~/nvim-dojo/walk-away.txt` `Enter`
2. `hello world` — typed in NORMAL mode: h, e, l, l move the cursor, o opens a new line, and the rest lands in the file as text
3. `Esc` — leave INSERT
4. `:q!` `Enter` — quit and discard every unsaved change
5. `nvim ~/nvim-dojo/walk-away.txt` `Enter`
6. `:3` `Enter`
7. `cc` — clear the line and enter INSERT
8. `status: fixed`
9. `Esc`
10. `:wq` `Enter`

## Mistakes

- **Saved the damage with `:wq`.** The diff shows an extra ` world` line. Ask: "Which
  of `:q`, `:q!` and `:wq` leaves the file on disk exactly as it was?"
- **`:q` refused with `E37: No write since last change`.** Ask: "What is Neovim
  protecting here? What does adding `!` tell it?"
- **Typed `:q!` while still in INSERT.** The characters went into the buffer. Ask:
  "What does the bottom-left corner say? Which key has to come before the colon?"
