# Demo Scenario — The Idle Cup

> **役割**: 書類審査・予選会・決勝で実演する demo の脚本。世界観を 90 秒で届ける。
> **読者**: ハッカソン審査員 / メンタリング AI-DLC Champion
> **配置根拠**: Demo シナリオは公式階層に明示の場を持たないため `extensions/demo/` に独自配置。

---

## 1. Demo の指針

| 指針 | 説明 |
|---|---|
| **沈黙を恐れない** | The Cup は説明なく現れる。観客に説明する誘惑を抑える |
| **詩的な再構成** | Whisper は技術ログではなく、生活の言葉で語られる |
| **同時表示の倫理** | Idle Index と Human Agency を必ず一画面に並べる |
| **再帰の明示** | 最後の 10 秒で必ず「これを AI-DLC で作った」を示す |

---

## 2. 90 秒シナリオ（書類審査・予選会・決勝で共通の骨子）

### Scene 0 — 暗転（0:00〜0:05）

```
画面: 真っ暗
音: 微かな雨音、街のノイズ
Voice-over: なし
```

### Scene 1 — The Cup（0:05〜0:25）

ユーザーが目を覚ます。スマートフォンを掴むと、ロック画面に通知。アンロックすると、**説明なき一杯**だけが現れる。

```
─────────────────────────────────────
  ☕

  Ethiopia Yirgacheffe Natural
  87°C / 3:20 / 1:15

  華やかな酸味と、軽い甘さ
─────────────────────────────────────

[Approve]   [今日は自分で]   [もう一つ見る]
```

**ナレーション（任意・予選会以降のみ）**:
> 朝、AI が選んだ一杯だけが、説明なく現れる。

### Scene 2 — Confirmation Whisper（0:25〜0:50）

ユーザーは画面を **長押し**。Whisper が静かにフェードインする。

```
─────────────────────────────────────
  今朝のチェックインには、
  少しだけ静けさを求めるサインがありました。

  昨夜の眠りは浅く、
  外は雨で、
  午後には大切な予定があります。

  今日は、気分を急に押し上げるより、
  ゆっくり整える一杯を選びました。
─────────────────────────────────────
```

**ナレーション（任意）**:
> 説明は、求めた人にだけ現れる。

### Scene 3 — Life Delegation Console（0:50〜1:10）

ユーザーが下にスワイプすると、**余白と喪失** が同時に提示される。

```
┌─────────────────────────────┐
│  Idle Index                 │
│  ████████████████████░░ 87% │
│                             │
│  Human Agency Remaining     │
│  █░░░░░░░░░░░░░░░░░░░░  3%  │
│                             │
│  今日あなたが自分で決めたこと │
│  ・午後3時の散歩を断る      │
└─────────────────────────────┘
```

**ナレーション**:
> Idle Index 87%。あなたが今日自分で決めたのは、たった 1 件です。
> ——それは、堕落でしょうか。それとも、ようやく取り戻した余白でしょうか。

**画面下部に小さく**:
> あなたは今、自分でこのデモを観るかどうかさえ決めていません。

### Scene 4 — Approve & Brew（1:10〜1:25）

ユーザーは静かに **Approve** をタップする。スマホを置き、ドリッパーに豆を計量する。湯が落ちる音、立ち上る湯気。**唯一残された儀式**。

```
画面: ドリップ動画（実写）
SE: 湯の落ちる音、湯気、ドリッパーの重み
```

### Scene 5 — Self-Reference Reveal（1:25〜1:30）

最後の 5 秒。画面が二分割される。

```
┌──────────────┬──────────────┐
│              │              │
│   ☕         │   AI-DLC     │
│   The Cup    │   Process    │
│              │              │
│  AI selects  │  AI proposes │
│  Human       │  Human       │
│  approves    │  approves    │
│              │              │
└──────────────┴──────────────┘

   "We delegated our lives.
    We delegated our code.
    Both ended in a cup."
```

**画面下部に小さく**:
> Built with AI-DLC. About AI-DLC delegation.

---

## 3. 予選会・決勝での拡張

### 予選会版（5 分以内）

- 上記 90 秒シナリオを **冒頭で再生**
- 続いて以下を実演:
  1. **AWS アーキテクチャの一画面ビュー**（[`../../inception/application-design/aws-architecture.md`](../../inception/application-design/aws-architecture.md)）
  2. **6 Units の役割の言語化**（[`../../construction/plans/construction-plan.md`](../../construction/plans/construction-plan.md)）
  3. **Idle Index の経時グラフ**（demo データで OK）
  4. **Whisper の生成過程の demo**（Bedrock 呼び出しのライブ）

### 決勝版（10〜15 分）

- 上記 + 以下を追加:
  - **観客 1 名のデモ参加**: 観客の睡眠（自己申告）と当日予定をその場で入力し、ライブで一杯が選ばれる
  - **同型展示**: 画面の半分で AI が一杯を選定し、もう半分で AI-DLC が次の Unit のコードを起案する、ライブ実演

---

## 4. Demo の "禁じ手"

審査員に届ける際、**やらないこと**を以下に固定する。

| 禁じ手 | 理由 |
|---|---|
| 「これは LLM を使っています」と冒頭で技術スタックを並べる | 体験を技術解説で殺す |
| 過剰なナレーション | 沈黙の意味を希薄化させる |
| Idle Index 87% を「成功指標」と説明する | 倫理的アンビバレンスを単純化する |
| Whisper を初期表示する | 説明なき承認の核を破壊する |
| AI-DLC を冒頭で説明する | 同型性の Reveal は最後に置く |

---

## 5. Demo インフラ要件（Phase 1 / Phase 2）

### Phase 1（書類審査時点）
- README + 静止画 / 短尺動画でシナリオを伝達
- Demo シナリオ本書 (`demo-scenario.md`) が成果物

### Phase 2（予選会・決勝）
- Web プロトタイプ（Next.js）+ Bedrock 呼び出し
- DynamoDB（嗜好データのモック）
- EventBridge Scheduler（朝のトリガ実演）

---

## 6. 関連ドキュメント

| 観点 | 参照先 |
|---|---|
| Intent | [`../../inception/application-design/intent.md`](../../inception/application-design/intent.md) |
| Self-Reference | [`../meta/self-reference.md`](../meta/self-reference.md) |
| AWS Architecture | [`../../inception/application-design/aws-architecture.md`](../../inception/application-design/aws-architecture.md) |
| User Stories | [`../../inception/user-stories/stories.md`](../../inception/user-stories/stories.md) |

---

*Demo は世界観の最短経路である。技術より沈黙を、説明より儀式を。*
