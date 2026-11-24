---
id: paste-indent
subskill: 6
level: 4
title: Paste a snippet into nested code and repair its indentation
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/.expected/paste-indent.py <<'EOF'
def load_config(path):
    with open(path) as f:
        data = json.load(f)
    if "name" not in data:
        raise KeyError("name")
    return data
EOF
sed '4,5d' ~/nvim-dojo/.expected/paste-indent.py > ~/nvim-dojo/paste-indent.py
sed -n '4,5p' ~/nvim-dojo/.expected/paste-indent.py | sed 's/^    //' | wl-copy > /dev/null 2>&1
```

## Goal

The system clipboard holds a two-line check copied from a web page, starting at the
left margin. In `~/nvim-dojo/paste-indent.py` it sits inside `load_config`, between
the `with` block and `return data`, indented as part of the function body: the `if`
line four spaces in, the `raise` line eight.

## Check

```bash
diff -u ~/nvim-dojo/.expected/paste-indent.py ~/nvim-dojo/paste-indent.py
```

## Solution

1. `nvim ~/nvim-dojo/paste-indent.py` `Enter`
2. `:3` `Enter`
3. `"+p` — the two lines land below line 3 with the indentation they were copied with
4. `V` — select the first pasted line
5. `j` — extend the selection to the second
6. `>` — shift the selection right one level; LazyVim keeps the lines selected
7. `Esc` — drop the selection
8. `:wq` `Enter`

## Mistakes

- **Pasted and stopped.** The diff shows both lines four spaces short. Ask: "Where
  did the leading spaces of the pasted lines come from: the place they were pasted
  or the place they were copied?"
- **Shifted only the `if` line.** The `raise` line is now level with it. Ask: "How
  far in must the second line be relative to the first? How can one command move
  both?"
- **Opened a line with `o` and used the terminal's paste key.** The first line took
  the new line's indent and the second did not. Ask: "Which line picked up the
  indent of its new home, and which kept the indent it was copied with?"
