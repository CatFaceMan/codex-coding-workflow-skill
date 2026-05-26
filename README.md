# Codex Coding Workflow Skill

一个面向 Codex 的轻量 coding workflow skill 包，帮助 Codex 在编码任务中保持低侵入、可追踪、可恢复，并在完成前进行合理验证。

它不是 superpowers 的完整复刻：不强制 TDD、不强制 worktree、不强制 subagent，也不默认创建长期知识库。它优先解决 Codex 日常编码协作中的实际问题。

## 特性

- Codex-first：围绕 Codex 编码任务、workspace、task package、resume work 和 verification 设计。
- 模块化：根入口负责路由，子 skill 分别处理 bootstrap、task tracking、git safety 和 completion verification。
- 低侵入：小改动保持小流程，不把简单任务变成重流程。
- 可恢复：需要跟踪的任务使用 `tasks/YYYY/MM/T-.../` 记录目标、计划、步骤和结果。
- 安全编辑：修改前检查 Git 状态，保护用户已有改动。
- 完成前验证：能跑验证就跑；不能跑时记录原因和风险。

## 适合场景

- 希望 Codex 不只是生成代码，而是按工程流程完成编码任务。
- 希望 feature、bugfix、refactor、documentation 任务有可恢复的记录。
- 希望给空 workspace 或已有项目补齐最小 Codex 协作结构。
- 希望 Codex 在汇报“完成”前有验证证据。

## 不默认做的事

- 不强制 TDD。
- 不强制创建 git worktree。
- 不强制使用 subagent。
- 不默认创建长期 lessons、decisions、patterns 或 automations。
- 不默认重构项目结构、移动目录或新增框架。

## 仓库结构

```text
.
├── codex-coding-workflow/
│   ├── SKILL.md
│   ├── agents/
│   │   └── openai.yaml
│   └── skills/
│       ├── coding-workflow/
│       ├── workspace-bootstrap/
│       ├── task-tracking/
│       ├── git-safety/
│       └── verification-before-done/
├── tests/
│   ├── check-skill-metadata.py
│   └── prompts/
├── install.ps1
├── install.sh
├── LICENSE
└── README.md
```

## Skill 模块

| Skill | 作用 |
|---|---|
| `codex-coding-workflow` | 根入口，分类请求并选择轻量 workflow |
| `coding-workflow` | 判断 request type、difficulty 和路由 |
| `workspace-bootstrap` | 初始化空 workspace 或补齐最小协作结构 |
| `task-tracking` | 创建/复用任务包，维护任务进度和结果 |
| `git-safety` | 编辑前检查 Git 状态并保护用户改动 |
| `verification-before-done` | 完成前运行验证或记录验证缺口 |

## 安装

### Unix-like shell

```sh
./install.sh
```

指定 Codex skills 目录：

```sh
./install.sh "$HOME/.codex/skills"
```

### PowerShell

```powershell
.\install.ps1
```

指定 Codex skills 根目录：

```powershell
.\install.ps1 -DestinationRoot "$env:USERPROFILE\.codex\skills"
```

旧参数 `-Destination` 仍可使用；它表示根入口 skill 的目标目录，子 skills 会安装到它的父目录。

安装脚本会安装：

- 根入口：`codex-coding-workflow`
- 子 skills：`coding-workflow`、`workspace-bootstrap`、`task-tracking`、`git-safety`、`verification-before-done`

## 使用方式

安装后，可以显式调用：

```text
Use $codex-coding-workflow to classify this coding request, track the task if files change, protect existing changes, and verify before completion.
```

也可以针对具体场景调用子 skill：

```text
Use $workspace-bootstrap to add the smallest useful Codex collaboration structure.
```

```text
Use $verification-before-done to check whether this work can be called complete.
```

## 任务记录结构

当任务需要跟踪时，使用：

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

复杂任务可以额外包含 `research.md`，但不默认创建额外目录。

## 测试

运行 metadata 检查：

```sh
python tests/check-skill-metadata.py
```

测试 prompt 位于：

```text
tests/prompts/
```

这些 prompt 用来人工或自动检查 Codex 是否应触发对应 skill，例如：

- bugfix 应触发 `task-tracking`、`git-safety`、`verification-before-done`
- review-only 不应创建任务包
- empty workspace 应触发 `workspace-bootstrap`
- completion check 应触发 `verification-before-done`

## 贡献建议

修改 skill 前建议检查：

- `description` 是否只写触发条件，而不是总结完整流程。
- 是否保持低侵入，不把小任务变重。
- 是否保留任务包结构兼容性。
- 是否为新增或修改的触发场景补充 `tests/prompts/`。
- 是否通过 `python tests/check-skill-metadata.py`。

## 版本

当前 skill 内容版本：`v0.3`。

## License

MIT License，详见 [LICENSE](LICENSE)。
