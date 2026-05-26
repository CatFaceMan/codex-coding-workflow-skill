---
name: git-safety
description: Use when Codex is about to edit, move, delete, format, or generate project files in a Git workspace where user changes may already exist.
---

# Git Safety

Protect the user's existing work before editing.

## Before Editing

When Git is available:

1. Run `git status --short`.
2. Identify modified, deleted, untracked, or conflicted files.
3. Check whether target files already have unrelated user changes.
4. Preserve unrelated changes.

When Git is unavailable, still avoid overwriting unknown existing files and record that Git status could not be checked when task tracking is active.

## Do Not Do By Default

Do not commit, branch, tag, reset, rebase, stash, force push, move major files, or mass-format files unless the user explicitly asks.

## Common Rationalizations

| Rationalization | Reality |
|---|---|
| "The change is tiny, so Git status is unnecessary." | Tiny edits can still overwrite user work. Check status before editing. |
| "The dirty files are probably from the current task." | Do not assume ownership. Inspect whether dirty files overlap the requested change. |
| "Formatting everything will make the patch cleaner." | Mass formatting hides behavioral changes and can rewrite user edits. Keep formatting scoped. |
| "Stashing is the fastest way to get a clean tree." | Stash changes only when explicitly requested; it changes user workspace state. |

## If Target Files Are Dirty

- If changes are related to the requested task, work with them.
- If changes are unrelated but can be preserved with a minimal patch, preserve them.
- If safe merging is not possible, mark the task `blocked` and ask for the specific decision needed.

## Red Flags

- Editing before checking `git status --short`.
- Reverting, deleting, or moving files the user did not ask to change.
- Running a formatter across unrelated files.
- Summarizing changes without checking the actual diff.
- Treating untracked files as disposable.

## Before Final Response

Use `git diff` or equivalent file comparison when possible to understand actual changes before summarizing.
