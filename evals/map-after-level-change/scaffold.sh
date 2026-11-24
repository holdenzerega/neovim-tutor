#!/usr/bin/env bash
# Plant the file this case is about and snapshot it, as the tutor would have.
set -eu
mkdir -p "$(dirname ~/nvim-dojo/modes.txt)"
cat > ~/nvim-dojo/modes.txt <<'FILE'
mode when Neovim opens: NORMAL
mode after pressing i: INSERT
FILE
bash "$(dirname "$0")/../../scripts/snapshot.sh" ~/nvim-dojo/modes.txt > /dev/null
# The learner has since made the edit:
echo 'mode after pressing Esc: NORMAL' >> ~/nvim-dojo/modes.txt
