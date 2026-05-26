#!/usr/bin/env sh
set -eu

repo_root=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
source_dir="$repo_root/codex-coding-workflow"
destination_root="${1:-"$HOME/.agents/skills"}"
skill_name="codex-plan-task-workflow"
root_destination="$destination_root/$skill_name"

if [ ! -f "$source_dir/SKILL.md" ]; then
  echo "Missing skill source: $source_dir/SKILL.md" >&2
  exit 1
fi

mkdir -p "$destination_root"
rm -rf "$root_destination"
cp -R "$source_dir" "$root_destination"

echo "Installed skill to: $root_destination"
