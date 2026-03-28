#!/usr/bin/env bash
set -euo pipefail

# Local-only helper for publishing this skill to ClawHub.
# This script is intentionally gitignored.
#
# Usage:
#   bash ./publish-clawhub.local.sh 1.0.0 "changelog text"
#   bash ./publish-clawhub.local.sh 1.0.1

VERSION="${1:-}"
CHANGELOG="${2:-}"

if [[ -z "${VERSION}" ]]; then
  echo "Usage: bash ./publish-clawhub.local.sh <version> [changelog]"
  echo "Example: bash ./publish-clawhub.local.sh 1.0.0 \"Initial release\""
  exit 1
fi

if ! command -v clawhub >/dev/null 2>&1; then
  echo "Error: clawhub CLI not found. Install first:"
  echo "  npm i -g clawhub"
  exit 1
fi

if [[ -z "${CHANGELOG}" ]]; then
  CHANGELOG="release ${VERSION}"
fi

echo "Publishing 1688-shopkeeper ${VERSION} to ClawHub..."
clawhub publish . \
  --slug 1688-shopkeeper \
  --name "1688-shopkeeper" \
  --version "${VERSION}" \
  --tags latest \
  --changelog "${CHANGELOG}"

echo "Done."
