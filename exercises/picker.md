---
id: picker
subskill: 2
level: 3
title: Visit three files with the LazyVim file picker
---

## Setup

```bash
rm -rf ~/nvim-dojo/picker ~/nvim-dojo/.expected/picker
mkdir -p ~/nvim-dojo/.expected/picker/api ~/nvim-dojo/.expected/picker/web ~/nvim-dojo/.expected/picker/docs
cd ~/nvim-dojo/.expected/picker
echo '# Shop' > README.md
printf '%s\n' 'def routes():' '    return ["/", "/cart"]' > api/routes.py
printf '%s\n' '<h1>Shop</h1>' > web/index.html
printf '%s\n' '# Deploy' 'Run make deploy.' > docs/deploy.md
cp -R ~/nvim-dojo/.expected/picker ~/nvim-dojo/picker
for f in api/routes.py web/index.html docs/deploy.md; do
  { echo 'REMOVE ME'; cat $f; } > ~/nvim-dojo/picker/$f
done
```

## Goal

Three files in the project `~/nvim-dojo/picker/` start with a line reading
`REMOVE ME`: `api/routes.py`, `web/index.html` and `docs/deploy.md`. All three lines
are gone and nothing else has changed, in one Neovim session started inside that
folder.

## Check

```bash
diff -ru ~/nvim-dojo/.expected/picker ~/nvim-dojo/picker
```

## Solution

1. `cd ~/nvim-dojo/picker && nvim` `Enter` — the picker searches the folder Neovim was started in
2. `Space` `Space` — the file picker opens
3. `routes` — typed to filter the list
4. `Enter` — open the highlighted file
5. `gg` — jump to the first line; Neovim reopens a file where the cursor last was
6. `dd`
7. `:w` `Enter`
8. `Space` `Space`
9. `index`
10. `Enter`
11. `gg`
12. `dd`
13. `:w` `Enter`
14. `Space` `Space`
15. `deploy`
16. `Enter`
17. `gg`
18. `dd`
19. `:wq` `Enter`

The explorer reaches the same files: Space then e opens a file tree on the left,
j and k move through it, Enter opens a folder or file.

## Mistakes

- **Started Neovim from the home directory.** The picker lists thousands of
  unrelated files. Ask: "Which folder does the picker search? What does `:pwd`
  print?"
- **Typed the filter after the picker had closed.** The letters ran as NORMAL-mode
  commands in whatever file was open. Ask: "Was the picker's input box on screen
  when the typing started?" Then `u` undoes the damage.
- **Moved on without `:w`.** At the end `:wq` refuses because another buffer has
  unsaved changes. Ask: "Which buffer is unsaved? What does `:ls` mark with a `+`?"
