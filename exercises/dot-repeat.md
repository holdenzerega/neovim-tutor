---
id: dot-repeat
subskill: 4
level: 4
title: Make the same small edit on four lines
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/dot-repeat.css <<'EOF'
.button {
  color: white
  background: teal
  padding: 4px 8px
  border-radius: 4px
}
EOF
sed '2,5s/$/;/' ~/nvim-dojo/dot-repeat.css > ~/nvim-dojo/.expected/dot-repeat.css
```

## Goal

Each of the four declarations inside the braces of `~/nvim-dojo/dot-repeat.css` ends
with a semicolon. The lines with the braces are unchanged.

## Check

```bash
diff -u ~/nvim-dojo/.expected/dot-repeat.css ~/nvim-dojo/dot-repeat.css
```

## Solution

1. `nvim ~/nvim-dojo/dot-repeat.css` `Enter`
2. `:2` `Enter`
3. `A` — append at the end of the line
4. `;`
5. `Esc`
6. `j` — down one line
7. `.` — repeat the last change
8. `j`
9. `.`
10. `j`
11. `.`
12. `:wq` `Enter`

## Mistakes

- **Pressed `.` without moving down.** One line ends in `;;`. Ask: "What does `.`
  repeat, and on which line?" Then `u`.
- **Added a semicolon to a brace line.** Ask: "Which lines did the goal name?"
- **Used `i` instead of `A`.** The semicolon landed at the start or middle of the
  line. Ask: "Where does `i` start typing, and where does `A`?"
