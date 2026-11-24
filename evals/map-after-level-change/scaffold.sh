#!/usr/bin/env bash
# Plant exercise popup-escape in this run's home before the agent starts.
set -eu
bash "$(dirname "$0")/../../scripts/setup.sh" popup-escape > /dev/null
# The learner has solved it: put the expected file in place.
cp ~/nvim-dojo/.expected/popup-escape.txt ~/nvim-dojo/popup-escape.txt
