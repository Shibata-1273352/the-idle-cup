# Requirements — The Idle Cup

> **役割**: Intent を機能要件 / 非機能要件に分解し、設計と検証の根拠とする。
> **読者**: チーム / 審査員 / Phase 2 の協業先
> **準拠**: AI-DLC v0.1.8 `inception/requirements/requirements.md` 配置規約

---

## 0. Intent Analysis Summary

| 項目 | 値 |
|---|---|
| **User Request** | AWS Summit Japan 2026 AI-DLC ハッカソン応募作品「人をダメにするサービス」を AI-DLC v0.1.8 公式ワークフローに準拠して構想する |
| **Request Type** | New Project (Greenfield) |
| **Scope** | System-wide / Cross-system（推論基盤・UI・Discovery 物販を視野） |
| **Initial Complexity** | Complex（多層の倫理的制約 / Phase 2 拡張領域 / 審査基準への直接寄与） |
| **Requirements Depth** | Standard（ハッカソン Inception スコープでは Comprehensive まで踏み込まない） |

詳細な intent は [`../application-design/intent.md`](../application-design/intent.md) を参照。

---

## 1. 機能要件 (FR)

### 1.1 The Cup — 説明なき一杯（コア体験）

| ID | 要件 | 優先度 |
|---|---|---|
| FR-01 | システムはユーザーごとに **1日1回**、朝の起床想定時刻に「今朝の一杯」を提示する | Must |
| FR-02 | 提示される一杯は、**豆（産地・農園・処理）/ 焙煎度 / 抽出温度 / 抽出時間 / 抽出量** を一意に決定する | Must |
| FR-03 | 初期表示には選定理由・推論経路を **表示しない**（説明なき承認のため） | Must |
| FR-04 | ユーザーは一杯を **承認 / 棄却 / 詳細表示** の3択から選択できる | Must |
| FR-05 | 棄却時、システムは代替を 1 つだけ提示する（無限選択を回避） | Should |

### 1.2 Confirmation Whisper — 説明可能性

| ID | 要件 | 優先度 |
|---|---|---|
| FR-06 | カップ画面の **長押し（≥1.5秒）** で Whisper を表示する | Must |
| FR-07 | Whisper は内部推論をそのまま表示せず、**ユーザー向けに短く詩的に再構成された自然言語** で提示する | Must |
| FR-08 | Whisper は 80〜200 文字に収める（読了負荷の最小化） | Should |
| FR-09 | Whisper はユーザーの個人データ（睡眠 / 天気 / 予定）を **直接的に開示せず**、参照は丸めて表現する（「昨夜の眠りは浅く」程度） | Must |

### 1.3 Life Delegation Console — 余白と喪失の可視化

| ID | 要件 | 優先度 |
|---|---|---|
| FR-10 | システムは **Idle Index（余白指数）** と **Human Agency Remaining** を同時に表示する | Must |
| FR-11 | Idle Index は AI 委譲した判断数 / 当該ユーザーの基準判断数の比率として算出する | Must |
| FR-12 | Human Agency Remaining はユーザーが手動で行った判断数を保持し、**減少を欠陥として描画しない** | Must |
| FR-13 | 「今日あなたが自分で決めたこと」を 1 行リストとして提示する | Should |

### 1.4 User State Estimator — 起床前の文脈推定

| ID | 要件 | 優先度 |
|---|---|---|
| FR-14 | システムは起床推定時刻の 30〜60 分前に、ユーザーの **状態ベクトル** を構築する | Must |
| FR-15 | 状態ベクトルは少なくとも以下を含む: 睡眠（quantified self 連携 or 自己申告） / 当日の予定（カレンダー） / 天候 / 直近の好み履歴 | Must |
| FR-16 | 状態推定は **PII の最小化原則** に従い、識別子は擬似匿名化して保存する | Must |

### 1.5 Coffee Selection Engine — 一杯の選定

| ID | 要件 | 優先度 |
|---|---|---|
| FR-17 | システムは状態ベクトルから、豆データベースの中から **唯一の一杯** を選定する | Must |
| FR-18 | 選定は確率的多様性を確保しつつ、ユーザーの過去 7 日間の選択分布から逸脱しすぎないよう制約する | Should |
| FR-19 | 選定不能（在庫切れ等）時は、フォールバック戦略を `operations/` で定義する | Should |

### 1.6 Brewing Parameter Generator — 抽出パラメータ

| ID | 要件 | 優先度 |
|---|---|---|
| FR-20 | 選定された豆に対し、**温度 / 時間 / 比率（豆 g : 水 g）** を生成する | Must |
| FR-21 | 生成は焙煎度・処理方法に応じた業界標準レシピを基準値とし、ユーザー嗜好で ±10% 以内で調整する | Should |

### 1.7 Idle Index Calculator

| ID | 要件 | 優先度 |
|---|---|---|
| FR-22 | 当日の AI 委譲判断数と手動判断数を集計し、Idle Index を算出する | Must |
| FR-23 | 集計は**朝の Cup 提示後に固定**され、夜まで再計算しない（不安定さを排除） | Should |

---

## 2. 非機能要件 (NFR)

### 2.1 性能

