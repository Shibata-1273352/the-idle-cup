# Construction Plan — Unit Decomposition for The Idle Cup

> **役割**: Inception の成果（要件 / ストーリー / コンポーネント）を 6 つの Unit of Work に分解し、Construction Phase の per-unit loop の進行表とする。
> **準拠**: AI-DLC v0.1.8 `construction/plans/` 配置規約
> **読者**: 開発者 / メンタリング AI-DLC Champion / 審査員（Unit 分解の評価軸）

---

## 1. Unit 分解の方針

### 1.1 分解原則

| 原則 | 適用 |
|---|---|
| **一つの Unit は一つの責務** | U1〜U6 が単一の生成物を返す（StateVector / CupSelection / BrewSpec / IdleIndex / Whisper / UI） |
| **Unit 間の契約はデータで固定** | コンポーネント図と JSON Schema で契約を明示 |
| **失敗時の代替が Unit 内に閉じる** | Bedrock 障害 → U5 fallback、状態欠損 → U1 中立ベクトル |
| **観測点が Unit 単位で揃う** | CloudWatch メトリクスは Unit 別に発行 |
| **テスト可能性が Unit 単位で確立する** | property-based test を Unit 単位で適用（採用拡張） |

### 1.2 6 Unit が "正しい数" である根拠

- Bedrock を呼ぶ Unit は U5 のみ（コスト・倫理境界）
- UI は U6 にすべて集約（ユーザー接点を一つに）
- 状態 → 選定 → パラメータ → 指標 の **線形 4 段** + UI（U6）+ on-demand 説明（U5）
- これ以上分解すると **小さすぎて結合度が上がる**、これ以下に集約すると **責務が肥大する**

---

## 2. Unit 一覧

| Unit | 名称 | 主要技術 | 主要 FR/NFR | 依存 |
|---|---|---|---|---|
| **U1** | User State Estimator | Lambda + DynamoDB + 外部 API | FR-14〜16, NFR-06 | - |
| **U2** | Coffee Selection Engine | Lambda + DynamoDB | FR-17〜19, NFR-15 | U1 |
| **U3** | Brewing Parameter Generator | Lambda | FR-20, FR-21 | U2 |
| **U4** | Idle Index Calculator | Lambda + DynamoDB | FR-10〜13, FR-22, FR-23 | U2 |
| **U5** | Confirmation Whisper | Bedrock + Lambda | FR-06〜09, NFR-08, NFR-12 | U1, U2 |
| **U6** | Life Delegation Console | Next.js + API Gateway | FR-01〜05, NFR-13, NFR-14 | U2, U3, U4, U5 |

---

## 3. Unit 別 Construction フロー

各 Unit は Construction Phase の per-unit loop に従って進行する。

```
For each Unit Uk:
    1. Functional Design (CONDITIONAL)
    2. NFR Requirements (CONDITIONAL)
    3. NFR Design (CONDITIONAL)
    4. Infrastructure Design (CONDITIONAL)
    5. Code Generation (ALWAYS)
       ├ Part 1: Plan
       └ Part 2: Generate
After all Units:
    6. Build and Test (ALWAYS)
```

### 3.1 U1: User State Estimator

| Stage | Execute? | 備考 |
|---|---|---|
| Functional Design | ✅ | 状態ベクトルの数理（schedule_density / sleep_quality 集約関数）を定義 |
| NFR Requirements | ✅ | NFR-06（PII 最小化）/ NFR-15（メトリクス） |
| NFR Design | ✅ | 集約関数の純粋性 / DynamoDB TTL 24h |
| Infrastructure Design | ✅ | Lambda + DynamoDB + 外部 API トークン（Secrets Manager） |
| Code Generation | ✅ | TypeScript / AWS SDK v3 |

### 3.2 U2: Coffee Selection Engine

| Stage | Execute? | 備考 |
|---|---|---|
| Functional Design | ✅ | DPP 近似 vs Top-K + diversity reweighting の選択 |
| NFR Requirements | ✅ | NFR-04（可用性）/ NFR-05（fallback） |
| NFR Design | ✅ | 在庫切れ時のフォールバック設計 |
| Infrastructure Design | ✅ | Lambda + DynamoDB |
| Code Generation | ✅ | 選定アルゴリズムの property-based test 重点 |

### 3.3 U3: Brewing Parameter Generator

| Stage | Execute? | 備考 |
|---|---|---|
| Functional Design | ✅ | ルールベースの基準値表 |
| NFR Requirements | ⏭ skip | 単純算術のみ |
| NFR Design | ⏭ skip | 同上 |
| Infrastructure Design | ⏭ skip | 同上（Lambda 単独） |
| Code Generation | ✅ | テーブル駆動 + property test |

### 3.4 U4: Idle Index Calculator

| Stage | Execute? | 備考 |
|---|---|---|
| Functional Design | ✅ | 集計ウィンドウ定義（朝固定 → 夜まで不変、FR-23） |
| NFR Requirements | ✅ | NFR-13（同時表示）/ NFR-14（解除） |
| NFR Design | ✅ | 履歴未確立時のニュートラル値 |
| Infrastructure Design | ⏭ skip | Lambda 単独 |
| Code Generation | ✅ | property test 重点（不安定挙動の検出） |

