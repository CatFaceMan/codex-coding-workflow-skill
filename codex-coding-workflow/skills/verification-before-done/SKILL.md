---
name: verification-before-done
description: Use when Codex is about to claim coding work is done, fixed, passing, ready for review, or when the user asks whether the result is complete.
---

# Verification Before Done

Do not claim work is complete without fresh verification evidence or an explicit verification gap.

## Verification Choice

Run the most relevant available check for the project and task:

- Frontend: build, lint, tests, targeted browser/manual check when needed.
- Backend: tests, compile, targeted API/manual check.
- Java/Spring: Maven or Gradle tests/package commands discovered from project files.
- Node: scripts from `package.json`.
- Documentation-only: consistency and format review against source files.

Do not invent commands. Inspect project files first when commands are unknown.

## Completion Evidence

A completion claim needs one of these:

- a successful relevant command with the exact command named
- a targeted manual check with what was checked
- an explicit verification gap with the reason it could not be closed

Do not describe work as "done", "fixed", "passing", or "ready" unless the evidence or gap is clear.

## If Verification Fails

Record:

- command attempted
- exact failure reason
- whether it appears task-caused, pre-existing, or environmental
- remaining risk

Use `review` when implementation is complete but external/manual validation remains.
Use `blocked` when the failure prevents completing implementation.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "This was documentation-only, so no verification is needed." | At minimum, check consistency against source files or affected docs. |
| "I already inspected the code while editing." | Inspection is useful, but completion still needs explicit evidence or a stated gap. |
| "The full test suite is too slow, so I will say it is done." | Run the narrowest relevant check, or record why verification is incomplete. |
| "The failure looks unrelated, so the task is complete." | Record the command, failure, and why it appears unrelated before claiming readiness. |

## Red Flags

- Final response says "done" without a command, manual check, or verification gap.
- Verification command is guessed instead of discovered from project files.
- A failed check is omitted from the result.
- Task status is set to `done` while required manual validation remains.

## Completion Report

Final response should include:

- changed files
- verification command and result
- verification gaps, if any
- blockers or residual risk
