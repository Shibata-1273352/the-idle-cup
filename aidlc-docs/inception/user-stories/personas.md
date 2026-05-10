# Personas — The Idle Cup

> **役割**: User Stories の語り手であるユーザー類型を定義する。
> **準拠**: AI-DLC v0.1.8 `inception/user-stories/personas.md`
> **読者**: チーム / 審査員 / Phase 2 プロダクトオーナー

---

## P-1: Hiroto, 40 — Decision Maker

### Snapshot
- **役割**: スタートアップ CEO、技術と経営の両判断を担う
- **居住**: 東京・港区。リモート + 出社の混在
- **生活**: 1 日あたり 100+ 件の判断。意思決定後半に質が落ちる自覚

### Pain
- 朝のコーヒー選びすら "もう決めたくない"
- 既存サブスク（Blue Bottle）はカスタマイズが必要で結局疲れる
- マインドフルネスは "また自分で何かしないといけない" 行為

### Goal
- 朝の 10 分を、判断ゼロで開始したい
- ただし、選ばれた一杯の **理由は知れる選択肢** が欲しい（経営判断のメタ訓練として）

### Why The Idle Cup
- 説明なき承認 + 長押しで Whisper の二段構造が、彼の認知パターンと一致する
- Idle Index が経営者向けの "意思決定容量メーター" として機能する

### Mapping to Stories
US-01, US-02, US-04, US-07

---

## P-2: Sayaka, 28 — AI-Native Knowledge Worker

### Snapshot
- **役割**: 大手 IT 企業の PM。Claude / Cursor / Notion AI のヘビーユーザー
- **居住**: 渋谷区。完全リモート。同居なし
- **生活**: AI 委譲への心理的抵抗がほぼない。むしろ委譲できないことへの苛立ち

### Pain
- 既存 AI アシスタントは「対話を要求する」設計で、判断疲労を温存する
- レコメンドの精度勝負には飽きている。"私が探さない発見" が欲しい

### Goal
- 朝の儀式を、AI が完成させた状態でユーザーとして参加したい
- 自分が "AI に任せた" 履歴の **可視化** に審美的興味（Idle Index への共感）

### Why The Idle Cup
- 「対話を要求しない発見」のコアバリューが彼女の価値観に直撃
- Confirmation Whisper の詩的トーンが SNS でのシェア体験を生む

### Mapping to Stories
US-01, US-03, US-05, US-08

---

## P-3: Kenji, 52 — Wellness-Conscious Veteran

### Snapshot
- **役割**: 大企業の事業部長。健康診断で生活習慣の改善を指導されている
- **居住**: 横浜市。家族同居
- **生活**: 養生・睡眠改善・気分管理に意識的。Apple Health のデータを蓄積

### Pain
- "気分を整える" のセルフ管理が逆にプレッシャー
- 朝の判断が当日の気分を左右する自覚があるが、最適化の方法を知らない

### Goal
- 自分の睡眠・予定・天候を加味した一杯が、何も考えずに用意される状態
- "これは身体に良い選択である" ことを、押し付けず示してほしい

### Why The Idle Cup
- User State Estimator が彼の Apple Health データを取り込み、過剰に押し付けない統合を行う
- Whisper の "今日は気分を急に押し上げるより、ゆっくり整える" のトーンが彼の価値観と整合

### Mapping to Stories
US-02, US-04, US-06, US-09

---

## P-4: Mei, 31 — Coffee Enthusiast & Skeptic

### Snapshot
- **役割**: フリーランスデザイナー。週末に自家焙煎をする
- **居住**: 京都市。築 70 年の町家
- **生活**: コーヒー選びそのものが趣味。AI 委譲には懐疑的

### Pain
- AI レコメンドを "自分の発見の楽しみを奪うもの" と感じる
- しかし、未知のロースターとの出会いは継続的に欲しい

### Goal
- 自分の趣味の領域は守りつつ、Discovery Platform としての **新しい焙煎所提案** が欲しい
- 委譲レベルを段階的に調整できる権限が欲しい

### Why The Idle Cup
- "今日は自分で" ボタンによる、委譲レベルの可逆性
- Whisper を介して **発見の物語** に接続される（押し付けられた発見ではない）
- Phase 2 の Discovery 連動物販で、提携焙煎所からの新規購入導線が彼女の趣味に寄与

### Mapping to Stories
US-03, US-06, US-08, US-10

---

## ペルソナの分布と狙い

| 軸 | P-1 Hiroto | P-2 Sayaka | P-3 Kenji | P-4 Mei |
|---|---|---|---|---|
| AI 委譲への心理的距離 | 中 | 近 | 中 | 遠 |
| コーヒーへの関心 | 中 | 低 | 中 | 高 |
| Idle Index への審美感度 | 高 | 高 | 中 | 中 |
| 主要 KPI | 朝の判断削減 | "対話を要求しない" 体験 | 養生整合 | Discovery |

4 人のペルソナは事業仮説 ([`../../extensions/business/business-intent.md`](../../extensions/business/business-intent.md) §3) のセグメント A / B / C / D と一対一対応する。

---

## 関連ドキュメント

| 観点 | 参照先 |
|---|---|
| User Stories | [`./stories.md`](./stories.md) |
| Requirements | [`../requirements/requirements.md`](../requirements/requirements.md) |
| Business Intent | [`../../extensions/business/business-intent.md`](../../extensions/business/business-intent.md) |
| Demo Scenario | [`../../extensions/demo/demo-scenario.md`](../../extensions/demo/demo-scenario.md) |

---

*ペルソナは固定された設定ではなく、Phase 2 で実ユーザーの観測に基づき更新される生きた文書。*
