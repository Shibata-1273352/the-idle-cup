# AWS Architecture — The Idle Cup

> **役割**: コンポーネント設計を AWS マネージドサービスに具体化し、性能 / セキュリティ / コスト / 運用観点を確定する。
> **準拠**: AI-DLC v0.1.7 `inception/application-design/aws-architecture.md` 配置規約
> **読者**: チーム / 審査員（AWS 上での開発・稼働の評価軸）/ Phase 2 の SRE

---

## 1. アーキテクチャ図（Phase 1: 提出時点 / Phase 2: 設計済）

### 1.1 Phase 1 — Inception 評価のための最小構成

```
┌──────────────────────────────────────────────────────────────────┐
│                         AWS Account (sandbox)                     │
│                                                                   │
│   ┌────────────────┐                                              │
│   │  EventBridge   │                                              │
│   │  Scheduler     │ ── per user TZ trigger ──┐                   │
│   └────────────────┘                          │                   │
│                                               ▼                   │
│   ┌──────────────────────────────────────────────────────────┐    │
│   │  AWS Step Functions (Standard Workflow)                  │    │
│   │   ─ U1 ─▶ U2 ─▶ U3 ─▶ U4 ─▶ U6 (notification)           │    │
│   └──────────────────────────────────────────────────────────┘    │
│           │       │       │       │            │                  │
│           ▼       ▼       ▼       ▼            ▼                  │
│   ┌────────────────────────────────────────────────────────┐      │
│   │  AWS Lambda                                            │      │
│   │   U1 / U2 / U3 / U4 / U5 (on-demand by U6 long-press)  │      │
│   └────────────────────────────────────────────────────────┘      │
│           │                       │                               │
│           ▼                       ▼                               │
│   ┌──────────────┐    ┌──────────────────────────┐                │
│   │  DynamoDB    │    │  Amazon Bedrock          │                │
│   │  - profile   │    │  - Claude Sonnet 4.6     │                │
│   │  - state     │    │  - Bedrock Guardrails    │                │
│   │  - history   │    └──────────────────────────┘                │
│   │  - catalog   │                                                │
│   └──────────────┘                                                │
│                                                                   │
│   ┌──────────────┐    ┌──────────────────────────┐                │
│   │  S3          │    │  CloudWatch / X-Ray /     │               │
│   │  - logs      │    │  CloudTrail               │               │
│   │  - history   │    └──────────────────────────┘                │
│   └──────────────┘                                                │
└──────────────────────────────────────────────────────────────────┘
                              │
                              ▼
              ┌──────────────────────────────┐
              │  Web Prototype (Next.js)     │
              │  Hosted on Amplify / S3+CF   │
              └──────────────────────────────┘
```

### 1.2 Phase 2 — Discovery / Voice / Pay 拡張

```
                    [Phase 2 で追加されるサービス群]
   ┌──────────────────────────┐    ┌──────────────────────────┐
   │  Amazon Pay              │    │  Amazon SP-API / FBA      │
   │  (Recurring + 単発)      │    │  (物販 / 配送)            │
   └──────────────────────────┘    └──────────────────────────┘
                    │                            │
                    ▼                            ▼
   ┌────────────────────────────────────────────────────┐
   │  U7: Discovery Connector / U8: Payment Adapter     │
   │  (Lambda + EventBridge Pipes)                      │
   └────────────────────────────────────────────────────┘

   ┌──────────────────────────┐    ┌──────────────────────────┐
   │  Amazon Alexa Skill      │    │  Amazon QuickSight        │
   │  (U9: Voice Surface)     │    │  (Idle Index 集計可視化)  │
   └──────────────────────────┘    └──────────────────────────┘
```

---

## 2. サービス選択の根拠

