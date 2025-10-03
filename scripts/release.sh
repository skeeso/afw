#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   scripts/release.sh 1.0.0
#   scripts/release.sh 1.1.0 --notes "New geo allow + AU ranges"
#   scripts/release.sh 2.0.0-rc.1 --notes "Breaking: CLI flags renamed"
#
# Notes:
# - Version may include prerelease (e.g., 1.2.0-beta.1)
# - Tag will be "v<version>" (e.g., v1.2.0-beta.1)
# - Works on any branch; pushes current branch + the tag

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <version> [--notes \"text\"]" >&2
  exit 1
fi

VERSION_RAW="$1"; shift || true
NOTES=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --notes)
      shift
      NOTES="${1:-}"; shift || true
      ;;
    *)
      echo "Unknown arg: $1" >&2; exit 1 ;;
  esac
done

# Basic semver (with optional prerelease) check
if [[ ! "$VERSION_RAW" =~ ^[0-9]+\.[0-9]+\.[0-9]+([-.][A-Za-z0-9.]+)?$ ]]; then
  echo "Invalid version: $VERSION_RAW (expected: 1.2.3 or 1.2.0-beta.1)" >&2
  exit 1
fi

TAG="v${VERSION_RAW}"
TODAY="$(date +%Y-%m-%d)"
BRANCH="$(git rev-parse --abbrev-ref HEAD)"

# Ensure CHANGELOG.md exists
if [[ ! -f CHANGELOG.md ]]; then
  cat > CHANGELOG.md <<'EOF'
# Changelog
All notable changes to this project will be documented in this file.
EOF
fi

# Build new section (prepend at top)
TMP="$(mktemp)"
{
  echo "## [${VERSION_RAW}] - ${TODAY}"
  if [[ -n "$NOTES" ]]; then
    echo "${NOTES}"
    echo
  fi
  echo "### Added"
  echo "- "
  echo
  echo "### Changed"
  echo "- "
  echo
  echo "### Fixed"
  echo "- "
  echo
  cat CHANGELOG.md
} > "$TMP"
mv "$TMP" CHANGELOG.md

# Commit changelog and tag
git add CHANGELOG.md
git commit -m "docs(changelog): ${TAG}"
git tag -a "$TAG" -m "Release ${TAG}"

# Push branch + tag
git push origin "$BRANCH"
git push origin "$TAG"

echo "Done. Created and pushed ${TAG}."

