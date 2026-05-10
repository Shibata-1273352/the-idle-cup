# Application Design — Components

> **役割**: 要件 / ユーザーストーリーをコンポーネント（Unit）の責務に分解する。
> **準拠**: AI-DLC v0.1.8 `inception/application-design/components.md` 配置規約
> **読者**: チーム / Construction phase の開発者 / 審査員（Unit 分解の評価軸）

---

## 1. 全体俯瞰（コンポーネント図）

```
                    ┌──────────────────────────────────────┐
                    │  Trigger (EventBridge Scheduler)      │
                    │  ユーザー個別 TZ の起床想定 -30〜60 分 │
                    └──────────────────────────────────────┘
                                       │
                                       ▼
                    ┌──────────────────────────────────────┐
                    │  Step Functions Orchestrator          │
                    │  Unit 間のフロー制御 / 補正            │
                    └──────────────────────────────────────┘
                                       │
            ┌──────────────────────────┼──────────────────────────┐
            ▼                          ▼                          ▼
   ┌─────────────────┐      ┌─────────────────┐      ┌─────────────────┐
   │ U1: User State  │      │ U2: Coffee      │      │ U3: Brewing     │
   │  Estimator      │─────▶│  Selection      │─────▶│  Parameter      │
   │                 │      │  Engine         │      │  Generator      │
   └─────────────────┘      └─────────────────┘      └─────────────────┘
            │                                                    │
            │ State Vector                                       │ Brew Spec
            ▼                                                    ▼
   ┌─────────────────┐                                 ┌─────────────────┐
   │ U4: Idle Index  │                                 │ U6: Life        │
   │  Calculator     │────────────────────────────────▶│  Delegation     │
   └─────────────────┘                                 │  Console (UI)   │
                                                       └─────────────────┘
                                                                ▲
                                                                │ on long-press
                                                                │
                                                       ┌─────────────────┐
                                                       │ U5: Confirmation│
                                                       │  Whisper        │
                                                       └─────────────────┘
```

---

## 2. Unit 仕様

### 2.1 U1: User State Estimator

#### 責務
ユーザーの当日朝の **状態ベクトル** を構築する。

#### 入力
- ユーザープロファイル（DynamoDB）
- 当日カレンダー（Google / Apple Calendar API、トークン化）
- 直近睡眠データ（Apple Health / Google Fit / 自己申告）
- 当日天候（地点 → OpenWeather）
- 直近 7 日間の Cup 履歴

#### 出力 — `StateVector`
```json
{
  "user_id": "anonymized:abc123",
  "tz": "Asia/Tokyo",
  "morning_at": "2026-05-10T06:30+09:00",
  "sleep_quality": 0.42,
  "schedule_density": 0.78,
  "weather": {"condition": "rain", "temp_c": 18},
  "mood_signal": "tense",
  "preference_drift": 0.12
}
```

#### 主要 FR / NFR
- FR-14, FR-15, FR-16
- NFR-06（PII 最小化）

#### 主要技術
AWS Lambda + DynamoDB + Step Functions（後段呼び出し）

#### 失敗モード
データ欠損時は静的中立ベクトルを返却。Whisper 側で「データが少ない朝」と表現。

---

### 2.2 U2: Coffee Selection Engine

#### 責務
状態ベクトルから、豆データベースの中で **唯一の一杯** を選定する。

#### 入力
- `StateVector`
- 豆カタログ（DynamoDB）
- ユーザー嗜好ベクトル（直近 30 日の選択分布）

#### 出力 — `CupSelection`
```json
{
  "bean_id": "et-yirgacheffe-natural-2026q1",
  "origin": "Ethiopia / Yirgacheffe",
  "process": "Natural",
  "roast_level": "light",
  "flavor_summary": "華やかな酸味と、軽い甘さ",
  "selection_rationale_token": "rationale-abc123"
}
```

`selection_rationale_token` は U5 が後で取り出すための ID。実際の rationale テキストはこの段階で生成しない。

#### 主要 FR / NFR
- FR-17, FR-18, FR-19
- NFR-15（メトリクス）

#### 主要技術
- Lambda
- 多様性制約: Determinantal Point Process（DPP）の近似 / もしくは Top-K + diversity reweighting

#### 失敗モード
カタログ参照不能 → 直近 7 日で最も承認された一杯（NFR-05 fallback）

---

### 2.3 U3: Brewing Parameter Generator

#### 責務
選定された豆に対し、**温度 / 時間 / 比率 / 抽出量** を一意に決める。

#### 入力
- `CupSelection`
- ユーザーの過去抽出評価（Phase 2）

#### 出力 — `BrewSpec`
```json
{
  "temperature_c": 87,
  "time_seconds": 200,
  "ratio_dose_water": "15:225",
  "yield_ml": 240,
  "method": "v60-pour-over"
}
```

#### 主要 FR / NFR
- FR-20, FR-21

#### 主要技術
ルールベース（焙煎度 × 処理 × 産地）+ 嗜好補正

#### 失敗モード
業界標準レシピを返却（safe default）

---

### 2.4 U4: Idle Index Calculator

#### 責務
当日の AI 委譲判断数と手動判断数から **Idle Index** と **Human Agency Remaining** を算出する。

#### 入力
- `CupSelection`（委譲 +1）
- ユーザーの当日 manual decision events（DynamoDB）

#### 出力
```json
{
  "idle_index": 0.87,
  "human_agency_remaining": 0.03,
  "manual_today": ["午後3時の散歩を断る"]
}
```

