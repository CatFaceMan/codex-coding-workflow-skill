# git-safety Spec

## Goal

Prevent Codex from overwriting, reverting, or obscuring user changes while editing a Git workspace.

## Trigger Conditions

- Codex is about to edit, move, delete, format, or generate files in a Git workspace.
- Target files may already contain user changes.
- User asks for implementation, cleanup, refactor, or generated output that affects project files.

## Non-Goals

- Does not choose implementation strategy.
- Does not create commits, branches, stashes, resets, or rebases by default.
- Does not replace task tracking or verification.
- Does not enforce worktrees.

## Runtime Boundary

Runtime instructions live in `SKILL.md`. This spec documents intent and maintenance checks only.

## Test Prompts

- `tests/prompts/bugfix-command-failure.md`
- `tests/prompts/feature-medium.md`
- `tests/prompts/quick-one-file-change.md`

## Maintenance Notes

- Keep rules conservative; losing user work is worse than asking for a narrow clarification.
- Any new Git operation rule should explicitly state whether user approval is required.
