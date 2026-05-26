---
name: coding-workflow
description: Use when Codex needs to classify a coding request, choose a lightweight workflow, or route between planning, implementation, review, bootstrap, resume, and completion checks.
---

# Coding Workflow

Use this as the request classifier for Codex coding work.

## Classify First

Choose one request type:

- `discussion_only`: advice, comparison, explanation, or planning with no file changes.
- `project_bootstrap`: create a new project or initialize an empty workspace.
- `workspace_improvement`: add missing Codex collaboration structure to an existing project.
- `feature_task`: add functionality.
- `bugfix_task`: fix broken behavior, failed commands, or unexpected output.
- `refactor_task`: improve structure without intended behavior changes.
- `documentation_task`: update docs.
- `review_task`: inspect code, design, architecture, or task output.
- `resume_work`: continue an existing tracked task.
- `completion_check`: determine whether work can be called done.

## Route

- For read-only discussion or review, answer directly and do not create task files by default.
- For workspace setup, use `workspace-bootstrap`.
- For coding changes, use `task-tracking`, then `git-safety`, then `verification-before-done`.
- For completion checks, use `verification-before-done`.

## Keep It Lightweight

- Use `quick` for tiny low-risk changes.
- Use `simple`, `medium`, or `complex` only when the task shape warrants it.
- Ask the user only when ambiguity is high-impact or the next edit would be risky.
- Do not introduce long-term knowledge files, automations, subagents, worktrees, or broad process unless the user asks.
