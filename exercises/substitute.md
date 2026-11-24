---
id: substitute
subskill: 7
level: 3
title: Replace across the whole file, then only in a range
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/substitute.conf <<'EOF'
# staging
api_host = old.example.test
cdn_host = old.example.test/cdn
log_level = debug

# production
api_host = old.example.test
cdn_host = old.example.test/cdn
log_level = debug
EOF
sed -e 's/old/new/' -e '6,9s/debug/warn/' ~/nvim-dojo/substitute.conf > ~/nvim-dojo/.expected/substitute.conf
```

## Goal

In `~/nvim-dojo/substitute.conf` every `old.example.test` reads `new.example.test`.
In the production block only (lines 6 to 9) `debug` reads `warn`; the staging block
keeps `debug`.

## Check

```bash
diff -u ~/nvim-dojo/.expected/substitute.conf ~/nvim-dojo/substitute.conf
```

## Solution

1. `nvim ~/nvim-dojo/substitute.conf` `Enter`
2. `:%s/old/new/g` `Enter` — substitute on every line; the g flag covers every match on a line
3. `:6,9s/debug/warn/` `Enter` — the same command limited to lines 6 to 9
4. `:wq` `Enter`

## Mistakes

- **Left out the `%`.** Only the line under the cursor changed. Ask: "Which lines
  does `:s` work on when no range is given? What does `%` stand for?"
- **Used `%` for the `debug` change too.** Staging now says `warn`. Ask: "How is a
  range of lines written in front of a command?" Then `u`.
- **Mistyped the pattern.** Neovim answered `E486: Pattern not found`. Ask: "What
  did the message say? Where can it be read again after it vanishes?"
