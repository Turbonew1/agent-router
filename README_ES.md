<p align="center">
  <img src="https://img.shields.io/badge/agent--router-v1.0.0-6B46C1?style=for-the-badge" alt="SkillPilot v1.0.0" />
  <img src="https://img.shields.io/badge/compatible-Claude%20Code%20%7C%20Codex%20%7C%20OpenClaw-FF6B35?style=for-the-badge" alt="Compatible with multiple agents" />
  <img src="https://img.shields.io/badge/license-MIT-green?style=for-the-badge" alt="MIT License" />
</p>

<h1 align="center">SkillPilot</h1>

<p align="center">
  <em>Enrutamiento Inteligente de Tareas para Agentes de IA</em>
</p>

<p align="center">
  <a href="README.md">🇺🇸 English</a> · <a href="README_CN.md">🇨🇳 中文</a> · <a href="README_JA.md">🇯🇵 日本語</a> · <a href="README_KO.md">🇰🇷 한국어</a> <b>🇪🇸 Español</b> · <a href="README_FR.md">🇫🇷 Français</a> · <a href="README_DE.md">🇩🇪 Deutsch</a> · <a href="README_PT.md">🇧🇷 Português</a> · <a href="README_RU.md">🇷🇺 Русский</a>
</p>

---

## Qué es

**SkillPilot** escanea tus skills, agents y herramientas MCP instalados, y genera una **tabla de enrutamiento inteligente** que le dice a tu agente de IA qué herramienta usar para cada tipo de tarea.

### El Problema

Tienes 400+ skills, 60+ agents y docenas de herramientas MCP instaladas. Cuando dices "hazme una página de aterrizaje", ¿cómo sabe tu agente si usar `design-taste-frontend` o `minimalist-ui`?

### La Solución

SkillPilot crea un mapeo: **patrones de tarea → mejor herramienta**. Se carga automáticamente en cada sesión, así que no necesitas escribir comandos — solo describe tu tarea.

### Agentes Soportados

| Agente | Estado |
|---|---|
| Claude Code | ✅ Soporte completo |
| Codex | ✅ Soporte completo |
| OpenClaw | ✅ Soporte completo |
| Cursor | ✅ Soporte completo |
| Hermes Agent | ✅ Soporte completo |
| Otros agentes compatibles | ✅ Formato universal |

## Instalación

```bash
# Opción 1: npx (Recomendado)
npx skills add https://github.com/Turbonew1/skill-pilot

# Opción 2: Manual
git clone https://github.com/Turbonew1/skill-pilot.git
bash skill-pilot/scripts/install.sh
```

## Cómo Funciona

```
Usuario: "Hazme una página de aterrizaje"
         ↓
SkillPilot lee las reglas de enrutamiento
         ↓
Coincidencia: "página de aterrizaje" → /design-taste-frontend
         ↓
El agente invoca automáticamente el skill
         ↓
Listo — no se necesitan comandos manuales
```

## Uso

### Primera Vez

Después de instalar, ejecuta el escaneo:

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

### Uso Diario

**Solo habla normalmente.** No se necesitan comandos.

| Dices | El agente usa automáticamente |
|---|---|
| "Hazme una página de aterrizaje" | skill `design-taste-frontend` |
| "Arregla este bug" | agente `tdd-guide` |
| "Revisa mi código" | agente `code-reviewer` |
| "Investiga XX tecnología" | agente `deep-research` |
| "Edita este video" | herramientas `mcp-video` |
| "Hazlo minimalista" | skill `minimalist-ui` |
| "Auditoría de seguridad" | agente `security-reviewer` |
| "Crear presentación" | skill `/pptx` |
| "Generar PDF" | skill `/pdf` |

### Re-escaneo

Después de instalar nuevos skills o agents:

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

## Qué se Escanea

| Fuente | Ubicación | Contenido |
|---|---|---|
| Skills | `~/.agents/skills/` | Todos los skills instalados (400+) |
| Agents | `~/.claude/agents/` | Definiciones de agents (60+) |
| Herramientas MCP | Configuración del agente | Servidores MCP activos |

## Reglas de Enrutamiento

El archivo de enrutamiento generado está en:

```
~/.claude/rules/common/skill-pilot.md
```

Este archivo se carga automáticamente en **cada sesión del agente**.

### Prioridad

1. **Solicitud explícita** — "Usa X skill" → siempre se respeta
2. **Coincidencia de idioma** — Código Python → `python-reviewer`
3. **Tipo de tarea** — Corrección de bug → `tdd-guide`
4. **Dominio** — Salud → `healthcare-reviewer`

### Reglas Personalizadas

Edita el archivo de enrutamiento para agregar reglas propias:

```markdown
| Patrón | Herramienta | Prioridad |
|---|---|---|
| "desplegar a staging" | `/deployment-patterns` | HIGH |
```

## Preguntas Frecuentes

### ¿Q: Reemplaza mis skills existentes?
**A:** No. Esto agrega una capa de enrutamiento encima. Tus skills funcionan igual — solo ayuda a tu agente a elegir la correcta.

### ¿Q: ¿Qué pasa si el router elige la herramienta equivocada?
**A:** Edita `~/.claude/rules/common/skill-pilot.md` para ajustar prioridades, o di "usa X skill" para sobreescribir.

### ¿Q: ¿Cada cuánto debo re-escanear?
**A:** Solo después de instalar/eliminar skills o agents. El archivo de enrutamiento persiste entre sesiones.

---

## Contribuir

1. Haz fork del repositorio
2. Crea una rama de funciones
3. Haz tus cambios
4. Envía un PR

¡Issues y PRs son bienvenidos!

## Licencia

[Licencia MIT](LICENSE) · Copyright (c) 2026
