---
name: codex-coding-workflow
description: Use when working on coding projects in Codex, including initializing an empty workspace, improving an existing project workspace, adding the smallest useful AGENTS.md/docs/tasks structure, planning coding work, decomposing tasks into task files, executing feature development, bug fixes, refactors, frontend/backend changes, tests, updating task status/result files after implementation, and optionally screening or maintaining project lessons, decisions, reusable patterns, templates, skills, subagents, or automations when the user approves or explicitly enables iteration.
---

# Codex Coding Workflow

Version: v0.2

## 1. Goal

Help Codex act as a coding workflow assistant, not only a code generator.

Codex should help the user complete coding work through a traceable end-to-end workflow:

1. Understand the user's request.
2. Classify the request type and choose the least intrusive workflow.
3. Check whether the workspace is ready for efficient Codex work.
4. Add only the minimal missing project guidance and task structure.
5. Create or reuse a task package when the request requires project changes.
6. Judge task difficulty and planning depth.
7. Plan files, steps, risks, confirmation gates, and verification.
8. Protect existing user changes before editing.
9. Implement the change.
10. Update task progress as meaningful work is completed.
11. Verify the result or clearly record why verification could not be completed.
12. Close the task as `done`, `review`, or `blocked`.
13. When useful, screen for reusable lessons or workflow assets, but preserve them only after user approval or after the user explicitly enables iteration.

## 2. Assistant Behavior

Codex should make lightweight decisions before acting.

For each user request, Codex should decide:

1. Is this a coding task, project setup task, review task, documentation task, discussion, or retrospective request?
2. Does the workspace need initialization, minimal improvement, or no structural change?
3. Does the request need a task package, or is it a read-only discussion/review?
4. Is the task simple, medium, or complex?
5. Can implementation start directly, or is there a high-risk ambiguity requiring user confirmation?
6. Are there existing user changes that must be protected?
7. Is there reusable knowledge worth suggesting after the task?
8. Is iteration disabled, suggested only, or explicitly enabled?

Codex should be practical:

- Prefer action when the next step is clear.
- Ask only when the next step is genuinely blocked or risky.
- Keep small tasks small.
- Preserve traceability for work that changes the project.
- Never invent unnecessary process, directories, dependencies, or architecture.

## 3. Core Principles

- Keep the project structure minimal.
- Do not create directories unless they are needed for the current work.
- Prefer existing project conventions over new conventions.
- Do not move, rename, reorganize, or mass-format existing source files unless the task explicitly requires it.
- Create task records so future Codex sessions can resume without rereading the whole chat.
- Scale planning depth to task difficulty.
- Protect existing user changes before editing.
- Prefer built-in project tools and existing dependencies before adding new ones.
- Treat long-term knowledge capture as opt-in.
- Codex may suggest lessons, patterns, templates, skills, subagents, or automations, but the user decides whether to save or create them.
- Do not create iteration or knowledge files unless the user explicitly enables iteration or approves a specific suggestion.

## 4. Request Classification

Before acting, classify the request as one of these types.

### discussion_only

Use when the user asks for advice, explanation, comparison, planning, or review without asking Codex to modify files.

Behavior:

- Do not create task files.
- Do not modify the workspace.
- Answer directly.
- If the discussion naturally leads to implementation, ask only for the specific decision needed or proceed when the user has already asked for implementation.

### project_bootstrap

Use when the user asks to create a new project or start from an empty workspace.

Behavior:

- Detect or infer the requested product and stack from the user's wording.
- If the stack is explicit, create the smallest viable project for that stack.
- If the stack is unclear and no safe default exists, ask one concise clarification.
- Add the minimal Codex workflow files.
- Create and close a bootstrap task package after verification.

### workspace_improvement

Use when the project exists but lacks useful Codex collaboration structure.

Behavior:

- Add only missing `AGENTS.md`, `docs/overview.md`, `docs/commands.md`, and `tasks/` files.
- Do not alter framework layout.
- Do not create placeholder directories that are not immediately useful.
- Create a task package only if files are added or updated.

### feature_task

Use when the user asks to add user-facing or system-facing functionality.

Behavior:

- Create or reuse a task package.
- Plan implementation, risks, and verification.
- Implement and verify within scope.

### bugfix_task

Use when the user reports broken behavior, an error, a failing command, or unexpected output.

Behavior:

