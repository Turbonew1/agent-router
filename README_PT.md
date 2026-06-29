<p align="center">
  <img src="https://img.shields.io/badge/agent--router-v1.0.0-6B46C1?style=for-the-badge" alt="SkillPilot v1.0.0" />
  <img src="https://img.shields.io/badge/compatível-Claude%20Code%20%7C%20Codex%20%7C%20OpenClaw-FF6B35?style=for-the-badge" alt="Compatível com múltiplos agentes" />
  <img src="https://img.shields.io/badge/licença-MIT-green?style=for-the-badge" alt="Licença MIT" />
</p>

<h1 align="center">SkillPilot</h1>

<p align="center">
  <em>Roteamento Inteligente de Tarefas para Agentes de IA</em>
</p>

<p align="center">
  <a href="README.md">🇺🇸 English</a> · <a href="README_CN.md">🇨🇳 中文</a> · <a href="README_JA.md">🇯🇵 日本語</a> · <a href="README_KO.md">🇰🇷 한국어</a> · <a href="README_ES.md">🇪🇸 Español</a> · <a href="README_FR.md">🇫🇷 Français</a> · <a href="README_DE.md">🇩🇪 Deutsch</a> <b>🇧🇷 Português</b> · <a href="README_RU.md">🇷🇺 Русский</a>
</p>

---

## O que é

**SkillPilot** escaneia seus skills, agents e ferramentas MCP instalados, e gera uma **tabela de roteamento inteligente** que diz ao seu agente de IA qual ferramenta usar para cada tipo de tarefa.

### O Problema

Você tem 400+ skills, 60+ agents e dezenas de ferramentas MCP instaladas. Quando você diz "faça uma landing page", como seu agente sabe se deve usar `design-taste-frontend` ou `minimalist-ui`?

### A Solução

SkillPilot cria um mapeamento: **padrões de tarefa → melhor ferramenta**. Ele carrega automaticamente em cada sessão, então você não precisa digitar comandos — apenas descreva sua tarefa.

### Agents Suportados

| Agent | Status |
|---|---|
| Claude Code | ✅ Suporte completo |
| Codex | ✅ Suporte completo |
| OpenClaw | ✅ Suporte completo |
| Cursor | ✅ Suporte completo |
| Hermes Agent | ✅ Suporte completo |
| Outros agents compatíveis | ✅ Formato universal |

## Instalação

```bash
# Opção 1: npx (Recomendado)
npx skills add https://github.com/Turbonew1/skill-pilot

# Opção 2: Manual
git clone https://github.com/Turbonew1/skill-pilot.git
bash skill-pilot/scripts/install.sh
```

## Como Funciona

```
Usuário: "Faça uma landing page"
         ↓
SkillPilot lê as regras de roteamento
         ↓
Correspondência: "landing page" → /design-taste-frontend
         ↓
O agente invoca automaticamente o skill
         ↓
Pronto — nenhum comando manual necessário
```

## Uso

### Primeira Vez

Após instalar, execute o escaneamento:

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

### Uso Diário

**Apenas fale normalmente.** Nenhum comando necessário.

| Você diz | O agente usa automaticamente |
|---|---|
| "Faça uma landing page" | skill `design-taste-frontend` |
| "Conserte este bug" | agent `tdd-guide` |
| "Revise meu código" | agent `code-reviewer` |
| "Pesquise XX tecnologia" | agent `deep-research` |
| "Edite este vídeo" | ferramentas `mcp-video` |
| "Faça minimalista" | skill `minimalist-ui` |
| "Auditoria de segurança" | agent `security-reviewer` |
| "Criar apresentação" | skill `/pptx` |
| "Gerar PDF" | skill `/pdf` |

### Re-escaneamento

Após instalar novos skills ou agents:

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

## O Que É Escaneado

| Fonte | Localização | Conteúdo |
|---|---|---|
| Skills | `~/.agents/skills/` | Todos os skills instalados (400+) |
| Agents | `~/.claude/agents/` | Definições dos agents (60+) |
| Ferramentas MCP | Configuração do agent | Servidores MCP ativos |

## Regras de Roteamento

O arquivo de roteamento gerado está em:

```
~/.claude/rules/common/skill-pilot.md
```

Este arquivo carrega automaticamente em **cada sessão do agent**.

### Prioridade

1. **Solicitação explícita** — "Use X skill" → sempre respeitado
2. **Correspondência de idioma** — Código Python → `python-reviewer`
3. **Tipo de tarefa** — Correção de bug → `tdd-guide`
4. **Domínio** — Saúde → `healthcare-reviewer`

### Regras Personalizadas

Edite o arquivo de roteamento para adicionar suas próprias regras:

```markdown
| Padrão | Ferramenta | Prioridade |
|---|---|---|
| "implantar em staging" | `/deployment-patterns` | HIGH |
```

## Perguntas Frequentes

### P: Isso substitui meus skills existentes?
**R:** Não. Isso adiciona uma camada de roteamento por cima. Seus skills funcionam exatamente da mesma forma — apenas ajuda seu agente a escolher o certo.

### P: E se o roteador escolher a ferramenta errada?
**R:** Edite `~/.claude/rules/common/skill-pilot.md` para ajustar prioridades, ou digite "use X skill" para sobrescrever.

### P: Com que frequência devo re-escanear?
**R:** Apenas após instalar/remover skills ou agents. O arquivo de roteamento persiste entre sessões.

---

## Contribuir

1. Faça fork do repositório
2. Crie uma branch de funcionalidade
3. Faça suas alterações
4. Submeta um PR

Issues e PRs são bem-vindos!

## Licença

[Licença MIT](LICENSE) · Copyright (c) 2026
