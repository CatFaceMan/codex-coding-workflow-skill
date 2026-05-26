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

## If Target Files Are Dirty

- If changes are related to the requested task, work with them.
- If changes are unrelated but can be preserved with a minimal patch, preserve them.
- If safe merging is not possible, mark the task `blocked` and ask for the specific decision needed.

## Before Final Response

Use `git diff` or equivalent file comparison when possible to understand actual changes before summarizing.
