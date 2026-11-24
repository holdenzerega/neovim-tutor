---
id: search-hops
subskill: 3
level: 3
title: Search for a repeated setting and act on the right matches
---

## Setup

```bash
mkdir -p ~/nvim-dojo/.expected
cat > ~/nvim-dojo/search-hops.ini <<'EOF'
[database]
host = db.internal
port = 5432
debug = true

[cache]
host = cache.internal
port = 6379
debug = true

[queue]
host = queue.internal
port = 5672
debug = true
EOF
sed -e '9d' -e '14d' ~/nvim-dojo/search-hops.ini > ~/nvim-dojo/.expected/search-hops.ini
```

## Goal

In `~/nvim-dojo/search-hops.ini` the `debug = true` line is gone from the `[cache]`
section and from the `[queue]` section. The `[database]` section keeps its own.

## Check

```bash
diff -u ~/nvim-dojo/.expected/search-hops.ini ~/nvim-dojo/search-hops.ini
```

## Solution

1. `nvim ~/nvim-dojo/search-hops.ini` `Enter`
2. `gg` — jump to the first line; Neovim reopens a file where the cursor last was
3. `/debug` `Enter` — search forward; the first match is in the database section
4. `n` — next match, in the cache section
5. `dd`
6. `n` — next match, in the queue section
7. `dd`
8. `:wq` `Enter`

## Mistakes

- **Deleted the first match.** The diff shows the database line gone. Ask: "Which
  section header is above the cursor? How many matches come before the one that
  has to go?"
- **Pressed `n` once too often.** The search wrapped back to the top. Ask: "Which
  key goes to the previous match instead of the next?"
- **Typed `/debug` and carried on without `Enter`.** The following keys went into
  the search box. Ask: "What is on the bottom line of the screen? What closes a
  search prompt?"
