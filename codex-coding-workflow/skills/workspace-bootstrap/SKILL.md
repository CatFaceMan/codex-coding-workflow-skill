---
name: workspace-bootstrap
description: Use when Codex needs to initialize an empty project workspace or add minimal AGENTS, docs, commands, and task tracking structure to an existing workspace.
---

# Workspace Bootstrap

Create only the smallest Codex collaboration structure that helps future coding work.

## Readiness States

- `empty`: no meaningful project files exist.
- `basic_framework`: framework files exist, but Codex collaboration files are missing.
- `existing_project`: mature project exists, but guidance or task tracking is incomplete.
- `task_ready`: `AGENTS.md`, docs, and task tracking already exist.

## Minimal Structure

Use this structure only when workspace improvement is needed:

```text
AGENTS.md
docs/
├── overview.md
└── commands.md
tasks/
├── README.md
├── _index.md
└── _templates/
    ├── task.md
    ├── plan.md
    ├── tasks.md
    └── result.md
```

## Rules

- Do not reorganize existing framework files.
- Do not invent commands, APIs, stack choices, or architecture.
- Populate `docs/commands.md` from discovered project files when possible.
- Write `Not identified yet` when a command is unknown.
- Create a task package only when files are added or updated.

## AGENTS.md Baseline

Keep project guidance short and durable:

- Follow existing conventions.
- Keep changes scoped to the current task.
- Protect existing user changes before editing.
- Use `rg` for search when available.
- Track coding tasks under `tasks/`.
- Do not commit, reset, rebase, stash, or create branches unless explicitly requested.
