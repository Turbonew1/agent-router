<p align="center">
  <img src="https://img.shields.io/badge/claude--router-v1.0.0-6B46C1?style=for-the-badge&logo=claude&logoColor=white" alt="Claude Router v1.0.0" />
  <img src="https://img.shields.io/badge/compatible-Claude%20Code-FF6B35?style=for-the-badge&logo=claude&logoColor=white" alt="Compatible with Claude Code" />
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="MIT License" />
</p>

<h1 align="center">Claude Router</h1>

<p align="center">
  <em>智能任务路由 — 让 Claude 自动选择最佳工具</em>
</p>

<p align="center">
  <em>Intelligent Task Routing — Let Claude auto-select the best tool</em>
</p>

---

## What / 是什么

**Claude Router** scans your installed skills, agents, and MCP tools, then generates a **smart routing table** that tells Claude which tool to use for each task type.

**Claude Router** 扫描你已安装的 skills、agents 和 MCP 工具，然后生成一个**智能路由表**，告诉 Claude 每种任务该用哪个工具。

### The Problem / 解决的问题

You have 400+ skills, 60+ agents, and dozens of MCP tools installed. When you say "帮我做个网页", how does Claude know to use `design-taste-frontend` instead of `minimalist-ui`?

你装了 400+ skills、60+ agents 和几十个 MCP 工具。当你说"帮我做个网页"时，Claude 怎么知道该用 `design-taste-frontend` 而不是 `minimalist-ui`？

### The Solution / 解决方案

Claude Router creates a mapping: **task patterns → best tool**. It auto-loads into every session so you never type commands — just describe your task.

Claude Router 创建一个映射：**任务模式 → 最佳工具**。它自动加载到每个会话中，你不需要输入任何命令 — 直接描述任务即可。

---

## Install / 安装

### Option 1: npx (Recommended / 推荐)

```bash
npx skills add https://github.com/your-username/claude-router-skill
```

### Option 2: Manual / 手动

```bash
# Clone the repo
git clone https://github.com/your-username/claude-router-skill.git

# Run installer
bash claude-router-skill/scripts/install.sh
```

### Option 3: Just the skill file / 只安装 SKILL.md

Copy `skills/claude-router/SKILL.md` to `~/.claude/skills/claude-router/SKILL.md`.

---

## How It Works / 工作原理

```
┌─────────────────────────────────────────────────┐
│  User says: "帮我做个登录页面"                       │
│  User says: "Build a login page"                 │
└──────────────────────┬──────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────┐
│  Claude Router reads routing rules               │
│  claude-router.md (auto-loaded)                  │
└──────────────────────┬──────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────┐
│  Match: "landing page" / "落地页"                 │
│  → /design-taste-frontend (anti-slop skill)      │
└──────────────────────┬──────────────────────────┘
                       │
                       ▼
┌─────────────────────────────────────────────────┐
│  Claude automatically invokes the skill          │
│  No manual command needed!                       │
└─────────────────────────────────────────────────┘
```

---

## Usage / 使用

### First Time / 首次使用

After installing, run the scan once:

安装后，运行一次扫描：

```bash
# The installer does this automatically
# 安装脚本会自动执行

# Or run manually / 或手动运行：
bash ~/.claude/skills/claude-router/scripts/scan-tools.sh
```

### Daily Use / 日常使用

**Just talk normally.** No commands needed.

**直接说话就行。** 不需要任何命令。

| You say / 你说 | Claude uses / Claude 使用 |
|---|---|
| "帮我做个落地页" | `design-taste-frontend` skill |
| "Build a landing page" | `design-taste-frontend` skill |
| "这段代码有bug" | `tdd-guide` agent |
| "Fix this bug" | `tdd-guide` agent |
| "审查一下代码" | `code-reviewer` agent |
| "Review my code" | `code-reviewer` agent |
| "帮我研究XX技术" | `deep-research` agent |
| "Research XX technology" | `deep-research` agent |
| "剪辑这个视频" | `mcp-video` tools |
| "Edit this video" | `mcp-video` tools |
| "做个极简设计" | `minimalist-ui` skill |
| "Make it minimalist" | `minimalist-ui` skill |
| "安全检查" | `security-reviewer` agent |
| "Security audit" | `security-reviewer` agent |

