# User Stories — The Idle Cup

> **役割**: Requirements を INVEST 準拠のユーザーストーリーに翻訳し、テスト可能な仕様にする。
> **準拠**: AI-DLC v0.1.8 `inception/user-stories/stories.md` 配置規約 / INVEST: Independent / Negotiable / Valuable / Estimable / Small / Testable
> **読者**: チーム / 審査員 / Phase 2 で参画する開発者

---

## ストーリー一覧

| ID | タイトル | ペルソナ | FR/NFR |
|---|---|---|---|
| US-01 | 朝、説明なき一杯を受け取る | Hiroto, Sayaka | FR-01〜04 |
| US-02 | 状態に基づく一杯の自動選定 | Hiroto, Kenji | FR-14〜17, NFR-06,07 |
| US-03 | 長押しで Whisper を読む | Sayaka, Mei | FR-06〜09, NFR-08,12 |
| US-04 | Idle Index と Human Agency を見る | Hiroto, Kenji | FR-10〜13, NFR-13 |
| US-05 | 棄却して代替を 1 つだけ受け取る | Sayaka | FR-05 |
| US-06 | 今日は自分で選ぶことにする | Kenji, Mei | NFR-14 |
| US-07 | 抽出パラメータを参照して淹れる | Hiroto | FR-20,21 |
| US-08 | 一杯の理由を SNS でシェアする | Sayaka, Mei | FR-06,07 |
| US-09 | 養生に整合した一杯であることを確認する | Kenji | FR-09, NFR-12 |
| US-10 | 提案された焙煎所からの単発購入（Phase 2） | Mei | NFR-10,11 |

---

## US-01 — 朝、説明なき一杯を受け取る

> **As a** 判断を委譲したい朝の私（Hiroto / Sayaka）
> **I want** スマートフォンを開いた瞬間、説明なく一杯だけが提示される
> **So that** 朝の最初の判断容量を、その一杯を承認すること**だけ**に使い切れる

### Acceptance Criteria
- [ ] AC-01.1: ロック解除後の最初の画面に、豆 / 焙煎度 / 抽出パラメータ / 一行の風味記述だけが表示される
- [ ] AC-01.2: 表示は起床推定時刻 ±5 分以内（NFR-01）
- [ ] AC-01.3: 選定理由は初期表示に**含まれない**（FR-03）
- [ ] AC-01.4: ボタンは [Approve] / [今日は自分で] / [もう一つ見る] の 3 つのみ
- [ ] AC-01.5: スクリーンショット時に Idle Index が見えない設計（広告化の回避）

---

## US-02 — 状態に基づく一杯の自動選定

> **As a** 自分の文脈を AI に読み取ってほしい私（Hiroto / Kenji）
> **I want** 睡眠・天候・予定・嗜好履歴から、その朝にふさわしい一杯が自動で選ばれる
> **So that** 自分で文脈をパッキングして説明する作業を **しなくていい**

### Acceptance Criteria
- [ ] AC-02.1: 状態ベクトルは起床想定時刻の 30〜60 分前に構築される（FR-14）
- [ ] AC-02.2: 状態ベクトルは PII を含まず、集約値のみ保存される（NFR-06）
- [ ] AC-02.3: 同一日のうちに 2 度目の選定要求があっても、ベクトルは再計算されない（FR-23 整合）
- [ ] AC-02.4: 選定が状態ベクトルに依存していることを、内部的にトレース可能（X-Ray, NFR-16）

---

## US-03 — 長押しで Whisper を読む

> **As a** 説明を求めるときだけ説明を欲しい私（Sayaka / Mei）
> **I want** カップ画面を 1.5 秒以上長押しすると、Whisper が静かに開示される
> **So that** 必要なとき**だけ**選定の物語を受け取り、必要ないとき沈黙のままにできる

### Acceptance Criteria
- [ ] AC-03.1: 長押し検知後 1.5 秒以内にフェードイン（NFR-02）
- [ ] AC-03.2: Whisper は 80〜200 文字（FR-08）
- [ ] AC-03.3: PII は丸めて表現される（"昨夜の眠りは浅く" 程度、FR-09）
- [ ] AC-03.4: Whisper は Bedrock Guardrails 経由で生成される（NFR-08）
- [ ] AC-03.5: Whisper を初期表示にする設定は提供しない（NFR-12）

---

## US-04 — Idle Index と Human Agency を見る

> **As a** 自分が今日 AI に何を委譲したかを見たい私（Hiroto / Kenji）
> **I want** Idle Index と Human Agency を **同時に** 見られる
> **So that** "委譲した自分" と "決めた自分" の両方を、欠陥なく観測できる

