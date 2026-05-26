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

## Available Skills

| Skill | Trigger | Creates files? | Verification required? |
|---|---|---:|---:|
| `codex-coding-workflow` | Codex 处理编码任务、恢复任务或完成检查 | No | Depends on routed task |
| `coding-workflow` | 需要分类请求、判断轻重、选择子流程 | No | No |
| `workspace-bootstrap` | 初始化空 workspace 或补齐最小协作结构 | Yes | Yes, if files change |
| `task-tracking` | 修改项目文件、恢复任务、更新任务包 | Yes | Yes, before `done` |
| `git-safety` | 编辑、移动、删除、格式化或生成项目文件前 | No | No, but diff review is expected |
| `verification-before-done` | 准备声明 done/fixed/passing/ready 时 | No | Yes |

## 安装

## Installation Matrix

| Method | Target | Status | Notes |
|---|---|---|---|
| `./install.sh` | `~/.codex/skills` by default | Supported | Installs root and child skills |
| `.\install.ps1` | `%USERPROFILE%\.codex\skills` by default | Supported | Keeps backward-compatible `-Destination` |
| Manual copy | Any Codex skills directory | Supported | Copy root and child skill directories |
| `~/.agents/skills` | Universal Agent Skills path | Planned compatibility | Useful for tools that read the shared agent skills path |
| skills CLI / marketplace | Package distribution | Future direction | Not required for this repo today |

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

### Codex / Agent Skills 路径

当前脚本默认面向 Codex skills 目录：

```text
~/.codex/skills
```

一些 Agent Skills 生态工具使用通用路径：

```text
~/.agents/skills
```

本仓库的 `SKILL.md` 结构兼容通用 Agent Skills 格式，但默认安装仍保持 Codex-first。需要通用路径时，可以把安装目标显式传给 `install.sh` 或 `install.ps1`。

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

## 维护契约

每个子 skill 都包含一个 `SPEC.md`：

- `SKILL.md`：运行时指令，给 Codex 在任务中读取。
- `SPEC.md`：维护契约，给维护者或后续 agent 修改 skill 时读取。

`SPEC.md` 记录目标、触发条件、非目标、测试 prompt 和维护注意事项。修改子 skill 行为时，应同步更新对应 `SPEC.md` 和 `tests/prompts/`。

## 贡献建议

修改 skill 前建议检查：

- `description` 是否只写触发条件，而不是总结完整流程。
- 子 skill 目录名是否和 frontmatter `name` 一致。
- 是否保持低侵入，不把小任务变重。
- 是否保留任务包结构兼容性。
- 是否为新增或修改的触发场景补充 `tests/prompts/`。
- 是否通过 `python tests/check-skill-metadata.py`。

## 版本

当前 skill 内容版本：`v0.3`。

## License

MIT License，详见 [LICENSE](LICENSE)。
