# ☕ The Idle Cup

> **This is not a coffee app.**
> **It is a service that removes decisions from your day.**

[![AI-DLC](https://img.shields.io/badge/AI--DLC-v0.1.8--compliant-blue)](https://github.com/awslabs/aidlc-workflows)
[![Phase](https://img.shields.io/badge/Phase-Inception-green)](aidlc-docs/aidlc-state.md)
[![Methodology](https://img.shields.io/badge/Methodology-Honest-purple)](aidlc-docs/extensions/meta/methodology-honesty.md)

開発では AI が実装し、人間が承認する。The Idle Cup では AI が生活を実装し、人間が一杯だけを承認する。

**AWS Summit Japan 2026 AI-DLC ハッカソン 応募作品**

---

## 🫠 How this makes people useless

The Idle Cup does not make people lazy by giving them entertainment. It makes them idle by removing micro-decisions from their day.

判断を消すというのは、エンタメで時間を奪うこととは違います。本作品は、朝起きてからの一日を構成する小さな判断を、ユーザーが目覚める前に AI が完了させます。

> What should I drink this morning?
> What should I reply to this email?
> How should I feel today?

AI completes these decisions before the user wakes up. The user is left with only one act: **approve the cup**.

ユーザーに残されるのは、ただ一つの行為——AI が選んだ一杯を受け取り、それを淹れて飲むことだけです。

---

## 🎯 Why this makes humans idle

私たちは「人をダメにする」を、堕落ではなく、Larry Wall のいうプログラマーの美徳としての **怠慢 (Laziness as a virtue)** の拡張として解釈しました。怠慢を極限まで追求した先に、人間に残るのは何か。私たちはその答えを、AI に判断を委ねたあとに残る一杯のコーヒーと、それを淹れて飲む静かな儀式に置きました。

私たちはチームに AI-DLC を導入したとき、最初に戻ってきたのが朝にコーヒーを淹れる時間であることに気づきました。AI が実装の雑事を引き受け、人間に儀式が返ってきたのです。この構造を生活全般に拡張すれば、誰もがコーヒーの香りを取り戻せるのではないか——これが本作品の出発点です。

---

## 🔄 AI-DLC reversed into daily life

```
┌─────────────────────────────────────────────┐
│  作品テーマ: AI-DLC を生活に反転適用        │
│  ┌───────────────────────────────────────┐  │
│  │  開発プロセス: AI-DLC で本作品を構築   │  │
│  └───────────────────────────────────────┘  │
└─────────────────────────────────────────────┘
```

**作品テーマ** は AI-DLC を生活に反転適用します。AI が日常の判断と実行を主導し、人間が承認するのは「今日の一杯」だけ。承認の対象が極限まで縮約された世界では、人間は判断疲れから解放され、ささやかな儀式に時間を取り戻します。

**開発プロセス** は AI-DLC で本作品を構築しています。`aidlc-docs/inception/` が Inception 成果物、`aidlc-docs/construction/` が Construction 成果物、`aidlc-docs/audit.md` が全意思決定の不変ログとして機能します。テーマと方法論が同型であるため、本作品は AI-DLC の有効性を実証する事例として機能します。

> **方法論的誠実性について**: 本プロジェクトの Bolt 単位ログは retroactive に再構成されています。隠さず明示することを選びました。詳細は [`aidlc-docs/extensions/meta/methodology-honesty.md`](aidlc-docs/extensions/meta/methodology-honesty.md) を参照してください。

---

## 💎 Demo Experience

### ☕ The Cup — 説明なき一杯

ユーザーが目を覚ますと、AI が選び抜いた一杯だけが、説明なく提示されます。

> Ethiopia Yirgacheffe Natural / 87℃ / 3分20秒
> 華やかな酸味と、軽い甘さ

### 🤫 Confirmation Whisper — 長押しで現れる囁き

カップの画面を長押しすると、選定の理由が静かに開示されます。内部推論をそのまま表示するのではなく、根拠情報をユーザー向けに短く詩的に再構成します。

> 今朝のチェックインには、少しだけ静けさを求めるサインがありました。
> 昨夜の眠りは浅く、外は雨で、午後には大切な予定があります。
> 今日は、気分を急に押し上げるより、ゆっくり整える一杯を選びました。

### 📊 Life Delegation Console — 余白と喪失の可視化

| 指標 | 値 |
|---|---|
| **Idle Index / 余白指数** | `87%` |
| **Human Agency Remaining** | `3%` |
| 今日あなたが自分で決めたこと | 1件 |

詳細なデモシナリオは [`aidlc-docs/extensions/demo/demo-scenario.md`](aidlc-docs/extensions/demo/demo-scenario.md) を参照してください。

---

## 📂 リポジトリの歩き方

技術詳細・設計・ビジネス意図はすべて `aidlc-docs/` に移譲されています。本 README は世界観のフロントドアです。

### 必須3ファイル（公式 v0.1.8 準拠）

| ファイル | 役割 |
|---|---|
| [`aidlc-docs/aidlc-state.md`](aidlc-docs/aidlc-state.md) | 📍 現在のフェーズ・進捗・採用拡張 |
| [`aidlc-docs/audit.md`](aidlc-docs/audit.md) | 📜 すべての意思決定の不変ログ（SoT） |
| [`aidlc-docs/execution-plan.md`](aidlc-docs/execution-plan.md) | 📋 計画された stage 列 |

### 3 フェーズ成果物

| ディレクトリ | 内容 |
|---|---|
| [`aidlc-docs/inception/`](aidlc-docs/inception/) | 🔵 要件・ユーザーストーリー・アプリケーション設計（AWS アーキテクチャ含む） |
| [`aidlc-docs/construction/`](aidlc-docs/construction/) | 🟢 Construction Plan と 6 Units の分解（per-unit の機能/非機能/インフラ設計および実装は Phase 2） |
| [`aidlc-docs/operations/`](aidlc-docs/operations/) | 🟡 Phase 2 / Designed |

### 採用拡張（`extensions/` 配下）

| ディレクトリ | 内容 |
|---|---|
| [`aidlc-docs/extensions/meta/`](aidlc-docs/extensions/meta/) | 🔄 Self-Reference: 作品 ⇔ 開発の同型 / 方法論的誠実性宣言 |
| [`aidlc-docs/extensions/business/`](aidlc-docs/extensions/business/) | 💼 Discovery Platform としてのビジネス意図 |
| [`aidlc-docs/extensions/demo/`](aidlc-docs/extensions/demo/) | 🎬 デモシナリオ |

---

## ✨ 観客に届けたいもの

AI-DLC は、開発から人間の雑事を取り除き、創造に集中させる方法論です。
The Idle Cup は、その思想を生活に反転適用します。
AI がすべてを終わらせた朝、人間には一杯のコーヒーだけが残ります。

> それは堕落なのか。
> それとも、ようやく取り戻した余白なのか。

---

<sub>本リポジトリは AWS Summit Japan 2026 AI-DLC ハッカソン応募作品として公開されています。`awslabs/aidlc-workflows` v0.1.8 の公式階層に準拠し、独自拡張（Self-Reference / Bolt-Logging / Living-Spec / Methodology-Honesty）を `aidlc-docs/extensions/` 配下に配置しています。コーヒー豆のデータについては、各焙煎所のウェブサイトの利用規約を確認した上で、引用の形で扱っています。Amazon SP-API、Amazon Pay、Amazon Alexa、FBA との統合は、Phase 2 で実装する設計済みの拡張領域です。</sub>
