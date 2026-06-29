<p align="center">
  <img src="https://img.shields.io/badge/agent--router-v1.0.0-6B46C1?style=for-the-badge" alt="SkillPilot v1.0.0" />
  <img src="https://img.shields.io/badge/compatible-Claude%20Code%20%7C%20Codex%20%7C%20OpenClaw-FF6B35?style=for-the-badge" alt="Compatible avec plusieurs agents" />
  <img src="https://img.shields.io/badge/licence-MIT-green?style=for-the-badge" alt="Licence MIT" />
</p>

<h1 align="center">SkillPilot</h1>

<p align="center">
  <em>Routage Intelligent des Tâches pour les Agents IA</em>
</p>

<p align="center">
  <a href="README.md">🇺🇸 English</a> · <a href="README_CN.md">🇨🇳 中文</a> · <a href="README_JA.md">🇯🇵 日本語</a> · <a href="README_KO.md">🇰🇷 한국어</a> · <a href="README_ES.md">🇪🇸 Español</a> <b>🇫🇷 Français</b> · <a href="README_DE.md">🇩🇪 Deutsch</a> · <a href="README_PT.md">🇧🇷 Português</a> · <a href="README_RU.md">🇷🇺 Русский</a>
</p>

---

## C'est quoi

**SkillPilot** scanne vos skills, agents et outils MCP installés, puis génère une **table de routage intelligente** qui dit à votre agent IA quel outil utiliser pour chaque type de tâche.

### Le Problème

Vous avez 400+ skills, 60+ agents et des dizaines d'outils MCP installés. Quand vous dites "créez-moi une landing page", comment votre agent sait-il s'il doit utiliser `design-taste-frontend` ou `minimalist-ui` ?

### La Solution

SkillPilot crée un mapping : **motifs de tâche → meilleur outil**. Il se charge automatiquement dans chaque session, donc pas besoin de taper des commandes — décrivez juste votre tâche.

### Agents Supportés

| Agent | Statut |
|---|---|
| Claude Code | ✅ Support complet |
| Codex | ✅ Support complet |
| OpenClaw | ✅ Support complet |
| Cursor | ✅ Support complet |
| Hermes Agent | ✅ Support complet |
| Autres agents compatibles | ✅ Format universel |

## Installation

```bash
# Option 1 : npx (Recommandé)
npx skills add https://github.com/Turbonew1/skill-pilot

# Option 2 : Manuel
git clone https://github.com/Turbonew1/skill-pilot.git
bash skill-pilot/scripts/install.sh
```

## Comment Ça Marche

```
Utilisateur : "Créez-moi une landing page"
         ↓
SkillPilot lit les règles de routage
         ↓
Correspondance : "landing page" → /design-taste-frontend
         ↓
L'agent invoque automatiquement le skill
         ↓
Terminé — aucune commande manuelle nécessaire
```

## Utilisation

### Première Fois

Après l'installation, lancez le scan :

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

### Utilisation Quotidienne

**Parlez normalement.** Aucune commande nécessaire.

| Vous dites | L'agent utilise automatiquement |
|---|---|
| "Créez-moi une landing page" | skill `design-taste-frontend` |
| "Corrigez ce bug" | agent `tdd-guide` |
| "Revoyez mon code" | agent `code-reviewer` |
| "Recherchez XX technologie" | agent `deep-research` |
| "Éditez cette vidéo" | outils `mcp-video` |
| "Rendez-le minimaliste" | skill `minimalist-ui` |
| "Audit de sécurité" | agent `security-reviewer` |
| "Créer une présentation" | skill `/pptx` |
| "Générer un PDF" | skill `/pdf` |

### Re-scan

Après avoir installé de nouveaux skills ou agents :

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

## Ce Qui Est Scanné

| Source | Emplacement | Contenu |
|---|---|---|
| Skills | `~/.agents/skills/` | Tous les skills installés (400+) |
| Agents | `~/.claude/agents/` | Définitions des agents (60+) |
| Outils MCP | Configuration de l'agent | Serveurs MCP actifs |

## Règles de Routage

Le fichier de routage généré se trouve à :

```
~/.claude/rules/common/skill-pilot.md
```

Ce fichier se charge automatiquement dans **chaque session d'agent**.

### Priorité

1. **Demande explicite** — "Utilisez X skill" → toujours respecté
2. **Correspondance linguistique** — Code Python → `python-reviewer`
3. **Type de tâche** — Correction de bug → `tdd-guide`
4. **Domaine** — Santé → `healthcare-reviewer`

### Règles Personnalisées

Éditez le fichier de routage pour ajouter vos propres règles :

```markdown
| Motif | Outil | Priorité |
|---|---|---|
| "déployer en staging" | `/deployment-patterns` | HIGH |
```

## Questions Fréquentes

### Q : Est-ce que ça remplace mes skills existants ?
**A :** Non. Cela ajoute une couche de routage par-dessus. Vos skills fonctionnent exactement de même — cela aide juste votre agent à choisir le bon.

### Q : Et si le routeur choisit le mauvais outil ?
**A :** Éditez `~/.claude/rules/common/skill-pilot.md` pour ajuster les priorités, ou dites "utilisez X skill" pour écraser.

### Q : À quelle fréquence dois-je re-scanner ?
**A :** Uniquement après avoir installé/supprimé des skills ou agents. Le fichier de routage persiste entre les sessions.

---

## Contribuer

1. Forkez le dépôt
2. Créez une branche de fonctionnalités
3. Faites vos modifications
4. Soumettez une PR

Issues et PRs bienvenues !

## Licence

[Licence MIT](LICENSE) · Copyright (c) 2026