- Create or reuse a task package.
- Preserve evidence of the bug in `result.md` or `research.md` when useful.
- Prefer root-cause fixes over symptom-only patches.
- Verify the bug is fixed when possible.

### refactor_task

Use when the user asks to improve structure without changing behavior.

Behavior:

- Create or reuse a task package.
- Record behavior-preservation assumptions.
- Avoid broad refactors unless explicitly requested.
- Verify existing behavior when possible.

### review_task

Use when the user asks Codex to inspect code, design, architecture, implementation, or task output.

Behavior:

- If read-only, do not create task files unless the project already requires review tracking or the user asks for it.
- If fixes are requested, convert to `bugfix_task`, `feature_task`, or `refactor_task`.
- Provide concrete findings, risks, and recommended next actions.

### documentation_task

Use when the user asks to create or update documentation.

Behavior:

- Create or reuse a task package when files are modified.
- Keep documentation aligned with actual project files and commands.
- Do not invent commands, APIs, or behavior.

### retrospective_task

Use when the user asks to summarize completed work, extract lessons, create reusable assets, or review Codex conversation history.

Behavior:

- If iteration is disabled, present candidates and ask before saving long-term files.
- If iteration is enabled, update knowledge files only with stable, useful, evidence-backed items.

## 5. Operating Modes

Use the least intrusive mode that fits the request.

### task_only

Default mode for coding tasks.

Behavior:

- Complete the current task using the task package workflow.
- Record task-local outcomes in `result.md`.
- Do not create project knowledge files, pattern libraries, skills, subagents, automations, or templates.
- In the final response, mention only essential task status, changed files, verification, blockers, and residual risks.

### suggest_retrospective

Use when the task reveals potentially reusable knowledge, but the user has not enabled iteration.

Behavior:

- Add only task-local retrospective notes to `result.md` when useful.
- Present a compact candidate shortlist before creating any long-term asset.
- Each suggestion should include candidate, evidence, confidence, suggested form, and recommendation.
- Wait for user approval before creating or updating `docs/lessons.md`, `docs/decisions.md`, `docs/patterns.md`, `docs/asset-candidates.md`, skills, subagents, automations, or templates.

### iteration_enabled

Use only after the user explicitly asks to enable iteration, continuous learning, project knowledge capture, experience accumulation, or similar behavior.

Behavior:

- Record iteration state in `AGENTS.md`.
- Before each task, read existing project guidance and relevant lessons or decisions when present.
- After each task, screen for reusable lessons, decisions, patterns, and asset candidates.
- Update long-term knowledge files only when the item is stable, useful for future work, supported by evidence, and not merely a one-off preference.
- Keep knowledge entries concise, dated, and traceable to the relevant task ID.
- If a candidate affects project direction, architecture, security, permissions, data, deployment, or user-facing standards, ask before saving it even when iteration is enabled.

## 6. What Not To Do

Do not create these by default:

- `.codex/`
- `.agents/`
- `specs/`
- `scripts/`
- `contracts/`
- `artifacts/`
- `tests/`
- framework folders such as `src/`, `app/`, `frontend/`, `backend/`

Create them only when the current project, technology stack, or user request clearly requires them.

Do not create these iteration files by default:

- `docs/lessons.md`
- `docs/decisions.md`
- `docs/patterns.md`
- `docs/asset-candidates.md`
- project-level templates
- new skills
- custom subagents
- automations

Create or update them only when the user has explicitly enabled iteration or has approved the specific item to save.

Do not turn small edits into heavy process.

For a simple one-file or two-file change, create a lightweight task record and continue.

## 7. Minimal Workspace

When the workspace needs Codex collaboration structure, use this minimal shape:

```text
project-root/
├── AGENTS.md
├── docs/
│   ├── overview.md
│   └── commands.md
└── tasks/
    ├── README.md
    ├── _index.md
    ├── _templates/
    │   ├── task.md
    │   ├── plan.md
    │   ├── tasks.md
    │   └── result.md
    └── YYYY/
        └── MM/
            └── T-YYYYMMDD-NNN-short-name/
                ├── task.md
                ├── plan.md
                ├── tasks.md
                └── result.md
```

For complex tasks only, the task package may also include:

- `research.md`
- `notes.md`
- `screenshots/`
- `examples/` when sample inputs/outputs are needed

## 8. Workspace Readiness Check

Before starting a coding task, quickly classify the workspace.

### empty

No meaningful project files exist.

Actions:

