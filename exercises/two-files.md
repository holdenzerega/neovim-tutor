---
id: two-files
subskill: 2
level: 2
title: Edit two files in one Neovim session
---

## Setup

```bash
rm -rf ~/nvim-dojo/two-files ~/nvim-dojo/.expected/two-files
mkdir -p ~/nvim-dojo/two-files ~/nvim-dojo/.expected/two-files
printf '%s\n' 'host = 0.0.0.0' 'port = 8080' > ~/nvim-dojo/.expected/two-files/server.conf
printf '%s\n' 'server = localhost' 'port = 8080' > ~/nvim-dojo/.expected/two-files/client.conf
for f in server.conf client.conf; do
  { echo '# TODO delete this line'; cat ~/nvim-dojo/.expected/two-files/$f; } > ~/nvim-dojo/two-files/$f
done
```

## Goal

Both `~/nvim-dojo/two-files/server.conf` and `~/nvim-dojo/two-files/client.conf` have
lost their first line (`# TODO delete this line`). Both are saved, and the second
file was opened from inside Neovim rather than from the shell.

## Check

```bash
diff -ru ~/nvim-dojo/.expected/two-files ~/nvim-dojo/two-files
```

## Solution

1. `nvim ~/nvim-dojo/two-files/server.conf` `Enter` — open a file by path from the shell
2. `gg` — jump to the first line; Neovim reopens a file where the cursor last was
3. `dd`
4. `:w` `Enter` — save and stay in Neovim
5. `:e ~/nvim-dojo/two-files/client.conf` `Enter` — open the second file in the same Neovim
6. `gg`
7. `dd`
8. `:wq` `Enter`

## Mistakes

- **`:e` refused with `E37: No write since last change`.** Step 4 was skipped. Ask:
  "What is Neovim refusing to lose? Which command puts the first file on disk?"
- **Typed `:e client.conf` and got an empty buffer.** A bare name is looked up in the
  directory Neovim was started from, so a new empty file was opened. Ask: "What does
  `:pwd` print? Where does `client.conf` actually live?"
- **Only one file changed.** The diff names the other one. Ask: "Which file name is
  in the statusline right now? Was that buffer written?"
