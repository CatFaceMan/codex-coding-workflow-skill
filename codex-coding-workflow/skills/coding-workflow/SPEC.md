# coding-workflow Spec

## Goal

Classify Codex coding requests and route them to the lightest useful workflow.

## Trigger Conditions

- User asks Codex to plan, implement, fix, refactor, document, review, resume, or close coding work.
- User request may or may not require file changes.
- Codex needs to decide whether task tracking, bootstrap, Git safety, or verification applies.

## Non-Goals

- Does not define detailed task package templates.
- Does not perform Git safety checks.
- Does not define verification commands.
- Does not force TDD, worktrees, subagents, or long-term knowledge capture.

## Runtime Boundary

Runtime instructions live in `SKILL.md`. Keep this spec out of normal execution context unless maintaining the skill.

## Test Prompts

- `tests/prompts/review-only.md`
- `tests/prompts/feature-medium.md`
- `tests/prompts/resume-work.md`
- `tests/prompts/completion-check.md`

## Maintenance Notes

- Keep routing tables short and behavior-focused.
- Add new request types only when they change downstream workflow behavior.
- If routing changes, update matching prompt fixtures.