### 3.5 U5: Confirmation Whisper

| Stage | Execute? | 備考 |
|---|---|---|
| Functional Design | ✅ | プロンプト構造 / トーン定義 / 文字数制約 |
| NFR Requirements | ✅ | NFR-08（Guardrails）/ NFR-12（常時アクセス） |
| NFR Design | ✅ | Guardrail 設定 / fallback / サンプリング |
| Infrastructure Design | ✅ | Bedrock + IAM 最小権限 |
| Code Generation | ✅ | プロンプト境界の単体テスト + Guardrail バイパス試験 |

### 3.6 U6: Life Delegation Console

| Stage | Execute? | 備考 |
|---|---|---|
| Functional Design | ✅ | 画面遷移図 / コンポーネント構造 |
| NFR Requirements | ✅ | NFR-13, NFR-14, ユーザビリティ |
| NFR Design | ✅ | 長押し検知 1.5 秒 / アクセシビリティ |
| Infrastructure Design | ✅ | Amplify / S3+CloudFront 配信 |
| Code Generation | ✅ | Next.js + Storybook |

---

## 4. Build and Test 計画

### 4.1 ビルド
- 各 Unit Lambda: `esbuild` で TypeScript → JS へ
- U6 Web: Next.js production build
- IaC: AWS CDK synth → cloudformation テンプレート

### 4.2 テスト戦略

| テスト種別 | 対象 | ツール |
|---|---|---|
| Unit | U1〜U5 各関数 | Jest |
| Property-based | U2 (DPP 制約) / U3 (パラメータ範囲) / U4 (Idle Index 不変性) | fast-check |
| Integration | Step Functions 実行 / Bedrock Mock / DynamoDB Local | aws-sdk-client-mock |
| E2E | U6 → API → Step Functions → DynamoDB | Playwright |
| Guardrail | U5 のプロンプトインジェクション耐性 | 専用シナリオ集 |
| Performance | NFR-03 / NFR-04 検証 | k6 / artillery |

### 4.3 CI/CD
- GitHub Actions（Phase 2 で本格化）
- Phase 1 ではローカル `npm test` + 手動 deploy

---

## 5. 受け入れ基準（Construction 段階の Done）

- [ ] 各 Unit の Functional Design が `aidlc-docs/construction/{unit-name}/functional-design/` に配置されている
- [ ] 適用該当 Unit の NFR Requirements / NFR Design が配置されている
- [ ] U1, U2, U5, U6 の Infrastructure Design が配置されている
- [ ] 各 Unit の Code Generation Plan + 実装サマリが `aidlc-docs/construction/{unit-name}/code/` に配置されている
- [ ] Build and Test instructions が `aidlc-docs/construction/build-and-test/` に配置されている
- [ ] すべての Unit の `aidlc-state.md` 進捗が ✅ Complete になる
- [ ] property-based test が U2 / U3 / U4 で green

---

## 6. 進捗トラッカー（Phase 1 / Phase 2）

| Unit | Phase 1 (提出時点) | Phase 2 (予選〜決勝) |
|---|---|---|
| U1 | 設計 ✅ / 実装 ⏸ | 実装 + Apple Health 統合 |
| U2 | 設計 ✅ / 実装 ⏸ | 実装 + DPP 評価 |
| U3 | 設計 ✅ / 実装 ⏸ | 実装 + 嗜好補正 |
| U4 | 設計 ✅ / 実装 ⏸ | 実装 |
| U5 | 設計 ✅ / 実装 ⏸ | 実装 + Guardrail 構成 |
| U6 | 設計 ✅ / モック ⏸ | 実装 + Storybook + デモ |

提出時点（Phase 1）では Inception 完了 + Construction の **設計済**（実装は Phase 2）。これは AWS Summit Japan 2026 AI-DLC ハッカソンの書類審査要件（Inception 成果物）に対する適合形である。

---

## 7. リスクと緩和

| リスク | 緩和 |
|---|---|
| Bedrock のトーン制御が思うように効かない | Guardrail 違反パターンを集約し、Iteration 1 で再調整 |
| 朝の同時起動による Lambda スロットル | Provisioned Concurrency を Phase 2 で評価 |
| 焙煎所提携データの欠落 | 公開データ + 同意済フィードのハイブリッドで Phase 1 はモック |
| 提出締切までの時間制約 | 設計成果物に集中、実装は Phase 2 |

---

## 8. 関連ドキュメント

| 観点 | 参照先 |
|---|---|
| Components | [`../../inception/application-design/components.md`](../../inception/application-design/components.md) |
| AWS Architecture | [`../../inception/application-design/aws-architecture.md`](../../inception/application-design/aws-architecture.md) |
| Requirements | [`../../inception/requirements/requirements.md`](../../inception/requirements/requirements.md) |
| User Stories | [`../../inception/user-stories/stories.md`](../../inception/user-stories/stories.md) |
| Operations | [`../../operations/README.md`](../../operations/README.md) |

---

*Construction Plan は per-unit loop 中に各 Unit の進捗に応じて update される。*