### Acceptance Criteria
- [ ] AC-04.1: Idle Index と Human Agency は同一画面に並列表示（NFR-13）
- [ ] AC-04.2: "今日あなたが自分で決めたこと" がリストとして表示される（FR-13）
- [ ] AC-04.3: Idle Index の値は朝の Cup 提示後に固定される（FR-23）
- [ ] AC-04.4: Human Agency Remaining が小さくても、ネガティブな視覚要素（赤字 / 警告アイコン）を伴わない（FR-12）

---

## US-05 — 棄却して代替を 1 つだけ受け取る

> **As a** 提示が今日の気分に合わない私（Sayaka）
> **I want** [もう一つ見る] を押すと、代替が **1 つだけ** 提示される
> **So that** 無限の選択肢に再び引き戻されない

### Acceptance Criteria
- [ ] AC-05.1: 代替は 1 度だけ提示される（FR-05）
- [ ] AC-05.2: 2 度目の棄却で「今日は自分で」モードに移行することを提案する
- [ ] AC-05.3: 棄却理由のフリーテキスト入力は要求しない（判断削減原則の保持）

---

## US-06 — 今日は自分で選ぶことにする

> **As a** 委譲を一時的に解除したい私（Kenji / Mei）
> **I want** [今日は自分で] を選ぶと、AI 選定が当日のみ無効化される
> **So that** 委譲そのものは続けつつ、自分の手で選ぶ余地を保てる

### Acceptance Criteria
- [ ] AC-06.1: 解除はその日の終了（深夜 0 時）まで（NFR-14）
- [ ] AC-06.2: 翌朝には自動で復帰、再設定不要
- [ ] AC-06.3: 解除日の Idle Index は 1 件分減算され、Human Agency が 1 加算される（透明性）

---

## US-07 — 抽出パラメータを参照して淹れる

> **As a** 物理的に一杯を淹れる私（Hiroto）
> **I want** 提示された温度 / 時間 / 比率を見ながら抽出できる
> **So that** AI が選んだものを **正確に再現** できる

### Acceptance Criteria
- [ ] AC-07.1: 温度・時間・比率が画面に常時表示される
- [ ] AC-07.2: タイマー機能が組み込まれている
- [ ] AC-07.3: 抽出完了後、ユーザーは「淹れた」をワンタップで記録できる
- [ ] AC-07.4: 「淹れた」記録は Idle Index の補強情報として使われる（"承認 → 儀式" の完了確認）

---

## US-08 — 一杯の理由を SNS でシェアする

> **As a** 自分の朝の体験を SNS に残したい私（Sayaka / Mei）
> **I want** Whisper のテキストと Cup の画像を、**個人情報を伴わない形式で** シェアできる
> **So that** プライバシーを守りつつ、世界観を友人と共有できる

### Acceptance Criteria
- [ ] AC-08.1: シェア画像は風味記述と Whisper 抜粋のみ（数値は含めない）
- [ ] AC-08.2: 元の状態ベクトル（睡眠 / 予定）は一切含まれない
- [ ] AC-08.3: ハッシュタグ `#TheIdleCup` が自動付与される

---

## US-09 — 養生に整合した一杯であることを確認する

> **As a** 体調管理を意識する私（Kenji）
> **I want** 提示された一杯が、自分の体調コンテキスト（睡眠 / 心拍 / 予定）と整合していることを Whisper で確認できる
> **So that** 押し付けではなく、配慮の存在を感じられる

### Acceptance Criteria
- [ ] AC-09.1: Whisper が体調コンテキストへの言及を含む（"昨夜の眠りは浅く"）
- [ ] AC-09.2: 言及は丸められた表現で、生データは出ない
- [ ] AC-09.3: 養生フレーミングは押し付けず、トーンとして埋め込む

---

## US-10 — 提案された焙煎所からの単発購入（Phase 2）

> **As a** 趣味として焙煎所を発見したい私（Mei）
> **I want** Whisper から、その豆の焙煎所への購入導線を辿れる
> **So that** 委譲の体験から、能動的な発見へ自然に接続できる

### Acceptance Criteria（Phase 2）
- [ ] AC-10.1: Whisper 末尾に "この豆を提供している焙煎所" のリンクが現れる
- [ ] AC-10.2: 購入は Amazon Pay（Recurring Payment 不可、単発）
- [ ] AC-10.3: 購入後、ユーザーの嗜好ベクトルにシグナルが追加される

