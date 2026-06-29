<p align="center">
  <img src="https://img.shields.io/badge/agent--router-v1.0.0-6B46C1?style=for-the-badge" alt="SkillPilot v1.0.0" />
  <img src="https://img.shields.io/badge/兼容-Claude%20Code%20%7C%20Codex%20%7C%20OpenClaw-FF6B35?style=for-the-badge" alt="兼容多种 Agent" />
  <img src="https://img.shields.io/badge/许可证-MIT-green?style=for-the-badge" alt="MIT 许可证" />
</p>

<h1 align="center">SkillPilot</h1>

<p align="center">
  <em>智能任务路由 — 让 AI Agent 自动选择最佳工具</em>
</p>

<p align="center">
  <a href="README.md">🇺🇸 English</a> · <b>🇨🇳 中文</b> · <a href="README_JA.md">🇯🇵 日本語</a> · <a href="README_KO.md">🇰🇷 한국어</a> · <a href="README_ES.md">🇪🇸 Español</a> · <a href="README_FR.md">🇫🇷 Français</a> · <a href="README_DE.md">🇩🇪 Deutsch</a> · <a href="README_PT.md">🇧🇷 Português</a> · <a href="README_RU.md">🇷🇺 Русский</a>
</p>

---

## 是什么

**SkillPilot** 扫描你已安装的 skills、agents 和 MCP 工具，然后生成一个**智能路由表**，告诉 AI Agent 每种任务该用哪个工具。

### 解决的问题

你装了 400+ skills、60+ agents 和几十个 MCP 工具。当你说"帮我做个网页"时，Agent 怎么知道该用 `design-taste-frontend` 而不是 `minimalist-ui`？

### 解决方案

SkillPilot 创建一个映射：**任务模式 → 最佳工具**。它自动加载到每个会话中，你不需要输入任何命令 — 直接描述任务即可。

### 支持的 Agent

| Agent | 支持状态 |
|---|---|
| Claude Code | ✅ 完全支持 |
| Codex | ✅ 完全支持 |
| OpenClaw | ✅ 完全支持 |
| Cursor | ✅ 完全支持 |
| Hermes Agent | ✅ 完全支持 |
| 其他兼容 Agent | ✅ 通用格式 |

## 安装

```bash
# 方式 1: npx（推荐）
npx skills add https://github.com/Turbonew1/skill-pilot

# 方式 2: 手动
git clone https://github.com/Turbonew1/skill-pilot.git
bash skill-pilot/scripts/install.sh
```

## 工作原理

```
用户说: "帮我做个登录页面"
         ↓
SkillPilot 读取路由规则
         ↓
匹配: "登录页" → /design-taste-frontend
         ↓
Agent 自动调用对应 skill
         ↓
完成，无需任何手动命令
```

## 使用方式

### 首次使用

安装后运行一次扫描：

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

### 日常使用

**直接说话就行。** 不需要任何命令。

| 你说 | Agent 自动使用 |
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
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

## 扫描内容

| 来源 | 路径 | 内容 |
|---|---|---|
| Skills | `~/.agents/skills/` | 所有已安装 skills (400+) |
| Agents | `~/.claude/agents/` | 所有 agent 定义 (60+) |
| MCP 工具 | Agent 配置 | 活跃的 MCP 服务器 |

## 路由规则

生成的路由文件位于：

```
~/.claude/rules/common/skill-pilot.md
```

此文件自动加载到**每个 Agent 会话**中。

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
**A:** 不会。这只是在你的 skills 之上加了一层路由。你的 skills 功能不变 — 只是帮 Agent 选对工具。

### Q: 路由选错了工具怎么办？
**A:** 编辑 `~/.claude/rules/common/skill-pilot.md` 调整优先级，或者说"用 X skill"来覆盖。

### Q: 多久需要重新扫描一次？
**A:** 只在安装/卸载 skills 或 agents 后需要。路由文件在会话间持久保存。

---

## 贡献

1. Fork 仓库
2. 创建功能分支
3. 修改代码
4. 提交 PR

欢迎提交 Issues 和 PRs！

## 许可证

[MIT 许可证](LICENSE) · Copyright (c) 2026
