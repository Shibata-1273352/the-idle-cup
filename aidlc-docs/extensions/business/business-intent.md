# Business Intent — The Idle Cup as Discovery Platform

> **役割**: The Idle Cup を一発芸の作品ではなく、**継続的に運用可能な事業構造**として定義する。
> **読者**: ハッカソン審査員（事業性の評価軸）/ Phase 2 で参画する協業先 / 投資検討者
> **配置根拠**: 公式 v0.1.8 階層では business 文書はオプショナル。本作品は事業性を主張するため `extensions/business/` に独自配置。

---

## 1. 事業仮説の一文

> **The Idle Cup は、ユーザーの「説明なき承認の儀式」を起点に、コーヒー豆・焙煎機・周辺消耗品・ライフスタイル全般の発見と購買を駆動する Discovery Platform である。**

---

## 2. なぜ Discovery Platform か

### 2.1 既存 EC / レコメンドの構造的な敗北

| 既存の発見手段 | 限界 |
|---|---|
| Amazon の「あなたへのおすすめ」 | 履歴が偏ると同質化、新規発見性が低下 |
| Instagram / TikTok 経由の発見 | アテンションを奪うコストが大きく、購買承認まで遠い |
| サブスク（コーヒー定期便） | カスタマイズの自由度が判断疲労を呼ぶ |
| 専門店の店員推薦 | スケールしない、地域依存 |

### 2.2 The Idle Cup の優位性

- **承認時刻が固定**: 朝。ユーザーが最も判断容量を空けたい瞬間に、説明なく一杯が届く
- **承認単位が極小**: 「Yes / No / Whisper を見る」の三択
- **承認後の儀式**: 抽出という身体行為が記憶を強化し、購買への信頼が積み上がる
- **発見性は委譲側にある**: ユーザーが探さない代わりに、AI が産地・焙煎・抽出の組み合わせ空間を踏破する

> 結論: The Idle Cup は **「探さないユーザー」 × 「踏破する AI」** という非対称構造によって、既存 EC レコメンドが届かなかった発見の質を達成する。

---

## 3. 顧客セグメント

| セグメント | 規模感（仮説） | 鍵となる文脈 |
|---|---|---|
| **A: 知的労働の意思決定者**（経営者・PM・研究者） | 中 | 決定疲労が業務の質を直接侵食する。朝の判断削減の単価が高い |
| **B: AI ネイティブ世代**（20-30代の AI ヘビーユーザー） | 大 | AI に委譲することへの心理的抵抗が低い。委譲の美学への共感 |
| **C: 養生・ウェルネス層** | 中 | 「気分を整える一杯」の文脈で受容。Confirmation Whisper の詩的体験が刺さる |
| **D: コーヒー好きの探検者**（既存ロースター愛好家） | 小 | 「自分で選ぶ楽しみを奪うのか」という反発もありうるが、**Whisper を介して発見の物語に接続** |

優先順位は **A → B → C → D**。A の単価と離脱コストが最も高く、課金転換が早い。

---

## 4. 収益モデル

### 4.1 Phase 1（ハッカソン提出時点 / 設計済）

| 収益源 | 仕組み | 単価仮説 |
|---|---|---|
| **サブスクリプション（個人）** | 朝の一杯の選定 + 配送（豆 or ドリップバッグ） | 月 ¥3,000〜¥6,000 |
| **サブスクリプション（Pro）** | 上記 + Confirmation Whisper の高品質化 + 抽出パラメータの個別最適化 | 月 ¥9,000〜¥15,000 |

### 4.2 Phase 2（設計済 / 未実装）

| 収益源 | 仕組み |
|---|---|
| **Discovery 連動の物販** | The Cup で選ばれた豆の単発購入導線（Amazon Pay / Recurring Payment） |
| **B2B Workspace ライセンス** | オフィス向けの「会議前の一杯」サービス |
| **データ協業** | 焙煎所への匿名化された嗜好トレンド提供（オプトイン） |
| **抽出器具・周辺機器** | Alexa / FBA 経由の物理体験統合 |

### 4.3 Unit Economics の仮説

- 平均月額 ¥4,500 × 解約率 6%/月 → LTV ≒ ¥75,000
- CAC は B2C で ¥6,000 を許容 → CAC payback ≒ 2 ヶ月