#### 主要 FR / NFR
- FR-10, FR-11, FR-12, FR-13, FR-22, FR-23

#### 主要技術
Lambda + DynamoDB

#### 失敗モード
履歴未確立時は Idle Index = 0.5 のニュートラル表示

---

### 2.5 U5: Confirmation Whisper

#### 責務
`selection_rationale_token` をもとに、ユーザー向けの **詩的な短文** を生成する。長押し検知時に呼び出される。

#### 入力
- `selection_rationale_token`
- `StateVector`（丸め済み）
- `CupSelection`

#### 出力 — `Whisper`
```text
今朝のチェックインには、少しだけ静けさを求めるサインがありました。
昨夜の眠りは浅く、外は雨で、午後には大切な予定があります。
今日は、気分を急に押し上げるより、ゆっくり整える一杯を選びました。
```

#### 主要 FR / NFR
- FR-06〜09
- NFR-08（Bedrock Guardrails）, NFR-12

#### 主要技術
Amazon Bedrock (Claude) + Bedrock Guardrails

#### Prompt 規約
- system: 詩的トーン定義 / PII 非開示制約 / 文字数 80〜200
- input: StateVector の集約値のみ（生データなし）
- guardrail: PII / 医療助言 / 押し付けトーンを抑止

#### 失敗モード
Bedrock 不能時は static fallback（"今朝の一杯です。" + 風味のみ）

---

### 2.6 U6: Life Delegation Console

#### 責務
The Cup / Idle Index / Whisper トリガを統合した **唯一の UI**。

#### 構成
- The Cup view: U2 / U3 出力をレンダリング
- Long-press handler: U5 を呼び出して Whisper を表示
- Console view: U4 出力 + manual decisions list
- "今日は自分で" モード切替: NFR-14
- **Share Card Generator**: PII / 状態ベクトル数値を含まないシェア用画像（風味記述 + Whisper 抜粋 + `#TheIdleCup`）を生成し、OS Share Sheet へ渡す（FR-06,07 の Whisper を消費、NFR-09 の append-only 監査と整合）

#### 主要 FR / NFR
- FR-01〜05, FR-10〜13（Console / Cup 表示・モード切替）
- FR-06, FR-07, FR-08（Share Card に同梱する Whisper 抜粋）
- NFR-09（共有時のログ append-only）, NFR-13（同時表示）, NFR-14（解除手段）

#### 主要技術
Phase 1: 静的プロトタイプ（HTML / Next.js）
Phase 2: React Native + Expo

---

## 3. データフロー（朝の典型）

```
05:30 ─ EventBridge Scheduler 起動（user.tz の wake-30min）
05:30 ─ Step Functions: U1 invoke
05:30 ─ U1: StateVector 構築
05:31 ─ Step Functions: U2 invoke
05:31 ─ U2: CupSelection（rationale_token のみ）
05:32 ─ Step Functions: U3 invoke
05:32 ─ U3: BrewSpec
05:32 ─ Step Functions: U4 invoke
05:32 ─ U4: IdleIndex
05:33 ─ U6 へ集約配信（push 通知 / SNS）
06:00 ─ ユーザー起床 / The Cup 表示
[user opens] ─ U6: Cup view
[long-press] ─ U6 → U5 invoke ─ Bedrock(Claude) ─ Whisper return
[Approve]    ─ U6 → U4 invoke (儀式完了 event)
```

---

## 4. コンポーネント間契約（Contract）

| 契約 | 提供側 | 消費側 | 形式 |
|---|---|---|---|
| StateVector | U1 | U2, U4, U5 | JSON Schema 定義（`construction/{unit}/contracts.md` に Phase 2 で配置） |
| CupSelection | U2 | U3, U5, U6 | 同上 |
| BrewSpec | U3 | U6 | 同上 |
| IdleIndex Result | U4 | U6 | 同上 |
| Whisper | U5 | U6 | テキスト + メタ |

---

## 5. 横断的関心事

| 関心事 | 配置 |
|---|---|
| 認証 / 認可 | API Gateway + Cognito（Phase 2 で詳細） |
| ロギング / 監査 | CloudWatch + audit.md（不変ログ） |
| エラー処理 | Step Functions retry + DLQ |
| Guardrails | U5 のみ（Bedrock Guardrails） |
| Property-based testing | testing/property-based 拡張で Construction phase 適用 |

---

## 6. Phase 2 で追加されるコンポーネント

| 候補 | 役割 |
|---|---|
| **U7: Discovery Connector** | 焙煎所提携データの取り込み |
| **U8: Payment Adapter** | Amazon Pay 統合（単発・Recurring） |
| **U9: Voice Surface** | Alexa Skill |
| **U10: Living Spec Synchronizer** | spec ↔ code 同期 CI |

---

## 7. 関連ドキュメント

| 観点 | 参照先 |
|---|---|
| Requirements | [`../requirements/requirements.md`](../requirements/requirements.md) |
| User Stories | [`../user-stories/stories.md`](../user-stories/stories.md) |
| AWS Architecture | [`./aws-architecture.md`](./aws-architecture.md) |
| Construction Plan | [`../../construction/plans/construction-plan.md`](../../construction/plans/construction-plan.md) |
| Intent | [`./intent.md`](./intent.md) |

---

*Components 設計は Construction Phase の Per-Unit Loop の入力となる。*
