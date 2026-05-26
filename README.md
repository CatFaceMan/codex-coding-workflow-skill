# Codex Plan Task Workflow Skill

一个面向 Codex 编码实施阶段的 workflow skill。它不做泛化的编码流程治理，而是专注一个更窄的闭环：

```text
工作目录初始化 -> 计划落地为 tasks -> 按 tasks 执行 -> 从对话中提炼可复用技能候选
```

核心规则：当用户说“实施计划”“按计划执行”“开始编码”或类似表达时，Codex 在编辑项目文件前必须创建或复用 `tasks/...` 任务包，并写入 `plan.md` 和 `tasks.md`。

## 特性

- 强触发词：描述中包含真实使用短语，如 `实施计划`、`按计划执行`、`开始编码`。
- 单一职责：主 skill 直接定义 plan-to-tasks 执行闭环，不再拆成多个 competing child skills。
- 最小工作目录：需要初始化时只补齐 `AGENTS.md`、`docs/`、`tasks/` 的最小有用结构。
- 任务可恢复：使用 `tasks/YYYY/MM/T-.../` 记录目标、计划、步骤、结果和验证。
- 完成后沉淀：从本次对话提炼 learning candidates，默认只写入当前 `result.md`，长期写入必须经用户批准。

## 适合场景

- 用户确认了计划，并要求 Codex 实施。
- 用户说“实施计划”“按计划执行”“开始编码”。
- Codex 要修改项目文件、修复 bug、添加功能、重构或更新文档。
- 需要初始化空 workspace 或补齐 Codex 协作目录。
- 需要继续上次已跟踪的任务。

## 不适合场景

- 纯讨论、纯问答、纯架构建议。
- 只让 Codex 制定计划，但还没有要求执行。
- 用户没有要求 task tracking 的只读 code review。

## 仓库结构

```text
.
├── codex-coding-workflow/
│   ├── SKILL.md
│   └── agents/
│       └── openai.yaml
├── tests/
│   ├── check-skill-metadata.py
│   └── prompts/
├── install.ps1
├── install.sh
├── LICENSE
└── README.md
```

> 说明：源码目录暂时保留历史名称 `codex-coding-workflow/`，实际 skill frontmatter name 是 `codex-plan-task-workflow`，安装脚本也会安装到 `codex-plan-task-workflow` 目标目录。

## 安装

推荐安装到通用 Agent Skills 路径：

```text
~/.agents/skills
```

兼容 Codex 旧路径：

```text
~/.codex/skills
```

### Unix-like shell

默认安装到 `~/.agents/skills/codex-plan-task-workflow`：

```sh
./install.sh
```

显式安装到 Codex 旧路径：

```sh
./install.sh "$HOME/.codex/skills"
```

### PowerShell

默认安装到 `%USERPROFILE%\.agents\skills\codex-plan-task-workflow`：

```powershell
.\install.ps1
```

显式安装到 Codex 旧路径：

```powershell
.\install.ps1 -DestinationRoot "$env:USERPROFILE\.codex\skills"
```

旧参数 `-Destination` 仍可使用；它表示 skill 的完整目标目录。

## 使用方式

显式调用：

```text
Use $codex-plan-task-workflow to implement this plan. Create or reuse tasks/..., write plan.md and tasks.md before editing, then execute the checklist.
```

中文触发示例：

```text
实施计划
```

```text
按计划执行，先把计划落到 tasks.md
```

```text
开始编码，按 tasks 执行
```

## 任务记录结构

实施类任务使用：

```text
tasks/
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

`result.md` 应记录：

- changed files
- completed task IDs
- verification command and result
- remaining gaps or risks
- learning candidates

## 测试

运行 metadata 检查：

```powershell
python tests/check-skill-metadata.py
```

测试 prompt 位于：

```text
tests/prompts/
```

这些 prompt 用来人工或自动检查触发边界，例如：

- “实施计划”应触发 `codex-plan-task-workflow` 并先创建 task package。
- plan-only 不应创建任务包。
- review-only 不应创建任务包。
- empty workspace 应触发最小工作目录初始化。

## 后续方向

如果需要进一步降低漏触发概率，建议升级为 plugin + hooks：

```text
skill = 规则和流程
hook = 强制提醒/拦截
plugin = skill + hook 的发行包
```

优先考虑：

- `UserPromptSubmit`：识别“实施计划”等提示词并追加上下文。
- `PreToolUse`：首次编辑前检查是否已有 active task package。
- `Stop`：结束前检查 `result.md`、verification 和未完成任务。

## 版本

当前 skill 内容版本：`v0.4`。

## License

MIT License，详见 [LICENSE](LICENSE)。
