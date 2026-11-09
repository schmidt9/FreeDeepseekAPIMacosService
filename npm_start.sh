#!/bin/bash
set -euo pipefail

export NVM_DIR="$HOME/.nvm"
# shellcheck disable=SC1091
. "$NVM_DIR/nvm.sh"

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)
# import to get API_PATH
source "$SCRIPT_DIR/env.sh"

cd "$API_PATH"

# Use the project's .nvmrc if present, otherwise fall back to `default`.
# Add --silent so nvm doesn't print to stderr every boot.
if [ -f .nvmrc ]; then
  nvm use --silent
else
  nvm use --silent default
fi

# exec so launchd tracks npm's PID, not the wrapper's.
NON_INTERACTIVE=1 exec npm start