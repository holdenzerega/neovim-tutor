---
id: text-objects
subskill: 5
level: 2
title: Change a string, change a word, delete a block
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/text-objects.conf <<'EOF'
name = "old-service"
mode = debug

# temporary override
# remove before release
verbose = true

port = 8080
EOF
cat > ~/nvim-dojo/.expected/text-objects.conf <<'EOF'
name = "billing"
mode = release

port = 8080
EOF
```

## Goal

In `~/nvim-dojo/text-objects.conf` the name is `"billing"` (quotes kept), the mode is
`release`, and the three-line block about the temporary override is gone together
with one of the blank lines around it, leaving a single blank line before `port`.

## Check

```bash
diff -u ~/nvim-dojo/.expected/text-objects.conf ~/nvim-dojo/text-objects.conf
```

## Solution

1. `nvim ~/nvim-dojo/text-objects.conf` `Enter`
2. `gg` — jump to the first line; Neovim reopens a file where the cursor last was
3. `ci"` — change inside the quotes; works from anywhere on the line before or inside them
4. `billing`
5. `Esc`
6. `:2` `Enter`
7. `$` — end of the line, on the word debug
8. `ciw` — change the word under the cursor
9. `release`
10. `Esc`
11. `:4` `Enter` — any line of the three-line block
12. `dap` — delete a paragraph: the block and the blank line after it
13. `:wq` `Enter`

## Mistakes

- **Used `ciw` on the quoted name.** Only `old` changed, because a word stops at the
  hyphen. Ask: "Where does a word end? Which object covers everything between the
  quotes?"
- **Pressed `dap` on a blank line.** Different lines disappeared. Ask: "What counts
  as the paragraph when the cursor starts on a blank line?" Then `u`.
- **Skipped `Esc` after typing.** The next command, such as `:2`, is in the file as
  text. Ask: "Which mode is Neovim in once a change command has started?"
