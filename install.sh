#!/usr/bin/env sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
source_dir="$repo_root/codex-coding-workflow"
destination_root="${1:-"$HOME/.codex/skills"}"
root_destination="$destination_root/codex-coding-workflow"

if [ ! -f "$source_dir/SKILL.md" ]; then
  echo "Missing skill source: $source_dir/SKILL.md" >&2
  exit 1
fi

mkdir -p "$destination_root"
rm -rf "$root_destination"
cp -R "$source_dir" "$root_destination"

if [ -d "$source_dir/skills" ]; then
  for skill_dir in "$source_dir"/skills/*; do
    [ -d "$skill_dir" ] || continue
    skill_name=$(basename "$skill_dir")
    rm -rf "$destination_root/$skill_name"
    cp -R "$skill_dir" "$destination_root/$skill_name"
  done
fi

echo "Installed root skill to: $root_destination"
echo "Installed child skills to: $destination_root"
