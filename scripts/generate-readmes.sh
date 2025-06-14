#!/usr/bin/env bash

# Generate .qmd files under _readmes/ for every README.md found in git submodules
set -euo pipefail

READMES_DIR="_readmes"

mkdir -p "$READMES_DIR"
# Remove previously generated files
find "$READMES_DIR" -type f -name '*.qmd' -delete

# Exit early if no submodules
if [ ! -f .gitmodules ]; then
  echo "No submodules found"
  exit 0
fi

# Iterate over submodule paths defined in .gitmodules
# Extract path using git config
submodules=$(git config --file .gitmodules --get-regexp path | awk '{print $2}')
for submodule in $submodules; do
  # For each README.md inside the submodule
  find "$submodule" -name README.md -print | while read -r readme; do
    # Compute destination .qmd path mirroring README location
    rel_path=$(realpath --relative-to=. "$readme")
    qmd_path="$READMES_DIR/${rel_path%.md}.qmd"
    mkdir -p "$(dirname "$qmd_path")"
    echo "{{< include $rel_path >}}" > "$qmd_path"
  done
done
