# workspace-bootstrap Spec

## Goal

Initialize an empty workspace or add minimal Codex collaboration structure to an existing project.

## Trigger Conditions

- User asks to initialize a workspace for Codex.
- Project has source files but lacks useful agent guidance or task tracking.
- Codex needs to create `AGENTS.md`, `docs/`, or `tasks/` scaffolding.

## Non-Goals

- Does not choose an application framework unless the user explicitly asks.
- Does not reorganize existing project layout.
- Does not create placeholder directories unrelated to current workspace readiness.
- Does not maintain task progress after bootstrap; that belongs to `task-tracking`.

## Runtime Boundary

Runtime instructions live in `SKILL.md`. Template details should stay concise and avoid duplicating README content.

## Test Prompts

- `tests/prompts/workspace-bootstrap-empty.md`
- `tests/prompts/workspace-bootstrap-existing.md`

## Maintenance Notes

- Keep generated workspace structure minimal.
- Prefer discovered commands and paths over generic boilerplate.
- If bootstrap files change, update README task structure examples.
