<p align="center">
  <img src="https://img.shields.io/badge/agent--router-v1.0.0-6B46C1?style=for-the-badge" alt="Agent Router v1.0.0" />
  <img src="https://img.shields.io/badge/compatible-Claude%20Code%20%7C%20Codex%20%7C%20OpenClaw-FF6B35?style=for-the-badge" alt="Compatible with multiple agents" />
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="MIT License" />
</p>

<h1 align="center">Agent Router</h1>

<p align="center">
  <em>Intelligent Task-to-Tool Router for AI Agents</em>
</p>

<p align="center">
  <b>🇺🇸 English</b> · <a href="README_CN.md">🇨🇳 中文</a> · <a href="README_JA.md">🇯🇵 日本語</a> · <a href="README_KO.md">🇰🇷 한국어</a> · <a href="README_ES.md">🇪🇸 Español</a> · <a href="README_FR.md">🇫🇷 Français</a> · <a href="README_DE.md">🇩🇪 Deutsch</a> · <a href="README_PT.md">🇧🇷 Português</a> · <a href="README_RU.md">🇷🇺 Русский</a>
</p>

---

## What is it

**Agent Router** scans your installed skills, agents, and MCP tools, then generates a **smart routing table** that tells your AI agent which tool to use for each task type.

### The Problem

You have 400+ skills, 60+ agents, and dozens of MCP tools installed. When you say "build a login page", how does your agent know to use `design-taste-frontend` instead of `minimalist-ui`?

### The Solution

Agent Router creates a mapping: **task patterns → best tool**. It auto-loads into every session so you never type commands — just describe your task.

### Supported Agents

| Agent | Status |
|---|---|
| Claude Code | ✅ Full support |
| Codex | ✅ Full support |
| OpenClaw | ✅ Full support |
| Cursor | ✅ Full support |
| Hermes Agent | ✅ Full support |
| Other compatible agents | ✅ Universal format |

## Install

```bash
# Option 1: npx (Recommended)
npx skills add https://github.com/Turbonew1/agent-router

# Option 2: Manual
git clone https://github.com/Turbonew1/agent-router.git
bash agent-router/scripts/install.sh
```

## How It Works

```
User says: "Build a login page"
         ↓
Agent Router reads routing rules
         ↓
Match: "login page" → /design-taste-frontend
         ↓
Agent automatically invokes the skill
         ↓
Done — no manual commands needed
```

## Usage

### First Time

After installing, run the scan once:

```bash
bash ~/.agent-skills/agent-router/scripts/scan-tools.sh
```

### Daily Use

**Just talk normally.** No commands needed.

| You say | Agent auto-uses |
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
bash ~/.agent-skills/agent-router/scripts/scan-tools.sh
```

## What Gets Scanned

| Source | Location | Content |
|---|---|---|
| Skills | `~/.agents/skills/` | All installed skills (400+) |
| Agents | `~/.claude/agents/` | All agent definitions (60+) |
| MCP Tools | Agent config | Active MCP servers |

## Routing Rules

The generated routing file is at:

```
~/.claude/rules/common/agent-router.md
```

This file auto-loads into **every agent session**.

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
**A:** No. This adds a routing layer on top. Your skills work exactly the same — this just helps your agent pick the right one.

### Q: What if the router picks the wrong tool?
**A:** Edit `~/.claude/rules/common/agent-router.md` to adjust priorities, or just say "use X skill" to override.

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
