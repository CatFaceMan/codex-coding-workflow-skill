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

## If Verification Fails

Record:

- command attempted
- exact failure reason
- whether it appears task-caused, pre-existing, or environmental
- remaining risk

Use `review` when implementation is complete but external/manual validation remains.
Use `blocked` when the failure prevents completing implementation.

## Completion Report

Final response should include:

- changed files
- verification command and result
- verification gaps, if any
- blockers or residual risk