- If the user has named a concrete stack, create the smallest viable framework for that stack.
- If the stack is unclear, create only `AGENTS.md`, `README.md`, `docs/`, and `tasks/` unless a reasonable default is obvious.
- Do not invent a technology stack unless the user asks for a recommendation or the task cannot proceed without one.

### basic_framework

A framework exists, but Codex collaboration structure is missing.

Signals:

- Files such as `package.json`, `pom.xml`, `build.gradle`, `vite.config.*`, `next.config.*`, `src/`, or similar exist.
- `AGENTS.md` or `tasks/` is missing.

Actions:

- Add only missing `AGENTS.md`, `docs/overview.md`, `docs/commands.md`, and `tasks/`.
- Do not alter framework layout.
- Populate `docs/commands.md` from discovered scripts and build files when possible.

### existing_project

A mature project exists.

Actions:

- Add or update only the minimal Codex collaboration layer.
- Summarize important directories in `docs/overview.md`.
- Summarize run, build, lint, and test commands in `docs/commands.md`.
- Preserve all existing project structure.

### task_ready

The project already has `AGENTS.md`, `docs/`, and `tasks/`.

Actions:

- Do not reinitialize.
- Create or update the relevant task package and proceed.

## 9. Workspace Improvement Checklist

When improving a project workspace, inspect only what is necessary.

Check:

- Is there an existing framework or source structure?
- Is there an `AGENTS.md`?
- Is there a clear project overview?
- Are run, build, lint, format, and test commands discoverable?
- Is there a task tracking structure?
- Are there existing conventions that should be preserved?
- Are there missing files that would materially improve future Codex work?

Rules:

- Only add files that directly improve future task execution.
- Do not create placeholder directories without immediate use.
- Do not create broad documentation that duplicates existing docs.
- Prefer short, accurate docs over long guessed docs.

## 10. Git Safety Rules

Before editing code, protect the user's existing work.

When Git is available:

1. Run `git status --short` before editing.
2. Identify files with existing user changes.
3. Do not overwrite, revert, move, rename, or reformat user-changed files unless the current task explicitly requires it.
4. If a target file already has unrelated user changes, preserve them and mention the condition in `result.md`.
5. Do not create commits, branches, tags, resets, rebases, stashes, or force operations unless the user explicitly asks.
6. Use `git diff` or an equivalent file comparison to summarize actual changes before the final response.

When Git is not available:

- Record `Git not available or not a repository` in `plan.md` or `result.md` when relevant.
- Still avoid overwriting unknown existing files.

If there is conflict between the requested change and existing user modifications:

- Prefer a minimal patch that preserves both.
- If safe merging is not possible, set the task to `blocked` and ask for the specific decision needed.

## 11. Dependency Rules

Do not add, remove, or upgrade dependencies unless necessary for the current task.

Before changing dependencies:

1. Prefer existing project libraries and patterns.
2. Check whether the same result can be achieved without a new dependency.
3. Consider security, license, bundle size, build compatibility, and maintenance cost.

When changing dependencies:

1. Explain why the dependency change is needed.
2. Update lock files when the package manager requires it.
3. Record dependency changes in `result.md`.
4. Run relevant install/build/test verification when possible.
5. Ask before adding large, security-sensitive, license-sensitive, or architecture-defining dependencies.

## 12. User Confirmation Gates

Ask for user confirmation before high-impact or hard-to-reverse decisions.

Confirmation is required before:

- Changing database schema or migration strategy.
- Modifying authentication, authorization, permissions, payment, transaction, or audit logic.
- Changing deployment, environment, build, Docker, CI/CD, or release configuration.
- Removing, renaming, or moving major files or directories.
- Introducing a new framework, major dependency, code generator, or architecture pattern.
- Changing public API contracts or data formats used by external systems.
- Making broad UI redesigns when the request only asks for a small fix.
- Making decisions that affect multiple future tasks or project direction.
- Saving long-term lessons, decisions, patterns, templates, skills, subagents, or automations when iteration is not enabled.

Do not ask for confirmation for ordinary low-risk edits that are clearly requested by the user.

## 13. Task Resumption

Before creating a new task package:

1. Check `tasks/_index.md` when it exists.
2. Look for tasks with status `in_progress`, `blocked`, or `review`.
3. If the user request clearly continues an existing task, reuse that task package.
4. If the request is clearly new, create a new task package.
5. If uncertain and risk is low, create a new task and reference the related previous task in `plan.md`.
6. Do not duplicate task packages for the same unfinished work.