| AWS サービス | Unit / 関心事 | 採用根拠 |
|---|---|---|
| **EventBridge Scheduler** | 朝の時刻トリガ | Cron + per-user タイムゾーン対応がネイティブ。Step Functions 起動が容易 |
| **Step Functions（Standard）** | Unit 間オーケストレーション | 失敗・再試行・分岐の宣言的記述。Express ではなく Standard を選び、長期実行と監査性を優先 |
| **Lambda** | U1〜U5 の実装 | サーバーレス前提。ピーク（朝の同時起動）に弾力性 |
| **Amazon Bedrock (Claude Sonnet 4.6)** | U5 Whisper 生成 | 詩的トーンの表現力とレスポンス速度。Anthropic 系のニュアンス再現 |
| **Bedrock Guardrails** | U5 のトーン / PII 制御 | プロンプト改ざん・PII 漏洩・押し付けトーンを抑止する宣言的ガードレール |
| **DynamoDB** | プロファイル / 状態 / 履歴 / カタログ | 単一桁ミリ秒レイテンシ、TTL（状態ベクトル 24h）が標準機能 |
| **S3 + Athena** | 抽出履歴 / Whisper サンプリング / 監査 | 安価な不変ストレージ。Athena で集計分析 |
| **CloudWatch** | メトリクス / ログ | NFR-15 |
| **X-Ray** | 分散トレース | NFR-16 |
| **CloudTrail** | API 監査 | NFR-09 と整合 |
| **Cognito** | 認証 | Phase 2 で本格適用 |
| **API Gateway** | フロント ↔ バックエンド | Cognito Authorizer 統合 |
| **Amplify Hosting / S3+CloudFront** | 静的プロトタイプ配信 | Phase 1 の demo 配信 |
| **EventBridge Pipes（Phase 2）** | Discovery 連携 | SP-API / 焙煎所フィードを宣言的に取り込む |
| **Amazon Pay（Phase 2）** | 物販決済 | Recurring + 単発に同じ SDK で対応 |
| **Amazon Alexa（Phase 2）** | 音声サーフェス | "Alexa, ask The Idle Cup what's today's cup" |
| **AWS CDK** | IaC | 全構成を TypeScript で宣言。`operations/` へ Phase 2 で配置 |

---

## 3. 性能設計

| 観点 | 設計 |
|---|---|
| **朝のスパイク** | 同時数千ユーザーが同時に起床 → EventBridge Scheduler のフリート分散 + Lambda の予約済み同時実行 |
| **Bedrock の同時呼び出し** | U5 は long-press 時のみ呼ぶため Cup 提示時には呼ばない設計（FR-03 と整合） |
| **状態ベクトル構築（NFR-03）** | U1 のステートレス化 + DynamoDB Single-Table Design |
| **Step Functions の cold start** | Standard Workflow で許容（朝の通知は ±5 分の余裕、NFR-01） |

---

## 4. セキュリティ / プライバシー

### 4.1 PII 取り扱い

| データ | 保管 | 暗号化 | TTL |
|---|---|---|---|
| カレンダー本文 | **保管しない**。U1 内で集約値（schedule_density）にのみ変換 | - | - |
| 睡眠生データ | 同上 | - | - |
| 状態ベクトル | DynamoDB | KMS | 24h |
| 抽出履歴 | DynamoDB / S3 | KMS / SSE-KMS | 90 日（Phase 1）/ 設定可（Phase 2） |
| Whisper コーパス | S3（サンプリング ≤1%） | SSE-KMS | 30 日 |

### 4.2 ネットワーク

- すべての Lambda は VPC 不要（外部 API は AWS PrivateLink で Bedrock のみ）
- 外部カレンダー API は Lambda + Secrets Manager のトークン管理

### 4.3 IAM

- Unit ごとに最小権限ロール（U1 ロールは Bedrock 不要、U5 ロールは DynamoDB 書き込み不要）
- audit.md の append-only 性は CloudTrail + S3 Object Lock で技術的に強化（Phase 2）

### 4.4 Bedrock Guardrails

