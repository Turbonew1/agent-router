#!/usr/bin/env bash
# SkillPilot — Tool Scanner
# Scans installed skills, agents, and MCP tools to generate a routing config.
# Usage: bash scan-tools.sh [--output <path>]

set -uo pipefail

# --- Config ---
SKILLS_DIR="${HOME}/.agents/skills"
AGENTS_DIR="${HOME}/.claude/agents"
RULES_DIR="${HOME}/.claude/rules/common"
OUTPUT_FILE="${RULES_DIR}/skill-pilot.md"

# Parse args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --output) OUTPUT_FILE="$2"; shift 2 ;;
    *) shift ;;
  esac
done

# --- Helpers ---
log() { echo "▸ $1"; }
warn() { echo "⚠ $1"; }

# Extract skill description from SKILL.md frontmatter
get_skill_desc() {
  local skill_dir="$1"
  local skill_file=""

  # Try SKILL.md first, then README.md
  for f in "$skill_dir/SKILL.md" "$skill_dir/README.md"; do
    [[ -f "$f" ]] && skill_file="$f" && break
  done

  [[ -z "$skill_file" ]] && echo "" && return

  # Extract description from frontmatter
  sed -n '/^---$/,/^---$/p' "$skill_file" 2>/dev/null | \
    grep -i "^description:" | \
    head -1 | \
    sed 's/^description:[[:space:]]*//' | \
    cut -c1-120
}

# Extract agent description from .md file
get_agent_desc() {
  local agent_file="$1"
  head -10 "$agent_file" 2>/dev/null | \
    grep -i "description:" | \
    head -1 | \
    sed 's/^.*description:[[:space:]]*//' | \
    cut -c1-120
}

# Categorize a skill by name patterns
categorize_skill() {
  local name="$1"
  local lower_name
  lower_name=$(echo "$name" | tr '[:upper:]' '[:lower:]')

  # Frontend & UI
  if [[ "$lower_name" =~ (design-taste|frontend|ui|ux|minimalist|brutalist|high-end-visual|redesign|image-to-code|stitch|liquid-glass|motion|brandkit|imagegen) ]]; then
    echo "frontend-design"
  # Backend & API
  elif [[ "$lower_name" =~ (api-design|backend|fastapi|nestjs|laravel|springboot|quarkus|dotnet) ]]; then
    echo "backend-api"
  # Language patterns
  elif [[ "$lower_name" =~ (python|react|nextjs|nuxt|vite|kotlin|rust|golang|go-|swift|java-|cpp|csharp|perl|dart|angular) ]]; then
    echo "language-patterns"
  # Database
  elif [[ "$lower_name" =~ (postgres|mysql|redis|prisma|database|clickhouse) ]]; then
    echo "database"
  # DevOps
  elif [[ "$lower_name" =~ (docker|deploy|homelab|network|flox|pm2|uncloud|cisco) ]]; then
    echo "devops"
  # Security
  elif [[ "$lower_name" =~ (security|hipaa|healthcare-phi|defi-amm|safety-guard|gateguard) ]]; then
    echo "security"
  # Testing
  elif [[ "$lower_name" =~ (tdd|test-coverage|e2e|browser-qa|verification|regression) ]]; then
    echo "testing"
  # Content & Marketing
  elif [[ "$lower_name" =~ (article|brand-voice|content-engine|marketing|seo|social|crosspost|email-ops) ]]; then
    echo "content-marketing"
  # Research
  elif [[ "$lower_name" =~ (deep-research|market-research|lead-intel|research-ops|conversation-analyzer) ]]; then
    echo "research"
  # AI/ML
  elif [[ "$lower_name" =~ (gan-|fal-ai|manim|remotion|model-route|cost-aware-llm|prompt-optimizer) ]]; then
    echo "ai-ml"
  # Video & Media
  elif [[ "$lower_name" =~ (video|videodb|jianying|blender) ]]; then
    echo "video-media"
  # Documents
  elif [[ "$lower_name" =~ (pdf|docx|pptx|xlsx|visa-doc|nutrient) ]]; then
    echo "documents"
  # Git & Workflow
  elif [[ "$lower_name" =~ (git-workflow|github-ops|pr$|review-pr|finishing-a-dev|worktree) ]]; then
    echo "git-workflow"
  # Planning
  elif [[ "$lower_name" =~ (^plan|blueprint|architecture-decision|hexagonal|checkpoint|executing-plans) ]]; then
    echo "planning"
  # Healthcare
  elif [[ "$lower_name" =~ (healthcare|clinical|emr|cdss) ]]; then
    echo "healthcare"
  # Code Quality
  elif [[ "$lower_name" =~ (code-simplifier|code-tour|codebase-onboard|coding-standards|refactor|prune|repo-scan|silent-failure|error-handling) ]]; then
    echo "code-quality"
  else
    echo "other"
  fi
}