---

## INVEST 検証

| ストーリー | I | N | V | E | S | T |
|---|---|---|---|---|---|---|
| US-01 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| US-02 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| US-03 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| US-04 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| US-05 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| US-06 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| US-07 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| US-08 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| US-09 | ✅ | ✅ | ✅ | ✅ | ✅ | ✅ |
| US-10 | ⚠️ Phase 2 で再評価 | ✅ | ✅ | ✅ | ✅ | ✅ |

US-10 のみ Phase 2 依存で independence が低下。Phase 2 開始時に decomposition を再評価する。

---

## ストーリー → Unit 対応

| ストーリー | 主要 Unit |
|---|---|
| US-01 | U6: Life Delegation Console（Cup view） / U2, U3（一杯と抽出仕様の供給） |
| US-02 | U1: User State Estimator / U2: Coffee Selection Engine |
| US-03 | U5: Confirmation Whisper |
| US-04 | U4: Idle Index Calculator / U6: Life Delegation Console（同時表示） |
| US-05 | U2: Coffee Selection Engine（代替提示）/ U6（モード移行誘導） |
| US-06 | U6: Life Delegation Console（モード切替） |
| US-07 | U3: Brewing Parameter Generator / U6（タイマー UI） |
| US-08 | U5: Confirmation Whisper（テキスト供給） / U6: Life Delegation Console（Share Card 生成・OS Share Sheet 連携） |
| US-09 | U5: Confirmation Whisper |
| US-10 | Phase 2 — Discovery Platform 拡張（U7 / U8） |

---

## 一枚トレーサビリティ表（Persona → Story → FR/NFR → Unit → AWS）

> 審査員が短時間で全体像を把握するための1枚ビュー。各セルの詳細は [`personas.md`](./personas.md) / [`../requirements/requirements.md`](../requirements/requirements.md) / [`../application-design/components.md`](../application-design/components.md) / [`../application-design/aws-architecture.md`](../application-design/aws-architecture.md) を参照。

| Persona | Story | FR | NFR | Unit | 主要 AWS サービス |
|---|---|---|---|---|---|
| Hiroto / Sayaka | US-01 | FR-01〜FR-04 | NFR-01 | U6, U2, U3 | EventBridge Scheduler / Step Functions / Amplify (or S3+CloudFront) |
| Hiroto / Kenji | US-02 | FR-14〜FR-17 | NFR-06, NFR-07 | U1, U2 | Lambda / DynamoDB / Secrets Manager（外部 API トークン） |
| Sayaka / Mei | US-03 | FR-06〜FR-09 | NFR-02, NFR-08, NFR-12 | U5 | Amazon Bedrock (Claude) / Bedrock Guardrails |
| Hiroto / Kenji | US-04 | FR-10〜FR-13, FR-22, FR-23 | NFR-13 | U4, U6 | Lambda / DynamoDB |
| Sayaka | US-05 | FR-05 | NFR-05 | U2, U6 | Lambda / DynamoDB |
| Kenji / Mei | US-06 | （UI モード制御） | NFR-14 | U6 | Amplify (or S3+CloudFront) |
| Hiroto | US-07 | FR-20, FR-21 | （UI 体感） | U3, U6 | Lambda |
| Sayaka / Mei | US-08 | FR-06, FR-07 | NFR-09 | U5, U6 | Bedrock (Claude) / Amplify (or S3+CloudFront) |
| Kenji | US-09 | FR-09 | NFR-08, NFR-12 | U5 | Bedrock (Claude) + Bedrock Guardrails |
| Mei | US-10 (Phase 2) | （Discovery 物販） | NFR-10, NFR-11 | Phase 2: U7 Discovery Connector / U8 Payment Adapter | EventBridge Pipes / Amazon Pay / SP-API / FBA |

横断的関心事（共通基盤）: API Gateway / Cognito（認証）/ CloudWatch / X-Ray / CloudTrail（観測性 = NFR-15〜17）/ KMS（NFR-06〜09 暗号化）/ Step Functions DLQ（障害時）。

---

## 関連ドキュメント

| 観点 | 参照先 |
|---|---|
| Personas | [`./personas.md`](./personas.md) |
| Requirements | [`../requirements/requirements.md`](../requirements/requirements.md) |
| Components | [`../application-design/components.md`](../application-design/components.md) |
| Construction Plan | [`../../construction/plans/construction-plan.md`](../../construction/plans/construction-plan.md) |

---

*ストーリーは生きた文書である。Phase 2 で実ユーザー観測に基づき AC を update する。*
