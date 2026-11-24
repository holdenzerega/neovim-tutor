---
id: yank-put
subskill: 5
level: 3
title: Copy a line to two places and fix two indents
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/yank-put.yaml <<'EOF'
services:
  web:
    image: nginx
    restart: always
  api:
    image: node
worker:
      image: python
EOF
cat > ~/nvim-dojo/.expected/yank-put.yaml <<'EOF'
services:
  web:
    image: nginx
    restart: always
  api:
    image: node
    restart: always
  worker:
    image: python
    restart: always
EOF
```

## Goal

In `~/nvim-dojo/yank-put.yaml` all three services (`web`, `api`, `worker`) have a
`restart: always` line as their last line, and `worker` is indented exactly like
`web` and `api`: the service name two spaces in, its settings four spaces in.

## Check

```bash
diff -u ~/nvim-dojo/.expected/yank-put.yaml ~/nvim-dojo/yank-put.yaml
```

## Solution

1. `nvim ~/nvim-dojo/yank-put.yaml` `Enter`
2. `:4` `Enter`
3. `yy` — yank the restart line
4. `:6` `Enter`
5. `p` — put the yanked line below the node line
6. `G` — last line
7. `p`
8. `:8` `Enter` — the worker line
9. `>>` — shift the line right one level
10. `j` — down to the python line
11. `<<` — shift the line left one level
12. `:wq` `Enter`

## Mistakes

- **Deleted something between the yank and the put.** `p` pasted the deleted text,
  because a delete replaces what `p` will paste. Ask: "What did the last `dd` or `x`
  do to the text waiting to be pasted?" Then yank again.
- **The pasted line landed under the wrong service.** Ask: "Does `p` put a yanked
  line above or below the cursor line? Which command does the opposite?"
- **Shifted the wrong way or twice.** The diff shows only leading spaces differing.
  Ask: "How many spaces does one `>>` add here? Which command takes them back?"
