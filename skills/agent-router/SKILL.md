---
name: agent-router
description: Intelligent task-to-tool router. Scans installed skills, agents, and MCP tools, then auto-routes tasks to the best tool. Run once after installing new skills/agents.
---

# Agent Router — 智能任务路由 / Intelligent Task Router for AI Agents

> One skill to rule them all — automatically routes your tasks to the right skill, agent, or MCP tool.

## What This Does

Agent Router scans your installed tools and creates a **smart routing table** that tells Claude which tool to use for each task type. No more guessing — just describe your task and the right tool fires automatically.

## When to Run

- **First time**: Run `/agent-router` after installing this skill
- **After adding skills**: Re-run to pick up new tools
- **Troubleshooting**: Re-run if routing seems off

## How to Use

### Step 1: Scan & Generate (run once)

Tell Claude:

> Run the agent-router scan

Claude will execute the scan script and generate a routing config:

```bash
bash ~/.claude/skills/agent-router/scripts/scan-tools.sh
```

This scans:
- `~/.agents/skills/` — installed skills
- `~/.claude/agents/` — installed agents
- MCP tool availability — active MCP servers

### Step 2: Auto-Install Rules

After scanning, Claude writes the routing rules to:

```
~/.claude/rules/common/agent-router.md
```

This file **auto-loads into every session** — no manual setup needed.

### Step 3: Use It

Just talk normally. Claude reads the routing rules and auto-selects the best tool:

| You say | Claude uses |
|---|---|
| "Build a landing page" | `design-taste-frontend` skill |
| "Fix this bug" | `tdd-guide` agent |
| "Review my code" | `code-reviewer` agent |
| "Research X" | `deep-research` agent |
| "Edit this video" | `mcp-video` tools |
| "Check security" | `security-reviewer` agent |

## Routing Logic

The router uses these priority rules:

1. **Language-specific** — If code is Python → `python-reviewer`, React → `react-reviewer`
2. **Task-type** — Bug fix → `tdd-guide`, feature → `planner`, review → `code-reviewer`
3. **Domain-specific** — Healthcare → `healthcare-reviewer`, DeFi → `defi-amm-security`
4. **Tool capability** — Video → `mcp-video`, browser → `playwright`, docs → `context7`

## Customization

Edit the generated routing file to add custom rules:

```bash
~/.claude/rules/common/agent-router.md
```

Add entries like:

```markdown
### My Custom Rule
| Pattern | Tool | Priority |
|---|---|---|
| "deploy to staging" | `/deployment-patterns` + my-custom-script | HIGH |
```

## Bilingual Support / 双语支持

- English: All skill names and descriptions are in English
- 中文: 路由规则支持中文任务描述匹配
- 中文任务示例: "帮我做个网页" → `design-taste-frontend`

## Re-Scan After Changes

```bash
# After installing new skills
npx skills add <repo-url>
bash ~/.claude/skills/agent-router/scripts/scan-tools.sh

# After adding new agents
# Just re-run the scan
bash ~/.claude/skills/agent-router/scripts/scan-tools.sh
```

## Troubleshooting

- **Wrong tool selected**: Edit `~/.claude/rules/common/agent-router.md` to adjust priorities
- **Tool not found**: Re-run scan to pick up newly installed tools
- **Rules not loading**: Ensure the file is at `~/.claude/rules/common/agent-router.md`