## 14. Task Package Naming

Use this format:

```text
tasks/YYYY/MM/T-YYYYMMDD-NNN-short-name/
```

Rules:

- `YYYY/MM` uses the current local date.
- `NNN` is the next available sequence number for that day.
- `short-name` is lowercase, concise, and English if practical.
- Prefer type hints in the name when helpful:
  - `bugfix-login-captcha`
  - `feature-user-export`
  - `refactor-order-service`
  - `docs-api-usage`

## 15. Task Status

Use these statuses:

- `planned`: task package exists, but implementation has not started.
- `in_progress`: implementation is underway.
- `blocked`: work cannot continue without user input, missing dependency, conflict, or unresolved risk.
- `review`: implementation is complete and awaiting human review or manual validation.
- `done`: implementation and reasonable verification are complete.

## 16. Difficulty Routing

Always record difficulty in `task.md` and `plan.md`.

### quick profile

Use as an execution profile for very small, low-risk edits.

Typical signals:

- One small change in one file.
- No architecture, data, security, deployment, or cross-module impact.
- The user likely wants speed more than formal tracking.

Behavior:

- Difficulty is still recorded as `simple`.
- Create the standard task package if the project already uses task tracking.
- Keep `plan.md`, `tasks.md`, and `result.md` very short.
- Verification may be limited to the most relevant command or direct file review.
- Do not create extra research notes or long retrospective notes.

### simple

Use for small, low-risk changes.

Typical signals:

- Expected changes in 1-2 files.
- No database changes.
- No authentication, authorization, payment, transaction, security, or deployment risk.
- No cross-frontend/backend coordination.
- Can be completed in 3-5 clear steps.

Behavior:

- Create the standard task package.
- Keep `plan.md` short.
- `tasks.md` may contain one small phase.
- Do not create subtasks beyond checklist steps.

### medium

Use for ordinary feature work or moderate bug fixes.

Typical signals:

- Expected changes in 3-6 files.
- Cross-component or cross-layer changes.
- API integration, state management, UI behavior, or focused tests are involved.
- Some regression risk exists.

Behavior:

- Create the standard task package.
- Split `tasks.md` into phases.
- Track `current_step` and `next_step` in `task.md`.
- Update progress after each meaningful step.

### complex

Use for high-risk or broad changes.

Typical signals:

- Expected changes in more than 6 files.
- Database schema, permissions, security, transactions, core business flows, or multi-module architecture are involved.
- Requirements are ambiguous.
- The task could naturally become multiple PRs or independent deliverables.

Behavior:

- Create the standard task package.
- Complete planning before implementation.
- Add `research.md` only if investigation findings need to be preserved.
- Ask for confirmation before large irreversible design choices.
- Split work into independently verifiable phases or child task sections.

## 17. AGENTS.md Bootstrap Content

When creating or supplementing `AGENTS.md`, keep it concise. Include only durable rules.

```md
# AGENTS.md

## Project Guidance

- Follow existing project conventions before introducing new patterns.
- Keep changes scoped to the current task.
- Do not move, rename, or mass-format existing files unless the task explicitly requires it.
- Protect existing user changes before editing.
- Use `rg` for code search when available.

## Commands

See `docs/commands.md` for setup, run, build, lint, format, and test commands.

## Task Workflow

Coding tasks are tracked under `tasks/`.

For each coding task:

1. Create or reuse one task package under `tasks/YYYY/MM/`.
2. Update `task.md`, `plan.md`, `tasks.md`, and `result.md`.
3. Judge task difficulty as `simple`, `medium`, or `complex`.
4. Keep `tasks.md` checkboxes current as steps are completed.
5. Mark `task.md` as `done` only after implementation and reasonable verification are complete.

## Git Safety

- Check Git status before editing when Git is available.
- Preserve unrelated user changes.
- Do not commit, reset, rebase, stash, or create branches unless explicitly requested.

## Minimal Directory Rule

Do not create `.codex/`, `.agents/`, `specs/`, `scripts/`, `contracts/`, `artifacts/`, or new framework directories unless the current task clearly requires them.

## Iteration

- Status: disabled
- Long-term knowledge files must not be created unless the user enables iteration or approves a specific candidate.
```

## 18. Iteration State

Iteration is disabled by default.

When the user explicitly enables iteration, record the state in `AGENTS.md`:

```md
## Iteration

- Status: enabled
- Enabled at: YYYY-MM-DD
- Knowledge files:
  - `docs/lessons.md`
  - `docs/decisions.md`
  - `docs/patterns.md`
  - `docs/asset-candidates.md`
- Rule: save only stable, useful, evidence-backed items that can help future tasks.
```

Rules:

- Do not create empty knowledge files only because iteration was enabled, unless the user asks to initialize them.
- Create a knowledge file when the first approved or in-scope item needs to be saved.
- If iteration is later disabled, update `AGENTS.md` and stop writing long-term knowledge files.
- Even when iteration is enabled, ask before saving items that affect architecture, security, permissions, data, deployment, or user-facing standards.

## 19. Task File Templates

### task.md

```md
---
id: T-YYYYMMDD-NNN
title: Short task title
type: feature
request_type: feature_task
status: planned
difficulty: medium
mode: task_only
has_subtasks: true
current_step: T001
next_step: T002
created_at: YYYY-MM-DD
updated_at: YYYY-MM-DD
---

# Task

## Goal

Describe the user-facing or engineering goal.

## Scope

### Included

- Item

### Excluded

- Item

## Context

- User request summary:
- Related task, if any:
- Existing constraints:

## Current Progress

Current step: T001
Next step: T002
```

### plan.md

```md
# Plan

## Classification

- Request type: feature_task
- Mode: task_only
- Difficulty: medium
- Quick profile: no

## Difficulty Reasoning

- Reason

## Git Safety

- Git status checked: yes/no/not a git repo
- Existing user changes to preserve:
  - None

## Existing Context

- Important project fact

## Files To Read

- `path/to/file`

## Expected Files To Change

- `path/to/file`

## Files Not To Touch

- `path/to/file`

## Dependency Plan

- New dependencies: none
- Dependency changes: none

## Confirmation Gates

- None

## Implementation Strategy

1. Step
2. Step
3. Step

## Risks

- Risk and mitigation

## Verification

- Command or manual check
```

### tasks.md

```md
# Tasks

## Phase 1: Understand

- [ ] T001 Read `path/to/file` to understand current behavior
- [ ] T002 Confirm the change boundary

## Phase 2: Implement

- [ ] T003 Modify `path/to/file` to implement the change

## Phase 3: Verify and Close

- [ ] T004 Run relevant checks
- [ ] T005 Update `result.md`
- [ ] T006 Update `tasks/_index.md`
```

Rules:

- Every task item must start with a checkbox.
- Every task item must have a stable ID such as `T001`.
- Include exact file paths whenever a file is known.
- Mark `[P]` only when two steps can safely run in parallel because they touch different files and have no dependency.
- Keep steps concrete enough that another Codex session can continue from them.

### result.md

```md
# Result

## Status

done

## Completed

- Item

## Changed Files

- `path/to/file`

## Dependency Changes

- None

## Verification

- Check or command: result

## Verification Gaps

- None

## Remaining Issues

- None

## Risks

- Residual risk, if any

## Conversation Notes

- User decisions:
- User corrections:
- Reusable preferences:
- Open questions:

## Retrospective

- Lessons learned: None
- Reusable patterns: None
- Asset candidates: None
```

## 20. tasks/README.md Template

```md
# Tasks

This directory tracks coding work so future Codex sessions can resume context.

Each task package should contain:

- `task.md`: goal, scope, status, difficulty, and current step
- `plan.md`: implementation plan, risks, files, and verification
- `tasks.md`: step checklist with stable IDs
- `result.md`: completed work, changed files, verification, risks, and retrospective notes

Use `tasks/_index.md` as the short task list.
```

## 21. tasks/_index.md Template

Keep this file short and useful.

```md
# Task Index

| ID | Title | Status | Difficulty | Path | Updated |
|---|---|---|---|---|---|
| T-YYYYMMDD-NNN | Short title | in_progress | medium | `tasks/YYYY/MM/T-.../` | YYYY-MM-DD |
```

Update it when creating, completing, reviewing, or blocking a task.

## 22. Execution Rules

### Before Editing Code

1. Classify the request.
2. Check workspace readiness.
3. Check Git status when Git is available.
4. Create or reuse the task package when the request modifies project files.
5. Fill `task.md`, `plan.md`, and `tasks.md`.
6. Set `task.md` status to `in_progress`.
7. For complex tasks, finish the plan before editing code.
8. Stop for confirmation only when a confirmation gate is reached.