> **数値の位置づけ（重要）**: 上記の ARPU・解約率・CAC は、Blue Bottle 系コーヒー定期便の公開 ARPU レンジ（¥3,000〜¥6,000/月）と一般的な D2C サブスクの解約率レンジ（5〜10%/月）から外挿した **審査用の仮説値であり、提出時点では検証未了** である。実測は Phase 2 の最初の 30 日で取得し、`operations/` に記録する。本書の Phase 1 における KPI 評価軸は §8 の Phase 1 KPI（Intent の共通言語化 / demo 体験の "違和感 + 安堵"）に置き、Phase 2 の経済性 KPI と段階分離する。

---

## 5. AWS とのアラインメント

### 5.1 なぜ AWS でなければならないか

| 要件 | AWS サービス |
|---|---|
| 個別パーソナライズの推論基盤 | Amazon Bedrock |
| 朝の時刻同期トリガ（個別タイムゾーン） | Amazon EventBridge Scheduler |
| Unit 間オーケストレーション | AWS Step Functions |
| ユーザーごとの状態 | Amazon DynamoDB |
| 抽出履歴・嗜好の長期保管 | Amazon S3 + Athena |
| Whisper の生成 | Amazon Bedrock (Claude) |
| 観測性 | CloudWatch / X-Ray / CloudTrail |
| 物販導線（Phase 2） | Amazon Pay / SP-API / FBA |
| 音声体験（Phase 2） | Amazon Alexa |

### 5.2 AWS 単独では完結しない領域

- 焙煎所との豆データ提携（外部 API / scrape の合意済みフィード）
- 配送オペレーション（FBA + パートナー物流）
- 決済（Amazon Pay は採用しつつ Stripe 等の代替も Phase 2 で評価）

---

## 6. 競合・差別化

| 既存サービス | 差分 |
|---|---|
| Blue Bottle 定期便 | カスタマイズ前提・選択疲労が残る |
| Bean Box / Mistobox | レコメンド精度勝負・物語性が弱い |
| Spotify Daylist 等の音楽パーソナライズ | 同種の「説明しない発見」モデルだが朝に焦点を置かない |
| ChatGPT / Claude 等の汎用 AI | アシスタントとしての対話を要求し、判断疲労を温存する |

The Idle Cup は **「対話を要求しない発見」** において独自のポジションを取る。

---

## 7. リスクと対応

| リスク | 緩和策 |
|---|---|
| 「コーヒーが題材だと市場が小さい」 | コーヒーは題材。Phase 2 で同構造を朝食・服・ニュースに展開 |
| 「AI 委譲倫理への批判」 | Whisper / Idle Index / Human Agency の三層で説明可能性と自由を担保 |
| 「物流オペレーションの難易度」 | 焙煎所提携前提。私たちは選定 IP を持ち、物流は提携先に委ねる |
| 「Amazon Pay / SP-API 等の依存」 | Stripe / Shopify 代替を Phase 2 で評価。Amazon 依存はロックインではなく **加速のための選択** |

---

## 8. KPI（Phase 1 / Phase 2）

### Phase 1（提出時点）
- Intent の一文が共通言語になっているか（チームと審査員）
- demo-scenario.md の体験が "違和感 + 安堵" を生むか

### Phase 2
- DAU / 朝の Cup 提示開封率
- Whisper 開示率（あえて低く保つ KPI 設計）
- Idle Index の中央値
- Discovery 経由の物販 GMV
- 解約率（≦ 6%/月）

---

## 9. 関連ドキュメント

| 観点 | 参照先 |
|---|---|
| Intent | [`../../inception/application-design/intent.md`](../../inception/application-design/intent.md) |
| デモシナリオ | [`../demo/demo-scenario.md`](../demo/demo-scenario.md) |
| 作品⇔開発の同型 | [`../meta/self-reference.md`](../meta/self-reference.md) |
| AWS アーキテクチャ | [`../../inception/application-design/aws-architecture.md`](../../inception/application-design/aws-architecture.md) |

---

*本書は事業性の主張文書であり、Phase 2 で更新される生きた文書として扱う。*
