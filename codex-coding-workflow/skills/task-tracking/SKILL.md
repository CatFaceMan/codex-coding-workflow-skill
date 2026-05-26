---
name: task-tracking
description: Use when Codex is about to change project files, resume tracked coding work, create a task package, update task progress, or record implementation results.
---

# Task Tracking

Use task packages to make Codex coding work resumable without turning small changes into heavy process.

## When To Create A Task Package

Create or reuse a task package for feature, bugfix, refactor, documentation, bootstrap, and workspace improvement tasks that change files.

Do not create one for read-only discussion, analysis, or review unless the user asks for tracking.

## Location

```text
tasks/YYYY/MM/T-YYYYMMDD-NNN-short-name/
```

Use the local date. `NNN` is the next available sequence for that day.

## Required Files

- `task.md`: goal, scope, type, status, difficulty, current step, next step.
- `plan.md`: classification, known files, risks, implementation strategy, verification.
- `tasks.md`: checkbox steps with stable IDs such as `T001`.
- `result.md`: completed work, changed files, verification, gaps, remaining issues, risks.

For complex tasks, add `research.md` only when investigation findings need to be preserved.

## Statuses

- `planned`: package exists, implementation has not started.
- `in_progress`: implementation is underway.
- `blocked`: work cannot continue safely.
- `review`: implementation is complete but needs human/manual validation.
- `done`: implementation and reasonable verification are complete.

## Progress Rules

- Keep `tasks.md` checkboxes current after meaningful steps.
- Update `task.md` `current_step`, `next_step`, and `updated_at`.
- Update `tasks/_index.md` when creating, completing, reviewing, or blocking a task.
- Keep `quick` and `simple` task records short.
