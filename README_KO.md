<p align="center">
  <img src="https://img.shields.io/badge/agent--router-v1.0.0-6B46C1?style=for-the-badge" alt="SkillPilot v1.0.0" />
  <img src="https://img.shields.io/badge/호환-Claude%20Code%20%7C%20Codex%20%7C%20OpenClaw-FF6B35?style=for-the-badge" alt="다중 에이전트 지원" />
  <img src="https://img.shields.io/badge/라이선스-MIT-green?style=for-the-badge" alt="MIT 라이선스" />
</p>

<h1 align="center">SkillPilot</h1>

<p align="center">
  <em>AI 에이전트를 위한 지능형 태스크 라우팅</em>
</p>

<p align="center">
  <a href="README.md">🇺🇸 English</a> · <a href="README_CN.md">🇨🇳 中文</a> · <a href="README_JA.md">🇯🇵 日本語</a> · <b>🇰🇷 한국어</b> · <a href="README_ES.md">🇪🇸 Español</a> · <a href="README_FR.md">🇫🇷 Français</a> · <a href="README_DE.md">🇩🇪 Deutsch</a> · <a href="README_PT.md">🇧🇷 Português</a> · <a href="README_RU.md">🇷🇺 Русский</a>
</p>

---

## 이란

**SkillPilot**는 설치된 스킬, 에이전트, MCP 도구를 스캔하고, 각 작업에 가장 적합한 도구를 에이전트에 알려주는 **스마트 라우팅 테이블**을 생성합니다.

### 해결하는 문제

400개 이상의 스킬, 60개 이상의 에이전트, 수십 개의 MCP 도구가 설치되어 있습니다. "랜딩 페이지를 만들어줘"라고 말할 때, 에이전트가 `design-taste-frontend`와 `minimalist-ui` 중 어떤 것을 사용해야 하는지 어떻게 알 수 있나요?

### 해결책

SkillPilot는 **작업 패턴 → 최적의 도구** 매핑을 생성합니다. 모든 세션에서 자동으로 로드되므로 명령을 입력할 필요 없이 작업을 설명하기만 하면 됩니다.

### 지원 에이전트

| 에이전트 | 상태 |
|---|---|
| Claude Code | ✅ 완전 지원 |
| Codex | ✅ 완전 지원 |
| OpenClaw | ✅ 완전 지원 |
| Cursor | ✅ 완전 지원 |
| Hermes Agent | ✅ 완전 지원 |
| 기타 호환 에이전트 | ✅ 범용 형식 |

## 설치

```bash
# 방법 1: npx (권장)
npx skills add https://github.com/Turbonew1/skill-pilot

# 방법 2: 수동
git clone https://github.com/Turbonew1/skill-pilot.git
bash skill-pilot/scripts/install.sh
```

## 작동 방식

```
사용자: "랜딩 페이지를 만들어줘"
         ↓
SkillPilot가 라우팅 규칙을 읽음
         ↓
매칭: "랜딩 페이지" → /design-taste-frontend
         ↓
에이전트가 자동으로 스킬을 호출
         ↓
완료 — 수동 명령 불필요
```

## 사용법

### 첫 사용

설치 후 스캔 실행:

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

### 일상 사용

**일반적으로 말하면 됩니다.** 명령이 필요 없습니다.

| 말하기 | 에이전트가 자동 사용 |
|---|---|
| "랜딩 페이지를 만들어줘" | `design-taste-frontend` 스킬 |
| "이 버그를 고쳐줘" | `tdd-guide` 에이전트 |
| "코드를 리뷰해줘" | `code-reviewer` 에이전트 |
| "XX 기술을 리서치해줘" | `deep-research` 에이전트 |
| "이 동영상을 편집해줘" | `mcp-video` 도구 |
| "미니멀한 디자인으로" | `minimalist-ui` 스킬 |
| "보안 감사" | `security-reviewer` 에이전트 |
| "프레젠테이션 만들기" | `/pptx` 스킬 |
| "PDF 생성" | `/pdf` 스킬 |

### 재스캔

새 스킬이나 에이전트를 설치한 후:

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

## 스캔 대상

| 소스 | 위치 | 내용 |
|---|---|---|
| 스킬 | `~/.agents/skills/` | 설치된 스킬 (400+) |
| 에이전트 | `~/.claude/agents/` | 에이전트 정의 (60+) |
| MCP 도구 | 에이전트 설정 | 활성 MCP 서버 |

## 라우팅 규칙

생성된 라우팅 파일 위치:

```
~/.claude/rules/common/skill-pilot.md
```

이 파일은 **모든 에이전트 세션**에서 자동으로 로드됩니다.

### 우선순위

1. **명시적 요청** — "X 스킬 사용해" → 항상 우선
2. **언어 매칭** — Python 코드 → `python-reviewer`
3. **작업 유형** — 버그 수정 → `tdd-guide`
4. **도메인** — 의료 → `healthcare-reviewer`

### 커스텀 규칙

라우팅 파일을 편집하여 커스텀 규칙 추가:

```markdown
| 패턴 | 도구 | 우선순위 |
|---|---|---|
| "스테이징에 배포" | `/deployment-patterns` | HIGH |
```

## 자주 묻는 질문

### Q: 기존 스킬을 대체하나요?
**A:** 아니요. 이는 스킬 위에 라우팅 계층을 추가하는 것입니다. 기존 스킬은 그대로 작동합니다 — 에이전트가 올바른 도구를 선택하는 데 도움을 줄 뿐입니다.

### Q: 라우터가 잘못된 도구를 선택하면?
**A:** `~/.claude/rules/common/skill-pilot.md`를 편집하여 우선순위를 조정하거나, "X 스킬 사용해"라고 말하여 오버라이드하세요.

### Q: 얼마나 자주 재스캔해야 하나요?
**A:** 스킬이나 에이전트를 설치/제거할 때만 하면 됩니다. 라우팅 파일은 세션 간에 유지됩니다.

---

## 기여하기

1. 리포지토리 포크
2. 기능 브랜치 생성
3. 변경 사항 적용
4. PR 제출

Issues와 PR 환영!

## 라이선스

[MIT 라이선스](LICENSE) · Copyright (c) 2026
