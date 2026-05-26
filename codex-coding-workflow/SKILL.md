---
name: codex-plan-task-workflow
description: Use when Codex implements or applies a coding plan ("实施计划", "按计划执行", "开始编码"), changes project files, bootstraps a workspace, or resumes coding work; must create/reuse tasks/... and update tasks.md before editing. Do not use for read-only chat or plan-only discussion.
---

# Codex Plan Task Workflow

Version: v0.4

## Goal

Help Codex turn coding work into a traceable execution loop:

1. Prepare the smallest complete Codex working directory.
2. When implementing a plan, create or reuse a task package and write `tasks.md` before editing project files.
3. After completion, extract reusable lessons from the Codex conversation as skill candidates, but do not write long-term knowledge without user approval.

This skill is not a general coding assistant. It is a project workflow guardrail.

## When To Use

Use this skill when the user asks Codex to:

- implement a plan
- apply a plan
- execute a plan
- start coding
- make code changes
- fix a bug
- add a feature
- refactor files
- update project documentation
- initialize an empty workspace
- improve a workspace for Codex collaboration
- resume unfinished tracked work

Also use it for Chinese prompts such as:

- 实施计划
- 按计划执行
- 开始编码
- 继续上次任务
- 创建工作目录
- 初始化项目协作目录
- 把计划落到 tasks
- 按 tasks 执行

Do not use this skill for:

- read-only discussion
- plan-only analysis
- architecture advice with no file changes
- code review where the user did not ask for task tracking
- general Q&A

## Mandatory Rule: Plan To Tasks Before Editing

If the user asks to implement, apply, or execute a plan, Codex must not edit project files until it has:

1. Checked the workspace state.
2. Checked Git status when Git is available.
3. Created or reused a task package under `tasks/`.
4. Copied or summarized the accepted plan into `plan.md`.
5. Converted the plan into executable checklist items in `tasks.md`.
6. Marked the task status as `in_progress`.

This applies even if the plan was created in Codex plan mode.

For very small changes, keep the task files short. Do not skip them when the user says "实施计划", "按计划执行", or equivalent.

## Workspace Structure

When the workspace is empty, basic, or missing Codex collaboration files, create only the smallest useful structure:

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

Rules:

- Do not reorganize existing project files.
- Do not invent framework choices.
- Do not create extra directories unless the current task needs them.
- Fill unknown commands as `Not identified yet`.
- Keep `AGENTS.md` short and durable.

## Task Package Shape

Use local date.

```text
tasks/YYYY/MM/T-YYYYMMDD-NNN-short-name/
├── task.md
├── plan.md
├── tasks.md
└── result.md
```

Required files:

- `task.md`: goal, scope, status, difficulty, current step, next step, timestamps.
- `plan.md`: accepted plan, implementation strategy, risks, verification strategy.
- `tasks.md`: executable checklist with stable IDs such as `T001`, `T002`.
- `result.md`: changed files, completed items, verification, gaps, risks, learning candidates.

Update `tasks/_index.md` whenever a task is created, completed, blocked, or moved to review.

## Execution Rules

After creating the task package:

1. Execute tasks in `tasks.md` order unless a safer order is discovered.
2. Update checkboxes after meaningful progress.
3. Update `task.md` `current_step`, `next_step`, `status`, and `updated_at`.
4. Before final response, inspect the actual diff or changed files.
5. Run the most relevant available verification.
6. If verification cannot run, record the exact reason in `result.md`.
7. Do not claim "done", "fixed", or "ready" without verification evidence or a stated verification gap.

## Difficulty

Use the smallest useful level:

- `quick`: one small low-risk change, but still tracked when implementing an accepted plan.
- `simple`: one or two files, low regression risk.
- `medium`: several files, API/state/test impact, or meaningful regression risk.
- `complex`: broad, ambiguous, security/data/auth/deployment-sensitive, or multiple deliverables.

## Conversation Learning

At the end of each tracked task, extract reusable learning candidates from:

- the user's corrections
- repeated mistakes
- successful implementation patterns
- project-specific conventions
- prompts that caused better results
- verification or deployment lessons

Write candidates only inside the current task's `result.md` unless the user has explicitly enabled iteration or approved long-term storage.

Use this format:

```md
## Learning Candidates

### LC001: Short title
- Source: user correction / Codex mistake / successful pattern
- Trigger: when this should apply
- Lesson: what should be remembered
- Suggested target: AGENTS.md / existing skill / new skill / docs
- Confidence: low / medium / high
- User approval required: yes
```

Do not update long-term files such as `AGENTS.md`, `docs/lessons.md`, or `.agents/skills/...` unless the user approves.

If the user approves, convert the candidate into the smallest possible durable rule or skill patch.

## Final Response

When finished, report:

- task package path
- completed task IDs
- changed files
- verification command and result
- remaining gaps or risks
- learning candidates that need user approval
