# Codex Coding Workflow Skill

一个用于 Codex 编码任务的 workflow skill，目标是让 Codex 在项目初始化、任务拆解、实现、验证和结果记录之间保持可追踪、可恢复、低侵入。

## 适用场景

- 初始化空白或半成品编码 workspace
- 为已有项目补齐最小 `AGENTS.md`、`docs/`、`tasks/` 协作结构
- 拆解 feature、bugfix、refactor、documentation、review 等任务
- 在修改代码前检查 Git 状态并保护用户已有改动
- 在实现后记录验证结果、剩余风险和任务状态

## 安装

把 `codex-coding-workflow/` 目录复制到你的 Codex skills 目录。

Windows PowerShell 示例：

```powershell
$target = Join-Path $env:USERPROFILE ".codex\skills\codex-coding-workflow"
New-Item -ItemType Directory -Force -Path (Split-Path $target) | Out-Null
Copy-Item -Recurse -Force ".\codex-coding-workflow" $target
```

安装后，可以在提示词中显式调用：

```text
Use $codex-coding-workflow to initialize this workspace and implement the requested change.
```

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

## 版本

当前 skill 内容版本：`v0.2`。

## License

MIT
