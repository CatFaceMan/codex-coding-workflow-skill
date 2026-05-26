---
name: codex-coding-workflow
description: Use when Codex is asked to plan, implement, fix, refactor, document, review, or resume coding work in a project workspace.
---

# Codex Coding Workflow

Version: v0.3

## Goal

Help Codex complete coding work through a lightweight, traceable workflow.

This is the entry skill. It chooses the least intrusive path and references the smaller workflow skills only when they apply.

## Core Rules

- Prefer the existing project conventions before introducing new structure.
- Keep small tasks small.
- Do not create task files for read-only discussion, analysis, or review unless the user asks for tracking.
- Protect existing user changes before editing.
- Verify before reporting work as complete, or clearly record why verification could not be completed.
- Do not force TDD, worktrees, subagents, long-term knowledge files, or automations by default.

## Request Routing

| User request | Request type | Required skill path |
|---|---|---|
| Advice, comparison, design discussion, read-only review | `discussion_only` or `review_task` | Answer directly; no task package by default |
| Empty workspace setup or Codex collaboration structure | `project_bootstrap` or `workspace_improvement` | Use `workspace-bootstrap` |
| Feature, bug fix, refactor, or documentation change | `feature_task`, `bugfix_task`, `refactor_task`, or `documentation_task` | Use `task-tracking`, then `git-safety`, then `verification-before-done` |
| Resume an unfinished task | `resume_work` | Use `task-tracking` |
| User asks whether work is done or ready | `completion_check` | Use `verification-before-done` |

## Difficulty Profiles

- `quick`: one small low-risk change. Keep planning and records minimal.
- `simple`: one or two files, low regression risk.
- `medium`: several files, cross-component behavior, API/state/test impact, or meaningful regression risk.
- `complex`: broad, ambiguous, security/data/auth/deployment-sensitive, or likely to split into multiple deliverables.

Record the difficulty when a task package is created.

## Task Package Shape

When tracking is needed, use:

```text
tasks/YYYY/MM/T-YYYYMMDD-NNN-short-name/
├── task.md
├── plan.md
├── tasks.md
└── result.md
```

Maintain `tasks/_index.md` when present or when creating task tracking.

## Completion

Before final response:

1. Check the actual changed files.
2. Run the most relevant available verification.
3. If verification cannot run, record the exact reason.
4. Report changed files, verification, blockers, and residual risk concisely.
