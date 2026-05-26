#!/usr/bin/env python3
"""Validate local skill metadata without requiring a Codex runtime."""

from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parents[1]
SKILL_ROOT = ROOT / "codex-coding-workflow"
MAX_DESCRIPTION_LENGTH = 300
NAME_RE = re.compile(r"^[a-z0-9-]+$")


def parse_frontmatter(path: Path) -> dict[str, str]:
    text = path.read_text(encoding="utf-8")
    if not text.startswith("---\n"):
        raise ValueError("missing opening frontmatter marker")

    end = text.find("\n---", 4)
    if end == -1:
        raise ValueError("missing closing frontmatter marker")

    metadata: dict[str, str] = {}
    for line in text[4:end].splitlines():
        if not line.strip():
            continue
        if ":" not in line:
            raise ValueError(f"invalid frontmatter line: {line}")
        key, value = line.split(":", 1)
        metadata[key.strip()] = value.strip().strip('"').strip("'")
    return metadata


def main() -> int:
    skill_files = sorted(SKILL_ROOT.rglob("SKILL.md"))
    if not skill_files:
        print("No SKILL.md files found", file=sys.stderr)
        return 1

    errors: list[str] = []
    names: set[str] = set()

    for path in skill_files:
        rel = path.relative_to(ROOT)
        try:
            metadata = parse_frontmatter(path)
        except ValueError as exc:
            errors.append(f"{rel}: {exc}")
            continue

        name = metadata.get("name", "")
        description = metadata.get("description", "")

        if not name:
            errors.append(f"{rel}: missing name")
        elif not NAME_RE.fullmatch(name):
            errors.append(f"{rel}: invalid name {name!r}")
        elif name in names:
            errors.append(f"{rel}: duplicate name {name!r}")
        else:
            names.add(name)

        if name and path.parent != SKILL_ROOT and path.parent.name != name:
            errors.append(
                f"{rel}: directory name {path.parent.name!r} must match skill name {name!r}"
            )

        if not description:
            errors.append(f"{rel}: missing description")
        elif len(description) > MAX_DESCRIPTION_LENGTH:
            errors.append(
                f"{rel}: description is {len(description)} chars; max is {MAX_DESCRIPTION_LENGTH}"
            )

        if description and "Use when" not in description:
            errors.append(f"{rel}: description should include 'Use when'")

    if errors:
        print("Skill metadata check failed:")
        for error in errors:
            print(f"- {error}")
        return 1

    print(f"Skill metadata check passed: {len(skill_files)} files")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