| ID | 要件 |
|---|---|
| NFR-01 | The Cup の朝の提示は、ユーザーの起床推定時刻 ±5 分以内に完了する |
| NFR-02 | 長押し検知から **1.5 秒以内**にローディング表示開始 + フェードイン。Whisper 本文は **token streaming** で順次描画する（on-demand Bedrock 呼び出しの完了待ちで沈黙させない） |
| NFR-03 | 状態推定 → 選定 → パラメータ生成のパイプラインは ≤30 秒（朝のスパイク時で測定） |

### 2.2 可用性

| ID | 要件 |
|---|---|
| NFR-04 | 朝の提示時間帯（ユーザー個別タイムゾーン 5:00〜10:00）の可用性は **99.9%** |
| NFR-05 | 選定エンジンが利用不能な場合、**直近 7 日間で最も承認された一杯** を fallback として提示 |

### 2.3 セキュリティ・プライバシー

| ID | 要件 |
|---|---|
| NFR-06 | PII（カレンダー本文、睡眠生データ）は **アプリ層では保持せず**、状態ベクトルへの集約値のみ保管 |
| NFR-07 | Whisper 生成のためのプロンプトは **PII を含まない正規化形式** で送信する |
| NFR-08 | Bedrock Guardrails を有効化し、Whisper のトーン制御・PII 漏洩抑止を行う |
| NFR-09 | 監査ログ（`audit.md` および運用 CloudTrail）は **append-only** とする |

### 2.4 拡張性

| ID | 要件 |
|---|---|
| NFR-10 | Phase 2 で Amazon Pay / SP-API / FBA / Alexa を追加する設計余地を維持する |
| NFR-11 | Discovery 物販導線は、現在の選定 Unit に依存しないアダプタを通じて拡張可能とする |

### 2.5 倫理・透明性

| ID | 要件 |
|---|---|
| NFR-12 | Whisper はユーザーが**いつでもアクセス可能**であり、デフォルトで非表示とする選択は提供しない（説明可能性は常時担保） |
| NFR-13 | Idle Index と Human Agency は**同時表示**し、片方のみの表示モードを提供しない |
| NFR-14 | ユーザーが委譲を一時停止する手段（"今日は自分で選ぶ"）を必ず提供する |

### 2.6 観測性

| ID | 要件 |
|---|---|
| NFR-15 | 各 Unit は CloudWatch メトリクスを発行する |
| NFR-16 | パイプラインの分散トレースは X-Ray で取得する |
| NFR-17 | ユーザーレベルの Idle Index 分布を匿名化集計で観測する（Phase 2） |

---

## 3. データ要件

| データ種別 | 保管場所 | 規約 |
|---|---|---|
| ユーザープロファイル（嗜好・委譲設定） | DynamoDB | 暗号化、ユーザー削除に追従 |
| 状態ベクトル（朝のスナップショット） | DynamoDB（短期 TTL: 24h） | PII を含まない集約値のみ |
| 抽出履歴 | S3 + Athena | 集計分析専用、PII 非含 |
| 豆カタログ | DynamoDB / S3 | 焙煎所提携データを正規化 |
| Whisper コーパスログ | S3（Bedrock 入出力サンプリング） | サンプリング率 ≤1%、Guardrail 違反は別途集約 |
| audit.md（不変ログ） | リポジトリ管理 | append-only、検証可能 |

---

## 4. 制約

- 提出時点ではフロントエンドは UI モック / 静的プロトタイプで可（決勝で動作デモ）
- Phase 1 では Amazon Pay / SP-API / FBA / Alexa は **設計済 / 未実装**
- Mob Construction は本プロジェクトでは Solo + retroactive で実施、real-time 化は Phase 2

---

## 5. 受け入れ基準（Inception 段階の Done）

- [x] 本書 (`requirements.md`) が存在し、FR / NFR が一意 ID で参照可能
- [x] [`../user-stories/stories.md`](../user-stories/stories.md) と相互参照可能
- [x] [`../application-design/components.md`](../application-design/components.md) で各 FR がコンポーネントへ割り当てられる
- [x] [`../application-design/aws-architecture.md`](../application-design/aws-architecture.md) で各 NFR が AWS サービス選択へ反映される
- [x] [`../../construction/plans/construction-plan.md`](../../construction/plans/construction-plan.md) で Unit 分解と要件 ID の対応表が存在する

---

## 6. Extension Configuration（参考）

| Extension | Enabled | 決定箇所 |
|---|---|---|
| security/baseline | 部分採用（NFR-06〜09 に反映） | Requirements Analysis |
| testing/property-based | 採用（Construction で property test を要請） | Requirements Analysis |
| meta/self-reference | 採用（独自拡張） | 採用判断 Q（2026-05-04） |
| meta/methodology-honesty | 採用（独自拡張） | 採用判断 Q（2026-05-04） |
| business/business-intent | 採用（独自拡張） | 採用判断 Q（2026-05-04） |
| demo/demo-scenario | 採用（独自拡張） | 採用判断 Q（2026-05-04） |

---

*要件は `audit.md` の意思決定に追従し、変更時は対応する FR/NFR ID を update する。*
