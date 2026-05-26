# Codex Coding Workflow Skill

一个面向 Codex 编码任务的 workflow skill，帮助 Codex 在项目初始化、任务拆解、实现、验证和结果记录之间保持可追踪、可恢复、低侵入。

## 特性

- 支持初始化空白或半成品编码 workspace。
- 为已有项目补齐最小 `AGENTS.md`、`docs/`、`tasks/` 协作结构。
- 支持 feature、bugfix、refactor、documentation、review 等任务分类。
- 在修改代码前检查 Git 状态，保护用户已有改动。
- 按任务复杂度生成轻量或完整的计划、步骤和结果记录。
- 在实现后记录验证结果、剩余风险、任务状态和可复用经验候选。
- 默认不创建长期知识库、自动化、子代理或额外目录，除非用户明确启用或批准。

## 适用场景

- 希望 Codex 不只生成代码，而是按工程流程完成编码任务。
- 希望每个任务都有可恢复的计划、进度和结果记录。
- 希望在多人或多轮 Codex 会话中保留上下文。
- 希望给现有项目补齐最小的 Codex 协作规范。

## 仓库结构

```text
.
├── codex-coding-workflow/
│   ├── SKILL.md
│   └── agents/
│       └── openai.yaml
├── install.ps1
├── LICENSE
└── README.md
```

## 安装

### 方式一：使用安装脚本

Windows PowerShell：

```powershell
.\install.ps1
```

默认安装到：

```text
%USERPROFILE%\.codex\skills\codex-coding-workflow
```

也可以指定安装目录：

```powershell
.\install.ps1 -Destination "$env:USERPROFILE\.codex\skills\codex-coding-workflow"
```

注意：如果目标目录已存在，安装脚本会先删除目标目录，再复制当前仓库中的 `codex-coding-workflow/`。

### 方式二：手动复制

```powershell
$target = Join-Path $env:USERPROFILE ".codex\skills\codex-coding-workflow"
New-Item -ItemType Directory -Force -Path (Split-Path $target) | Out-Null
Copy-Item -Recurse -Force ".\codex-coding-workflow" $target
```

## 使用方式

安装后，可以在 Codex 提示词中显式调用：

```text
Use $codex-coding-workflow to initialize this workspace and implement the requested change.
```

也可以用更具体的任务描述：

```text
Use $codex-coding-workflow to fix this bug, update the task records, and run the relevant verification.
```

## 工作流概览

该 skill 会指导 Codex 按以下顺序处理编码任务：

1. 理解用户请求并判断任务类型。
2. 检查 workspace 是否需要补齐协作结构。
3. 检查 Git 状态并保护已有改动。
4. 按任务复杂度创建或复用任务包。
5. 编写计划、步骤、风险和验证方式。
6. 执行实现并持续更新任务进度。
7. 运行相关验证，或记录无法验证的原因。
8. 更新任务结果，将状态标记为 `done`、`review` 或 `blocked`。

## 任务记录结构

当项目需要任务跟踪时，skill 会使用类似结构：

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

复杂任务可能额外包含 `research.md`、`notes.md`、`screenshots/` 或 `examples/`。

## 设计原则

- 小任务保持轻量，不引入不必要流程。
- 优先遵循现有项目约定。
- 默认只创建完成当前任务所需的最小文件。
- 不擅自移动、重命名、重构或大范围格式化已有文件。
- 不擅自提交、重置、变基、stash 或创建分支。
- 不擅自新增依赖，除非当前任务确实需要。
- 不擅自保存长期经验、决策、模式、模板、skill、subagent 或 automation。

## 配置说明

Codex 入口配置位于：

```text
codex-coding-workflow/agents/openai.yaml
```

当前配置允许隐式调用：

```yaml
policy:
  allow_implicit_invocation: true
```

skill 主体说明位于：

```text
codex-coding-workflow/SKILL.md
```

## 版本

当前 skill 内容版本：`v0.2`。

## 贡献

欢迎通过 issue 或 pull request 改进这个 skill。

建议提交前检查：

- README 与 `SKILL.md` 描述是否一致。
- 示例命令是否适用于 Windows PowerShell。
- 是否避免加入与当前 skill 无关的目录、依赖或自动化。
- 是否保持 workflow 低侵入、可追踪、可恢复。

## License

本项目使用 MIT License，详见 [LICENSE](LICENSE)。
