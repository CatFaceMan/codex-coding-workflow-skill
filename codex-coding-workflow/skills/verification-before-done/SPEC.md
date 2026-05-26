# verification-before-done Spec

## Goal

Ensure Codex does not claim coding work is done without verification evidence or an explicit verification gap.

## Trigger Conditions

- Codex is about to report work as done, fixed, passing, complete, or ready.
- User asks whether a change is complete.
- Task status is about to move to `done` or `review`.

## Non-Goals

- Does not force TDD.
- Does not invent project commands.
- Does not require full-suite verification when a narrower relevant check is clearly better.
- Does not hide environmental or pre-existing failures.

## Runtime Boundary

Runtime instructions live in `SKILL.md`. Keep verification guidance generic and command discovery project-based.

## Test Prompts

- `tests/prompts/completion-check.md`
- `tests/prompts/bugfix-basic.md`
- `tests/prompts/documentation-only.md`
- `tests/prompts/quick-one-file-change.md`

## Maintenance Notes

- Completion claims should always map to evidence or a stated gap.
- If new ecosystems are listed, use examples only when they are common and discoverable from project files.