### Re-Scan / 重新扫描

After installing new skills or agents:

安装新 skills 或 agents 后重新扫描：

```bash
bash ~/.claude/skills/claude-router/scripts/scan-tools.sh
```

---

## What Gets Scanned / 扫描内容

| Source / 来源 | Location / 路径 | What / 内容 |
|---|---|---|
| Skills | `~/.agents/skills/` | All installed skills (400+) |
| Agents | `~/.claude/agents/` | All agent definitions (60+) |
| MCP Tools | Claude config | Active MCP servers |

---

## Routing Rules / 路由规则

The generated routing file is at:

生成的路由文件位于：

```
~/.claude/rules/common/claude-router.md
```

This file auto-loads into **every Claude Code session**.

此文件自动加载到**每个 Claude Code 会话**中。

### Priority / 优先级

1. **Explicit request** — "Use X skill" → always honored
   **显式请求** — "用 X skill" → 总是生效
2. **Language match** — Python code → `python-reviewer`
   **语言匹配** — Python 代码 → `python-reviewer`
3. **Task type** — Bug fix → `tdd-guide`
   **任务类型** — 修 bug → `tdd-guide`
4. **Domain** — Healthcare → `healthcare-reviewer`
   **领域** — 医疗 → `healthcare-reviewer`

### Custom Rules / 自定义规则

Edit the routing file to add your own rules:

编辑路由文件添加自定义规则：

```markdown
### My Custom Rules / 我的自定义规则

| Pattern / 模式 | Tool / 工具 | Priority / 优先级 |
|---|---|---|
| "deploy to staging" | `/deployment-patterns` | HIGH |
| "部署到测试环境" | `/deployment-patterns` | HIGH |
```

---

## Comparison / 对比

| Feature / 功能 | Claude Router | Manual Selection | No Router |
|---|---|---|---|
| Auto-detect tools / 自动检测工具 | ✅ | ❌ | ❌ |
| Task → Tool mapping / 任务→工具映射 | ✅ | ❌ | ❌ |
| Bilingual support / 双语支持 | ✅ | ✅ | ✅ |
| Zero config / 零配置 | ✅ | N/A | ✅ |
| Custom rules / 自定义规则 | ✅ | N/A | ❌ |
| Re-scan on change / 变更后重扫 | ✅ | N/A | ❌ |

---

## FAQ

### Q: Does this replace my existing skills?
**A:** No. This adds a routing layer on top. Your skills work exactly the same — this just helps Claude pick the right one.

**A:** 不会。这只是在你的 skills 之上加了一层路由。你的 skills 功能不变 — 只是帮 Claude 选对工具。

### Q: What if the router picks the wrong tool?
**A:** Edit `~/.claude/rules/common/claude-router.md` to adjust priorities, or just say "use X skill" to override.

**A:** 编辑 `~/.claude/rules/common/claude-router.md` 调整优先级，或者说"用 X skill"来覆盖。

### Q: Does it work with all coding agents?
**A:** Currently optimized for Claude Code. The routing file format is compatible with any agent that reads markdown rules.

**A:** 目前针对 Claude Code 优化。路由文件格式兼容任何读取 markdown 规则的 agent。

### Q: How often should I re-scan?
**A:** Only after installing/removing skills or agents. The routing file persists between sessions.

**A:** 只在安装/卸载 skills 或 agents 后需要。路由文件在会话间持久保存。

---

## Contributing / 贡献

1. Fork the repo
2. Create a feature branch
3. Make your changes
4. Submit a PR

Issues and PRs welcome! / 欢迎 Issues 和 PRs!

---

## License / 许可证

[MIT License](LICENSE) · Copyright (c) 2026
