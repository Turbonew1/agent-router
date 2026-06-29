<p align="center">
  <img src="https://img.shields.io/badge/agent--router-v1.0.0-6B46C1?style=for-the-badge" alt="Agent Router v1.0.0" />
  <img src="https://img.shields.io/badge/kompatibel-Claude%20Code%20%7C%20Codex%20%7C%20OpenClaw-FF6B35?style=for-the-badge" alt="Kompatibel mit mehreren Agenten" />
  <img src="https://img.shields.io/badge/lizenz-MIT-green?style=for-the-badge" alt="MIT-Lizenz" />
</p>

<h1 align="center">Agent Router</h1>

<p align="center">
  <em>Intelligentes Task-Routing für KI-Agenten</em>
</p>

<p align="center">
  <a href="README.md">🇺🇸 English</a> · <a href="README_CN.md">🇨🇳 中文</a> · <a href="README_JA.md">🇯🇵 日本語</a> · <a href="README_KO.md">🇰🇷 한국어</a> · <a href="README_ES.md">🇪🇸 Español</a> · <a href="README_FR.md">🇫🇷 Français</a> <b>🇩🇪 Deutsch</a> · <a href="README_PT.md">🇧🇷 Português</a> · <a href="README_RU.md">🇷🇺 Русский</a>
</p>

---

## Was ist es

**Agent Router** scannt deine installierten Skills, Agents und MCP-Tools und generiert eine **intelligente Routing-Tabelle**, die deinem KI-Agenten sagt, welches Tool für welche Aufgabe zu verwenden ist.

### Das Problem

Du hast 400+ Skills, 60+ Agents und Dutzende von MCP-Tools installiert. Wenn du sagst "mach mir eine Landing Page", wie weiß dein Agent, ob er `design-taste-frontend` oder `minimalist-ui` verwenden soll?

### Die Lösung

Agent Router erstellt ein Mapping: **Aufgabenmuster → bestes Tool**. Es lädt automatisch in jeder Session, du musst keine Befehle eingeben — beschreibe einfach deine Aufgabe.

### Unterstützte Agenten

| Agent | Status |
|---|---|
| Claude Code | ✅ Volle Unterstützung |
| Codex | ✅ Volle Unterstützung |
| OpenClaw | ✅ Volle Unterstützung |
| Cursor | ✅ Volle Unterstützung |
| Hermes Agent | ✅ Volle Unterstützung |
| Andere kompatible Agenten | ✅ Universelles Format |

## Installation

```bash
# Option 1: npx (Empfohlen)
npx skills add https://github.com/Turbonew1/agent-router

# Option 2: Manuell
git clone https://github.com/Turbonew1/agent-router.git
bash agent-router/scripts/install.sh
```

## Wie Es Funktioniert

```
Benutzer: "Mach mir eine Landing Page"
         ↓
Agent Router liest die Routing-Regeln
         ↓
Übereinstimmung: "Landing Page" → /design-taste-frontend
         ↓
Der Agent ruft automatisch den Skill auf
         ↓
Fertig — keine manuellen Befehle nötig
```

## Verwendung

### Erstmals

Nach der Installation den Scan ausführen:

```bash
bash ~/.agent-skills/agent-router/scripts/scan-tools.sh
```

### Tägliche Verwendung

**Sprich einfach normal.** Keine Befehle nötig.

| Du sagst | Agent verwendet automatisch |
|---|---|
| "Mach mir eine Landing Page" | Skill `design-taste-frontend` |
| "Fix diesen Bug" | Agent `tdd-guide` |
| "Review meinen Code" | Agent `code-reviewer` |
| "Recherchiere XX Technologie" | Agent `deep-research` |
| "Bearbeite dieses Video" | Tools `mcp-video` |
| "Mach es minimalistisch" | Skill `minimalist-ui` |
| "Sicherheitsaudit" | Agent `security-reviewer` |
| "Präsentation erstellen" | Skill `/pptx` |
| "PDF generieren" | Skill `/pdf` |

### Erneuter Scan

Nach der Installation neuer Skills oder Agents:

```bash
bash ~/.agent-skills/agent-router/scripts/scan-tools.sh
```

## Was Gescannt Wird

| Quelle | Speicherort | Inhalt |
|---|---|---|
| Skills | `~/.agents/skills/` | Alle installierten Skills (400+) |
| Agents | `~/.claude/agents/` | Agent-Definitionen (60+) |
| MCP-Tools | Agent-Konfiguration | Aktive MCP-Server |

## Routing-Regeln

Die generierte Routing-Datei befindet sich unter:

```
~/.claude/rules/common/agent-router.md
```

Diese Datei lädt automatisch in **jeder Agent-Session**.

### Priorität

1. **Explizite Anfrage** — "Benutze X Skill" → wird immer respektiert
2. **Sprachübereinstimmung** — Python-Code → `python-reviewer`
3. **Aufgabentyp** — Bug-Fix → `tdd-guide`
4. **Bereich** — Gesundheit → `healthcare-reviewer`

### Benutzerdefinierte Regeln

Bearbeite die Routing-Datei, um eigene Regeln hinzuzufügen:

```markdown
| Muster | Tool | Priorität |
|---|---|---|
| "auf Staging deployen" | `/deployment-patterns` | HIGH |
```

## Häufige Fragen

### Q: Ersetzt das meine bestehenden Skills?
**A:** Nein. Es fügt eine Routing-Schicht darüber hinzu. Deine Skills funktionieren genauso — es hilft deinem Agenten nur, das richtige auszuwählen.

### Q: Was, wenn der Router das falsche Tool wählt?
**A:** Bearbeite `~/.claude/rules/common/agent-router.md`, um Prioritäten anzupassen, oder sage "benutze X Skill" zum Überschreiben.

### Q: Wie oft sollte ich neu scannen?
**A:** Nur nach dem Installieren/Entfernen von Skills oder Agents. Die Routing-Datei bleibt zwischen Sessions erhalten.

---

## Beitrragen

1. Forke das Repository
2. Erstelle einen Feature-Branch
3. Mache deine Änderungen
4. Reiche einen PR ein

Issues und PRs willkommen!

## Lizenz

[MIT-Lizenz](LICENSE) · Copyright (c) 2026