- U5 専用の Guardrail を構成: PII フィルタ / 医療助言の検出 / 押し付けトーンの拒否
- Guardrail 違反は別 S3 prefix に集約し、ハッカソン審査時にエビデンスとして提示可能

---

## 5. 観測性 / 運用

### メトリクス（CloudWatch）
- `cup_proposed_count` / `cup_approved_count` / `cup_rejected_count`
- `whisper_invoked_count`
- `idle_index_p50` / `human_agency_remaining_p50`
- `pipeline_duration_seconds`（U1〜U4 の合計）

### ダッシュボード
- Phase 1: CloudWatch Dashboard 1 枚
- Phase 2: QuickSight に展開、`extensions/business/business-intent.md` の KPI と直結

### アラーム
- `pipeline_duration_seconds > 60s`
- `bedrock_throttled` 発生
- `guardrail_violation_count > 0`

---

## 6. コスト試算（Phase 1 / 月）

| サービス | 想定 | 月額（USD, 概算） |
|---|---|---|
| Lambda | 1 ユーザー / 日 5 回 × 1k ユーザー × 30 日 | < 5 |
| DynamoDB | On-demand, 平均 10k RCU/WCU | ~10 |
| Bedrock (Claude) | Whisper 100ms × 1k tokens × 1k 呼び出し / 日 | ~30〜50 |
| S3 | 1 GB / 月 | < 1 |
| Step Functions | 1k 実行 / 日 × Standard | ~5 |
| CloudWatch / X-Ray / CloudTrail | 標準 | ~5 |
| **合計** | | **~$60〜80 / 月** |

Phase 1 のハッカソン demo 範囲では数 USD 程度に収まる見込み。

---

## 7. 障害 / 災害復旧

| シナリオ | 対応 |
|---|---|
| Bedrock 障害 | U5 fallback（静的テキスト）/ U1〜U4 は機能継続 |
| DynamoDB 部分障害 | Read replica へフォールバック（Phase 2: Global Tables 評価） |
| Step Functions 失敗 | DLQ + EventBridge Replay |
| 朝の通知不能 | UI 起動時の遅延フェッチで補完 |

---

## 8. NFR 紐付け

| NFR | 該当箇所 |
|---|---|
| NFR-01（朝の提示 ±5 分） | EventBridge Scheduler + Step Functions |
| NFR-02（Whisper 1.5 秒） | Bedrock + UI prefetch トークン |
| NFR-03（パイプライン ≤30 秒） | Lambda + DynamoDB Single-Table |
| NFR-04（99.9% 可用性） | Step Functions + Lambda + DynamoDB の単一リージョン構成（Phase 2 で multi-region） |
| NFR-05（選定エンジン障害時の fallback） | DynamoDB に永続化された「直近 7 日間で最も承認された一杯」を Step Functions の Catch ブランチから読み出し、U6 へ提示 |
| NFR-06〜09（PII / Guardrails / 監査） | §4 |
| NFR-10〜11（拡張性） | §1.2 / §2 EventBridge Pipes |
| NFR-12（Whisper の常時アクセス可能性 / 非表示モード非提供） | U5 を Bedrock 直結の独立 Lambda として常時呼び出し可能化、UI 側に Whisper 非表示の toggle を実装しない設計（U6 / Bedrock Guardrails の併用で開示トーンも担保） |
| NFR-13（同時表示）/ NFR-14（解除手段） | UI（U6）責務 |
| NFR-15〜17（観測性） | §5 |

---

## 9. 関連ドキュメント

| 観点 | 参照先 |
|---|---|
| Components | [`./components.md`](./components.md) |
| Requirements | [`../requirements/requirements.md`](../requirements/requirements.md) |
| Construction Plan | [`../../construction/plans/construction-plan.md`](../../construction/plans/construction-plan.md) |
| Operations | [`../../operations/README.md`](../../operations/README.md) |

---

*アーキテクチャは Phase 2 の CDK 化と並行して update される生きた文書である。*
