---
id: star-search
subskill: 3
level: 5
title: Reach the last use of a name within a keystroke budget
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/star-search.py <<'EOF'
max_retries = 3
timeout_seconds = 10


def connect(host):
    for attempt in range(max_retries):
        if ping(host, timeout_seconds):
            return True
    return False


def fetch(url):
    for attempt in range(max_retries):
        response = get(url, timeout_seconds)
        if response:
            return response
    return None


def report():
    print("retry limit:", max_retries)
    print("timeout:", timeout_seconds)
    print("done")
EOF
sed '21d' ~/nvim-dojo/star-search.py > ~/nvim-dojo/.expected/star-search.py
```

## Goal

`max_retries` is defined on line 1 of `~/nvim-dojo/star-search.py` and used on three
later lines. The last line that uses it, inside `report()`, is gone. Nothing else
has changed.

Budget: 8 keystrokes between opening the file and `:w`.

## Check

```bash
diff -u ~/nvim-dojo/.expected/star-search.py ~/nvim-dojo/star-search.py
```

## Solution

1. `nvim ~/nvim-dojo/star-search.py` `Enter`
2. `gg` — the first line; Neovim reopens a file where the cursor last was, column included
3. `0` — the first column, on max_retries
4. `*` — star searches for the word under the cursor and jumps to its next use
5. `*`
6. `*` — the last use, inside report
7. `dd`
8. `:wq` `Enter`

A sound explanation says that star takes the whole word under the cursor as the
search pattern, that each press moves to the next match and wraps at the end of the
file, and that dd removes the line the cursor is on.

## Mistakes

- **Pressed `*` a fourth time.** The search wrapped to line 1 and `dd` removed the
  definition. Ask: "What did the message about hitting BOTTOM mean? How many uses
  come after line 1?"
- **Pressed `*` without first putting the cursor on `max_retries`.** The search ran
  on a different word. Ask: "Which word was under the cursor? Where does Neovim put
  the cursor when a file is reopened?"
- **Went over budget with `/max_retries` and `Enter`.** Ask: "Which command searches
  for a word that is already under the cursor?"
