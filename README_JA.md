<p align="center">
  <img src="https://img.shields.io/badge/agent--router-v1.0.0-6B46C1?style=for-the-badge" alt="SkillPilot v1.0.0" />
  <img src="https://img.shields.io/badge/対応-Claude%20Code%20%7C%20Codex%20%7C%20OpenClaw-FF6B35?style=for-the-badge" alt="複数エージェント対応" />
  <img src="https://img.shields.io/badge/ライセンス-MIT-green?style=for-the-badge" alt="MIT ライセンス" />
</p>

<h1 align="center">SkillPilot</h1>

<p align="center">
  <em>AIエージェント向けインテリジェントタスクルーティング</em>
</p>

<p align="center">
  <a href="README.md">🇺🇸 English</a> · <a href="README_CN.md">🇨🇳 中文</a> · <b>🇯🇵 日本語</b> · <a href="README_KO.md">🇰🇷 한국어</a> · <a href="README_ES.md">🇪🇸 Español</a> · <a href="README_FR.md">🇫🇷 Français</a> · <a href="README_DE.md">🇩🇪 Deutsch</a> · <a href="README_PT.md">🇧🇷 Português</a> · <a href="README_RU.md">🇷🇺 Русский</a>
</p>

---

## とは

**SkillPilot** は、インストール済みのスキル、エージェント、MCPツールをスキャンし、各タスクに最適なツールをエージェントに伝える**スマートルーティングテーブル**を生成します。

### 解決する問題

400以上のスキル、60以上のエージェント、数十のMCPツールがインストールされています。「ランディングページを作りたい」と言った時、エージェントが `design-taste-frontend` と `minimalist-ui` のどちらを使えばいいかどう判断しますか？

### 解決策

SkillPilot は **タスクパターン → 最適なツール** のマッピングを作成します。すべてのセッションで自動的に読み込まれるため、コマンドを入力する必要はなく、タスクを説明するだけです。

### 対応エージェント

| エージェント | 状態 |
|---|---|
| Claude Code | ✅ 完全対応 |
| Codex | ✅ 完全対応 |
| OpenClaw | ✅ 完全対応 |
| Cursor | ✅ 完全対応 |
| Hermes Agent | ✅ 完全対応 |
| その他の互換エージェント | ✅ ユニバーサルフォーマット |

## インストール

```bash
# 方法 1: npx（推奨）
npx skills add https://github.com/Turbonew1/skill-pilot

# 方法 2: 手動
git clone https://github.com/Turbonew1/skill-pilot.git
bash skill-pilot/scripts/install.sh
```

## 仕組み

```
ユーザー: "ランディングページを作りたい"
         ↓
SkillPilot がルーティングルールを読み込み
         ↓
マッチ: "ランディングページ" → /design-taste-frontend
         ↓
エージェントが自動的にスキルを呼び出し
         ↓
完了 — 手動コマンドは不要
```

## 使い方

### 初回

インストール後、スキャンを実行：

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

### 日常使い

**普通に話しかけるだけ。** コマンドは不要です。

| 你说 | エージェントが自動使用 |
|---|---|
| "ランディングページを作りたい" | `design-taste-frontend` スキル |
| "このバグを直して" | `tdd-guide` エージェント |
| "コードをレビューして" | `code-reviewer` エージェント |
| "XX技術をリサーチして" | `deep-research` エージェント |
| "この動画を編集して" | `mcp-video` ツール |
| "ミニマルなデザインにして" | `minimalist-ui` スキル |
| "セキュリティ監査" | `security-reviewer` エージェント |
| "プレゼンを作成" | `/pptx` スキル |
| "PDFを生成" | `/pdf` スキル |

### 再スキャン

新しいスキルやエージェントをインストール後：

```bash
bash ~/.agent-skills/skill-pilot/scripts/scan-tools.sh
```

## スキャン対象

| ソース | 場所 | 内容 |
|---|---|---|
| スキル | `~/.agents/skills/` | インストール済みスキル (400+) |
| エージェント | `~/.claude/agents/` | エージェント定義 (60+) |
| MCPツール | エージェント設定 | アクティブなMCPサーバー |

## ルーティングルール

生成されたルーティングファイル：

```
~/.claude/rules/common/skill-pilot.md
```

このファイルは**すべてのエージェントセッション**で自動的に読み込まれます。

### 優先順位

1. **明示的なリクエスト** — 「Xスキルを使って」 → 常に優先
2. **言語マッチ** — Pythonコード → `python-reviewer`
3. **タスクタイプ** — バグ修正 → `tdd-guide`
4. **ドメイン** — 医療 → `healthcare-reviewer`

### カスタムルール

ルーティングファイルを編集してカスタムルールを追加：

```markdown
| パターン | ツール | 優先度 |
|---|---|---|
| "ステージングにデプロイ" | `/deployment-patterns` | HIGH |
```

## よくある質問

### Q: 既存のスキルは置き換えられますか？
**A:** いいえ。これはスキルの上にルーティングレイヤーを追加するものです。既存のスキルはそのまま動作します — エージェントが正しいツールを選択するだけです。

### Q: ルーターが間違ったツールを選んだ場合は？
**A:** `~/.claude/rules/common/skill-pilot.md` を編集して優先順位を調整するか、「Xスキルを使って」と言って上書きできます。

### Q: どのくらいの頻度で再スキャンする必要がありますか？
**A:** スキルやエージェントのインストール/アンインストール時のみです。ルーティングファイルはセッション間で保持されます。

---

## コントリビュート

1. リポジトリをフォーク
2. 機能ブランチを作成
3. 変更を加える
4. PRを提出

Issues と PRs 歓迎！

## ライセンス

[MIT ライセンス](LICENSE) · Copyright (c) 2026
