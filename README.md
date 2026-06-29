<p align="center">
  <img src="https://img.shields.io/badge/claude--router-v1.0.0-6B46C1?style=for-the-badge&logo=claude&logoColor=white" alt="Claude Router v1.0.0" />
  <img src="https://img.shields.io/badge/compatible-Claude%20Code-FF6B35?style=for-the-badge&logo=claude&logoColor=white" alt="Compatible with Claude Code" />
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="MIT License" />
</p>

<h1 align="center">Claude Router</h1>

<p align="center">
  <em>Intelligent Task Routing for Claude Code</em>
</p>

<p align="center">
  <a href="#-cn-中文说明">🇨🇳 中文</a> · <a href="#-us-english">🇺🇸 English</a>
</p>

---

# 🇨🇳 中文说明

## 是什么

**Claude Router** 扫描你已安装的 skills、agents 和 MCP 工具，然后生成一个**智能路由表**，告诉 Claude 每种任务该用哪个工具。

### 解决的问题

你装了 400+ skills、60+ agents 和几十个 MCP 工具。当你说"帮我做个网页"时，Claude 怎么知道该用 `design-taste-frontend` 而不是 `minimalist-ui`？

### 解决方案

Claude Router 创建一个映射：**任务模式 → 最佳工具**。它自动加载到每个会话中，你不需要输入任何命令 — 直接描述任务即可。

## 安装

```bash
# 方式 1: npx（推荐）
npx skills add https://github.com/Turbonew1/claude-router-skill

# 方式 2: 手动
git clone https://github.com/Turbonew1/claude-router-skill.git
bash claude-router-skill/scripts/install.sh
```

## 工作原理

```
用户说: "帮我做个登录页面"
         ↓
Claude Router 读取路由规则
         ↓
匹配: "登录页" → /design-taste-frontend
         ↓
Claude 自动调用对应 skill
         ↓
完成，无需任何手动命令
```

## 使用方式

### 首次使用

安装后运行一次扫描：

```bash
bash ~/.claude/skills/claude-router/scripts/scan-tools.sh
```

### 日常使用

**直接说话就行。** 不需要任何命令。

| 你说 | Claude 自动使用 |
|---|---|
| "帮我做个落地页" | `design-taste-frontend` skill |
| "这段代码有bug" | `tdd-guide` agent |
| "审查一下代码" | `code-reviewer` agent |
| "帮我研究XX技术" | `deep-research` agent |
| "剪辑这个视频" | `mcp-video` tools |
| "做个极简设计" | `minimalist-ui` skill |
| "安全检查" | `security-reviewer` agent |
| "做个PPT" | `/pptx` skill |
| "生成PDF" | `/pdf` skill |

### 重新扫描

安装新 skills 或 agents 后重新扫描：

```bash
bash ~/.claude/skills/claude-router/scripts/scan-tools.sh
```

## 扫描内容

| 来源 | 路径 | 内容 |
|---|---|---|
| Skills | `~/.agents/skills/` | 所有已安装 skills (400+) |
| Agents | `~/.claude/agents/` | 所有 agent 定义 (60+) |
| MCP 工具 | Claude 配置 | 活跃的 MCP 服务器 |

## 路由规则

生成的路由文件位于：

```
~/.claude/rules/common/claude-router.md
```

此文件自动加载到**每个 Claude Code 会话**中。

### 优先级

1. **显式请求** — "用 X skill" → 总是生效
2. **语言匹配** — Python 代码 → `python-reviewer`
3. **任务类型** — 修 bug → `tdd-guide`
4. **领域** — 医疗 → `healthcare-reviewer`

### 自定义规则

编辑路由文件添加自定义规则：

```markdown
| 模式 | 工具 | 优先级 |
|---|---|---|
| "部署到测试环境" | `/deployment-patterns` | HIGH |
```

## 常见问题

### Q: 会替换我现有的 skills 吗？
**A:** 不会。这只是在你的 skills 之上加了一层路由。你的 skills 功能不变 — 只是帮 Claude 选对工具。

### Q: 路由选错了工具怎么办？
**A:** 编辑 `~/.claude/rules/common/claude-router.md` 调整优先级，或者说"用 X skill"来覆盖。

### Q: 多久需要重新扫描一次？
**A:** 只在安装/卸载 skills 或 agents 后需要。路由文件在会话间持久保存。

---

# 🇺🇸 English

## What is it

**Claude Router** scans your installed skills, agents, and MCP tools, then generates a **smart routing table** that tells Claude which tool to use for each task type.

### The Problem

You have 400+ skills, 60+ agents, and dozens of MCP tools installed. When you say "build a login page", how does Claude know to use `design-taste-frontend` instead of `minimalist-ui`?

### The Solution

Claude Router creates a mapping: **task patterns → best tool**. It auto-loads into every session so you never type commands — just describe your task.

## Install

```bash
# Option 1: npx (Recommended)
npx skills add https://github.com/Turbonew1/claude-router-skill

# Option 2: Manual
git clone https://github.com/Turbonew1/claude-router-skill.git
bash claude-router-skill/scripts/install.sh
```

## How It Works

```
User says: "Build a login page"
         ↓
Claude Router reads routing rules
         ↓
Match: "login page" → /design-taste-frontend
         ↓
Claude automatically invokes the skill
         ↓
Done — no manual commands needed
```

## Usage

### First Time

After installing, run the scan once:

```bash
bash ~/.claude/skills/claude-router/scripts/scan-tools.sh
```

### Daily Use

**Just talk normally.** No commands needed.

| You say | Claude auto-uses |
|---|---|
| "Build a landing page" | `design-taste-frontend` skill |
| "Fix this bug" | `tdd-guide` agent |
| "Review my code" | `code-reviewer` agent |
| "Research XX technology" | `deep-research` agent |
| "Edit this video" | `mcp-video` tools |
| "Make it minimalist" | `minimalist-ui` skill |
| "Security audit" | `security-reviewer` agent |
| "Create presentation" | `/pptx` skill |
| "Generate PDF" | `/pdf` skill |

### Re-Scan

After installing new skills or agents:

```bash
bash ~/.claude/skills/claude-router/scripts/scan-tools.sh
```

## What Gets Scanned

| Source | Location | Content |
|---|---|---|
| Skills | `~/.agents/skills/` | All installed skills (400+) |
| Agents | `~/.claude/agents/` | All agent definitions (60+) |
| MCP Tools | Claude config | Active MCP servers |

## Routing Rules

The generated routing file is at:

```
~/.claude/rules/common/claude-router.md
```

This file auto-loads into **every Claude Code session**.

### Priority

1. **Explicit request** — "Use X skill" → always honored
2. **Language match** — Python code → `python-reviewer`
3. **Task type** — Bug fix → `tdd-guide`
4. **Domain** — Healthcare → `healthcare-reviewer`

### Custom Rules

Edit the routing file to add your own rules:

```markdown
| Pattern | Tool | Priority |
|---|---|---|
| "deploy to staging" | `/deployment-patterns` | HIGH |
```

## FAQ

### Q: Does this replace my existing skills?
**A:** No. This adds a routing layer on top. Your skills work exactly the same — this just helps Claude pick the right one.

### Q: What if the router picks the wrong tool?
**A:** Edit `~/.claude/rules/common/claude-router.md` to adjust priorities, or just say "use X skill" to override.

### Q: How often should I re-scan?
**A:** Only after installing/removing skills or agents. The routing file persists between sessions.

---

## Contributing

1. Fork the repo
2. Create a feature branch
3. Make your changes
4. Submit a PR

Issues and PRs welcome!

## License

[MIT License](LICENSE) · Copyright (c) 2026