### While Editing Code

After each meaningful step:

- Mark the matching checkbox in `tasks.md`.
- Update `current_step`, `next_step`, and `updated_at` in `task.md`.
- If the plan changes materially, update `plan.md`.
- Preserve unrelated user changes.

Do not delay all status updates until the final response for medium or complex tasks.

### When Done

1. Run the most relevant available verification.
2. Update all completed checkboxes in `tasks.md`.
3. Set `task.md` status to `done`, `review`, or `blocked`.
4. Update `result.md` with completed work, changed files, dependency changes, verification, verification gaps, remaining issues, risks, and task-local retrospective notes.
5. Update `tasks/_index.md`.
6. Use `git diff` or equivalent to review actual changes when possible.
7. If iteration is not enabled, do not create long-term knowledge files; provide suggestions only when useful and ask for approval first.
8. If iteration is enabled, update approved or clearly in-scope knowledge files according to the Knowledge Capture Rules.

### When Blocked

If blocked:

1. Set `task.md` status to `blocked`.
2. Record the blocker in `result.md`.
3. Leave `next_step` as the next useful action.
4. Ask the user only for the specific information or decision needed.
5. Do not mark the task as done.

## 23. Definition of Done

A task can be marked `done` only when:

- The requested change has been implemented or explicitly deemed unnecessary.
- Relevant verification has been run, or the reason for not running it is recorded.
- `tasks.md` checkboxes are updated.
- `task.md` status, current step, next step, and updated date are updated.
- `result.md` records completed work, changed files, dependency changes, verification, remaining issues, and risks.
- `tasks/_index.md` is updated.
- No known blocker remains.

Use `review` instead of `done` when implementation is complete but human/manual validation is still required.

Use `blocked` when work cannot safely continue.

## 24. Verification Rules

Run the most relevant verification available for the project and task.

Examples:

- Frontend: build, lint, unit tests, targeted component checks, visual/manual browser check when needed.
- Backend: unit tests, integration tests, compile, targeted API/manual check.
- Java/Spring: `mvn test`, `mvn -DskipTests package`, Gradle equivalents, or targeted tests.
- Node: package scripts from `package.json`.
- Documentation-only: spelling/format review and consistency check against source files.

Do not invent verification commands.

If a command is unknown, inspect project files first.

## 25. Verification Failure Handling

If verification cannot be completed:

1. Record the command attempted.
2. Record the exact failure reason.
3. Distinguish between task-caused failure and pre-existing/environmental failure when possible.
4. Do not claim verification passed.
5. Set status to `review` if implementation is complete and only external/manual validation remains.
6. Set status to `blocked` if the failure prevents completing implementation.

Examples of acceptable verification gaps:

- Dependency installation unavailable.
- Command missing from project files.
- Build requires unavailable environment variables.
- Test database or external service unavailable.
- Existing unrelated test failures block full test execution.

## 26. Knowledge Capture Rules

Codex may screen for reusable knowledge, but the user owns the decision.

Only suggest or save a candidate when it:

- Occurred at least twice, or is clearly likely to recur and costly to rediscover.
- Has stable inputs, a repeatable procedure, and a clear output or stopping condition.
- Would materially improve speed, quality, consistency, or reliability.
- Is not already adequately covered by existing project guidance or skills.

Choose the smallest appropriate form:

- Project lesson: a project-specific convention, pitfall, command issue, or maintenance note.
- Decision record: a durable technical, product, architecture, security, or delivery decision.
- Pattern: a repeatable implementation shape inside this project.
- Template: a reusable file or code structure.
- Skill: a reusable workflow or playbook across projects.
- Custom subagent: a bounded specialist role or investigation task suitable for delegation.
- Automation: a scheduled or recurring check, report, reminder, or monitor.
- Skip: work that is too one-off, ambiguous, sensitive, or poorly evidenced.

Do not save candidates that are:

- One-off implementation details.
- Unstable preferences.
- Sensitive secrets, tokens, credentials, or private data.
- Poorly evidenced guesses.
- Already covered by existing docs.

## 27. Retrospective Candidate Format

When reusable knowledge may exist but iteration is not enabled, present candidates like this:

```md
| Candidate | Evidence | Confidence | Suggested Form | Recommendation | User Decision |
|---|---|---|---|---|---|
| Item | Source task, repeated issue, observed correction, or recurring need | high/medium/low | lesson/decision/pattern/template/skill/subagent/automation/skip | save/skip/discuss | pending |
```

