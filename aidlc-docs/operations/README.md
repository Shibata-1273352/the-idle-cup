# Operations Phase — Phase 2 Placeholder

本フェーズは AWS Summit Japan 2026 AI-DLC ハッカソン提出時点では **Phase 2 / Designed** として扱う。

---

## 公式 v0.1.7 における Operations の状態

公式 `awslabs/aidlc-workflows` v0.1.7 においても Operations は **placeholder 扱い**（リリース時点で核心機能が未実装）。本プロジェクトもその段階に追従する。

---

## Phase 2 で実装予定のスコープ

| 領域 | 実装計画 |
|---|---|
| **IaC** | AWS CDK で 6 Units のインフラを宣言的に管理 |
| **Observability** | CloudWatch / X-Ray / CloudTrail を介した観測性 |
| **Guardrails** | Bedrock Guardrails の運用統合（PII マスキング、トーン制御） |
| **Deployment** | EventBridge による朝のトリガ、Step Functions による Unit 間オーケストレーション |
| **External Integration** | Amazon Pay (Recurring Payment) / SP-API / FBA / Alexa |
| **Compliance** | PCI-DSS スコープ判定、SOC 2 / ISO 27001 マッピング |

---

## 関連ドキュメント

- [`../inception/application-design/aws-architecture.md`](../inception/application-design/aws-architecture.md) — Operations を見据えた設計
- [`../audit.md`](../audit.md) — Phase 2 移行時に新しい Bolt として記録される

---

*Operations stage 開始時に本ファイルは `operations/{plans, deployment, monitoring}/` 等の階層に展開される予定。*
