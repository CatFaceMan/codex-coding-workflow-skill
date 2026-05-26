# task-tracking Spec

## Goal

Create, reuse, update, and close task packages so Codex coding work is resumable.

## Trigger Conditions

- Codex is about to change project files for a feature, bugfix, refactor, documentation, bootstrap, or workspace improvement task.
- User asks to resume an unfinished tracked task.
- Task package status, checklist, index, or result files need updates.

## Non-Goals

- Does not decide root request classification; that belongs to `coding-workflow`.
- Does not protect dirty Git worktrees; that belongs to `git-safety`.
- Does not decide verification commands; that belongs to `verification-before-done`.
- Does not create long-term lessons, decisions, patterns, subagents, or automations by default.

## Runtime Boundary

Runtime instructions live in `SKILL.md`. Keep task package shape stable unless a compatibility update is intentional.

## Test Prompts

- `tests/prompts/bugfix-basic.md`
- `tests/prompts/quick-one-file-change.md`
- `tests/prompts/resume-work.md`
- `tests/prompts/documentation-only.md`

## Maintenance Notes

- Preserve the existing `tasks/YYYY/MM/T-YYYYMMDD-NNN-short-name/` convention.
- Keep quick/simple task records short.
- If required task files change, update README and prompt expectations.
