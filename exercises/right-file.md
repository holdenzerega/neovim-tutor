---
id: right-file
subskill: 2
level: 4
title: Change one of three files that share a name
---

## Setup

```bash
rm -rf ~/nvim-dojo/right-file ~/nvim-dojo/.expected/right-file
for s in api web worker; do
  mkdir -p ~/nvim-dojo/right-file/$s
  printf '{\n  "service": "%s",\n  "debug": true,\n  "port": 8080\n}\n' $s > ~/nvim-dojo/right-file/$s/settings.json
done
cp -R ~/nvim-dojo/right-file ~/nvim-dojo/.expected/right-file
sed 's/true/false/' ~/nvim-dojo/right-file/worker/settings.json > ~/nvim-dojo/.expected/right-file/worker/settings.json
```

## Goal

In the project `~/nvim-dojo/right-file/`, the worker service has `"debug": false`.
The api and web services keep `"debug": true`. All three files are called
`settings.json` and look almost the same.

## Check

```bash
diff -ru ~/nvim-dojo/.expected/right-file ~/nvim-dojo/right-file
```

## Solution

1. `nvim ~/nvim-dojo/right-file/worker/settings.json` `Enter`
2. `/true` `Enter` — jump to the value
3. `ciw` — change the word under the cursor
4. `false`
5. `Esc`
6. `:wq` `Enter`

## Mistakes

- **Edited `api/settings.json`.** It is the picker's first hit for `settings`. The
  diff shows api changed and worker untouched. Ask: "What can be typed into the
  picker to tell the three files apart? Which path does the statusline show?"
- **Changed all three files.** Ask: "What did the goal say about api and web?" Run
  setup again to restore them.
- **Typed `false` without removing `true`.** The line reads `falsetrue` or the
  letters ran as commands. Ask: "Which command removes the old word and enters
  INSERT in one go?"