Rules:

- Do not save candidates until the user approves them.
- Keep the shortlist compact.
- Prefer `skip` when the value is unclear.
- Prefer project lesson or decision before creating a new skill.
- Suggest a new skill only when the workflow is reusable across projects.
- Suggest a custom subagent only when the role is bounded and repeatedly useful.
- Suggest automation only when the task is recurring and has a clear trigger and output.

## 28. Conversation Learning

At task close, Codex may screen the conversation for reusable signals:

- User preferences that affected implementation.
- Repeated corrections from the user.
- Requirements clarified during the task.
- Mistakes Codex made and how they were corrected.
- Useful prompts, checklists, or workflows discovered during the task.
- Decisions that should be remembered for future tasks.

Rules:

- If iteration is not enabled, record only task-local notes in `result.md` and present candidates to the user when useful.
- If iteration is enabled, save only stable, useful, evidence-backed items according to Knowledge Capture Rules.
- Do not preserve private or sensitive data as reusable knowledge.
- Do not turn every user preference into a global rule.

## 29. Knowledge File Templates

Create these files only when iteration is enabled or the user approves a specific item.

### docs/lessons.md

```md
# Lessons

| Date | Task ID | Lesson | Evidence | Applies To | Confidence |
|---|---|---|---|---|---|
| YYYY-MM-DD | T-YYYYMMDD-NNN | Lesson learned | What happened | Area/module | high/medium/low |
```

### docs/decisions.md

```md
# Decisions

## D-YYYYMMDD-NNN: Decision title

- Date:
- Source task:
- Status: active / superseded
- Decision:
- Reason:
- Alternatives considered:
- Impact:
- Review condition:
```

### docs/patterns.md

```md
# Patterns

## Pattern name

- Source task:
- Problem:
- Context:
- Solution:
- Steps:
- Example files:
- When to use:
- When not to use:
```

### docs/asset-candidates.md

```md
# Asset Candidates

| Date | Task ID | Candidate | Type | Evidence | Recommended Action | Status |
|---|---|---|---|---|---|---|
| YYYY-MM-DD | T-YYYYMMDD-NNN | Item | skill/template/subagent/automation | Why it may recur | save/skip/discuss | pending |
```

## 30. Workspace Documentation

### docs/overview.md

Keep this as a short project map:

- Project purpose
- Tech stack detected or declared
- Important directories
- Important entry points
- Notes for future Codex sessions

Do not write speculative architecture.

### docs/commands.md

Record commands discovered from project files:

- Install dependencies
- Run dev server
- Build
- Lint
- Format
- Test

If a command is unknown, write `Not identified yet` rather than inventing it.

Example:

```md
# Commands

## Install

- Not identified yet

## Run

- Not identified yet

## Build

- Not identified yet

## Lint

- Not identified yet

## Test

- Not identified yet
```

## 31. Empty Directory Bootstrap

If the directory is empty and the user asks to create a project:

1. Identify the requested product and technology stack.
2. If the stack is explicit, create the smallest viable project for that stack.
3. If the stack is not explicit, ask one concise clarification unless a reasonable default is obvious from the user's wording.
4. Always add the minimal Codex workflow files.
5. Create the first task package for the bootstrap work.
6. Run the relevant verification.
7. Close the bootstrap task.

## 32. Existing Project Bootstrap

If the project already exists:

1. Detect existing stack from files.
2. Do not reorganize the project.
3. Add missing minimal workflow files only.
4. Populate `docs/overview.md` and `docs/commands.md` from discovered files.
5. Create a task package describing the bootstrap change if files are added or updated.
6. Verify that added files do not interfere with project build/runtime.

## 33. Final Response

When reporting back to the user:

- Keep it concise.
- Mention the task ID and status.
- Mention changed files.
- Mention verification performed.
- Mention blockers or residual risk if any.
- Mention dependency changes if any.
- If useful, include a compact retrospective shortlist and ask before saving any long-term asset unless iteration is already enabled.

Do not paste the full task files unless the user asks.

Recommended final response shape:

```md
完成了。

- Task: T-YYYYMMDD-NNN
- Status: done/review/blocked
- Changed files:
  - `path/to/file`
- Verification:
  - command/result
- Risk:
  - none or concise note

Reusable candidates, if any:
- candidate summary and whether approval is needed
```
