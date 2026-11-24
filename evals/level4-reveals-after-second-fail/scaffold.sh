#!/usr/bin/env bash
# Plant exercise dot-repeat in this run's home before the agent starts.
set -eu
bash "$(dirname "$0")/../../scripts/setup.sh" dot-repeat > /dev/null