# --- Main ---
log "Scanning installed tools..."

# Ensure output directory exists
mkdir -p "$RULES_DIR"

# Count tools
skill_count=0
agent_count=0
mcp_count=0

# Temporary files for collecting data
SKILLS_TMP=$(mktemp)
AGENTS_TMP=$(mktemp)
trap 'rm -f "$SKILLS_TMP" "$AGENTS_TMP"' EXIT

# --- Scan Skills ---
if [[ -d "$SKILLS_DIR" ]]; then
  log "Scanning skills in $SKILLS_DIR..."
  for skill_dir in "$SKILLS_DIR"/*/; do
    [[ ! -d "$skill_dir" ]] && continue
    skill_name=$(basename "$skill_dir")

    # Skip source-command wrappers
    [[ "$skill_name" =~ ^source-command- ]] && continue

    desc=$(get_skill_desc "$skill_dir")
    category=$(categorize_skill "$skill_name")
    echo "${skill_name}|${category}|${desc}" >> "$SKILLS_TMP"
    skill_count=$((skill_count + 1))
  done
  log "Found $skill_count skills"
else
  warn "Skills directory not found: $SKILLS_DIR"
fi

# --- Scan Agents ---
if [[ -d "$AGENTS_DIR" ]]; then
  log "Scanning agents in $AGENTS_DIR..."
  for agent_file in "$AGENTS_DIR"/*.md; do
    [[ ! -f "$agent_file" ]] && continue
    agent_name=$(basename "$agent_file" .md)
    desc=$(get_agent_desc "$agent_file")
    echo "${agent_name}|${desc}" >> "$AGENTS_TMP"
    agent_count=$((agent_count + 1))
  done
  log "Found $agent_count agents"
else
  warn "Agents directory not found: $AGENTS_DIR"
fi

# --- Detect MCP Tools ---
log "Detecting MCP tools..."
mcp_tools=""
[[ -d "${HOME}/.claude" ]] && mcp_tools=$(find "${HOME}/.claude" -name "*.json" -exec grep -l "mcpServers\|mcp" {} \; 2>/dev/null | head -5)
mcp_count=$(echo "$mcp_tools" | grep -c . || echo 0)

# --- Generate Output ---
log "Generating routing config → $OUTPUT_FILE"

cat > "$OUTPUT_FILE" << 'HEADER'
# SkillPilot — Auto-Generated Routing Rules
# Generated by: skill-pilot skill
# Re-run: bash ~/.claude/skills/skill-pilot/scripts/scan-tools.sh
# DO NOT EDIT MANUALLY — re-run scan to regenerate

> This file auto-loads into every Claude Code session.
> It maps task patterns to the best available tool.

---

## Quick Reference: Task → Tool

| Task Pattern (EN) | 任务模式 (ZH) | Primary Tool | Category |
|---|---|---|---|
| "Build a landing page" | "做个落地页/网页" | `/design-taste-frontend` | frontend-design |
| "Build a UI component" | "做个UI组件" | `/frontend-patterns` | frontend-design |
| "Redesign existing UI" | "重新设计界面" | `/redesign-existing-projects` | frontend-design |
| "Premium/calm UI" | "高端/简洁的UI" | `/high-end-visual-design` | frontend-design |
| "Minimalist design" | "极简设计" | `/minimalist-ui` | frontend-design |
| "Brutalist/experimental" | "工业风/实验性" | `/industrial-brutalist-ui` | frontend-design |
| "Generate reference images" | "生成参考图" | `/imagegen-frontend-web` | frontend-design |
| "Mobile screen design" | "手机界面设计" | `/imagegen-frontend-mobile` | frontend-design |
| "Brand identity" | "品牌设计" | `/brandkit` | frontend-design |
| "Add animation/motion" | "加动画效果" | `/motion-advanced` | frontend-design |
| "Design API endpoints" | "设计API接口" | `/api-design` | backend-api |
| "Backend architecture" | "后端架构" | `/backend-patterns` | backend-api |
| "Fix a bug" | "修bug" | `tdd-guide` agent | testing |
| "Write tests" | "写测试" | `tdd-guide` agent | testing |
| "Review my code" | "审查代码" | `code-reviewer` agent | code-quality |
| "Check security" | "安全检查" | `security-reviewer` agent | security |
| "Research a topic" | "研究某个主题" | `deep-research` agent | research |
| "Optimize performance" | "优化性能" | `performance-optimizer` agent | code-quality |
| "Clean up dead code" | "清理无用代码" | `refactor-cleaner` agent | code-quality |
| "Update documentation" | "更新文档" | `doc-updater` agent | code-quality |
| "Plan a feature" | "规划功能" | `planner` agent | planning |
| "System architecture" | "系统架构" | `architect` agent | planning |
| "Edit a video" | "剪辑视频" | `mcp-video` tools | video-media |
| "Scrape a website" | "爬取网页" | `playwright` tools | devops |
| "Create a PR" | "创建PR" | `github` tools | git-workflow |
| "Fix build errors" | "修复构建错误" | `build-error-resolver` agent | devops |
| "Database query optimization" | "数据库查询优化" | `/postgres-patterns` | database |
| "Docker setup" | "Docker配置" | `/docker-patterns` | devops |
| "Home network setup" | "家庭网络配置" | `/homelab-architect` | devops |
| "Healthcare code review" | "医疗代码审查" | `/healthcare-reviewer` | healthcare |
| "DeFi security check" | "DeFi安全检查" | `/defi-amm-security` | security |
| "SEO audit" | "SEO审计" | `/seo-specialist` | content-marketing |
| "Write an article" | "写文章" | `/article-writing` | content-marketing |
| "Generate PDF" | "生成PDF" | `/pdf` | documents |
| "Create presentation" | "做PPT" | `/pptx` | documents |

---

## Installed Skills by Category

HEADER

# --- Write Skills by Category ---
if [[ -s "$SKILLS_TMP" ]]; then
  # Get unique categories
  categories=$(cut -d'|' -f2 "$SKILLS_TMP" | sort -u)

  for cat in $categories; do
    cat_label=$(echo "$cat" | sed 's/-/ /g' | sed 's/\b\(.\)/\u\1/g')
    echo "### ${cat_label}" >> "$OUTPUT_FILE"
    echo "" >> "$OUTPUT_FILE"
    echo "| Skill | Description |" >> "$OUTPUT_FILE"
    echo "|---|---|" >> "$OUTPUT_FILE"

    while IFS='|' read -r name category desc; do
      [[ "$category" == "$cat" ]] && echo "| \`/${name}\` | ${desc:-No description} |" >> "$OUTPUT_FILE"
    done < "$SKILLS_TMP"

    echo "" >> "$OUTPUT_FILE"
  done
fi

# --- Write Agents ---
cat >> "$OUTPUT_FILE" << 'AGENT_HEADER'
## Installed Agents

> Agents are spawned as sub-tasks via the Agent tool. They run in parallel.

| Agent | Description | When to Use |
|---|---|---|
AGENT_HEADER

if [[ -s "$AGENTS_TMP" ]]; then
  while IFS='|' read -r name desc; do
    echo "| \`${name}\` | ${desc:-No description} | See routing rules above |" >> "$OUTPUT_FILE"
  done < "$AGENTS_TMP" | sort
fi

# --- Write MCP Tools ---
cat >> "$OUTPUT_FILE" << 'MCP_HEADER'

## MCP Tools Available

| Category | Tools | When to Use |
|---|---|---|
| **Video Editing** | `video_trim`, `video_merge`, `video_crop`, `video_filter`, `video_add_text`, `video_extract_audio`, `video_analyze`, `video_export` | Video cutting, effects, text, audio |
| **Browser** | `browser_navigate`, `browser_click`, `browser_type`, `browser_snapshot`, `browser_take_screenshot` | Web automation, scraping |
| **GitHub** | `create_issue`, `list_issues`, `create_pull_request`, `search_code` | Repository operations |
| **Knowledge** | `create_entities`, `search_nodes`, `open_nodes` | Knowledge graph |
| **Docs** | `resolve-library-id`, `query-docs` | Library documentation |
| **Search** | `web_search_exa`, `web_fetch_exa` | Web research |
| **Thinking** | `sequentialthinking` | Complex reasoning |

---

## Routing Priority Rules

1. **Language Match** — Code in Python → `python-reviewer`, React → `react-reviewer`
2. **Task Type** — Bug → `tdd-guide`, Feature → `planner`, Review → `code-reviewer`
3. **Domain** — Healthcare → `healthcare-reviewer`, DeFi → `defi-amm-security`
4. **Tool Capability** — Video → `mcp-video`, Browser → `playwright`, Docs → `context7`
5. **Explicit Request** — User says "use X skill" → always honor

## Customization

Add custom rules by editing this file. Format:

```markdown
| Pattern | Tool | Priority |
|---|---|---|
| "my custom task" | `/my-skill` | HIGH |
```

MCP_HEADER

# --- Summary ---
log ""
log "✅ Done! Generated routing config with:"
log "   Skills:    $skill_count"
log "   Agents:    $agent_count"
log "   MCP Tools: detected"
log ""
log "📄 Output: $OUTPUT_FILE"
log ""
log "The routing rules will auto-load in your next Claude Code session."
log "To re-run: bash ~/.claude/skills/skill-pilot/scripts/scan-tools.sh"
