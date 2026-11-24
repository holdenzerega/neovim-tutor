#!/usr/bin/env bash
# Plant the file this case is about and snapshot it, as the tutor would have.
set -eu
mkdir -p "$(dirname ~/nvim-dojo/semicolons.css)"
cat > ~/nvim-dojo/semicolons.css <<'FILE'
.button {
  color: white
  background: teal
  padding: 4px 8px
  border-radius: 4px
}
FILE
bash "$(dirname "$0")/../../scripts/snapshot.sh" ~/nvim-dojo/semicolons.css > /dev/null
