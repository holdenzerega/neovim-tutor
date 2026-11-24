#!/usr/bin/env bash
# Plant exercise first-save in this run's home before the agent starts.
set -eu
bash "$(dirname "$0")/../../scripts/setup.sh" first-save > /dev/null
