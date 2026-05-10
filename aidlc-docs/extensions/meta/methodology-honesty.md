# Methodology Honesty — Retroactive Bolt Reconstruction

> **本書の目的**: AI-DLC のリアルタイム Mob 合議原則と本プロジェクトの実態の乖離を、隠さず明示する。
> **位置づけ**: 本プロジェクトの方法論的姿勢の宣言文書。
> **配置根拠**: 採用判断 Q4「明示し retroactive を勝負とする」（2026-05-04）の実装。

---

## 1. 事実の明示

本プロジェクトの Bolt 単位ログ（**Phase 1 では `audit.md` 本文のみが実体**。`extensions/meta/bolts/` 配下の Bolt 単位ビュー実装は §5 のとおり Phase 2 配置予定）の **2026-05-04 以前のエントリは、retroactive に再構成された**。

具体的には：

- リアルタイム **Mob Elaboration / Mob Construction を実施せずに**開発が進行した
- 各意思決定は**後付けで** `audit.md` に記録された
- 「AI 提案 → 人間承認」の構造は事実だが、その粒度・タイミングは公式 AI-DLC が想定する **3〜5 日連続の Mob Construction** とは一致しない
- 公式が要求する **5〜7 名のクロスファンクショナル・チーム同席**の前提も満たしていない

---

## 2. それでも本プロジェクトが AI-DLC 準拠を主張できる根拠

### 2.1 構造の同型性は時間軸とは独立に検証可能

AI-DLC の本質は kiakiraki 氏（Zenn, 2026）が論じた **"Extreme Decision-Making via Mob Work"** にある。本プロジェクトは Mob 形式こそ採らなかったが、各意思決定が **「AI 提案・人間承認」の対構造**を持つことは事後検証可能である。

`audit.md` のエントリ群はこの構造の retroactive な証拠であり、**構造的同型性は時間軸とは独立に成立する**。

### 2.2 公式 10 原則のうち、retroactive で満たせるものは保持

| 原則 | retroactive 適合 | 補足 |
|---|---|---|
| Principle 1: Reimagine Rather Than Retrofit | ✅ | retroactive 再構成自体が SDLC の reimagine |
| Principle 10: No Hard-Wired Workflows | ✅ | 適応的に audit を構成すること自体が原則の実装 |
| Mob 儀式に依存する原則 | ❌ 未達 | 明示的に "未達" として記録 |
| AI Powered Execution with Human Oversight | ✅ | 各 audit エントリで対応関係を確認可能 |
| Documentation as First-Class Citizen | ✅ | `aidlc-docs/` 階層が公式準拠 |

### 2.3 作品テーマとの整合 — 時間軸の入れ子

本プロジェクトの作品 *The Idle Cup* は「AI が判断を引き受けた**事後**に、人間に儀式が返ってくる」構造を主張する。

本書 `methodology-honesty.md` と `audit.md` の retroactive 構成は、その**「事後の儀式」自体の記録**であり、テーマと方法論の入れ子は **時間軸においても整合**する。

```
作品: AI が判断 → (時間経過) → 人間が一杯を承認・儀式
本プロジェクト: AI 駆動で実装 → (時間経過) → 人間が retroactive に audit を承認・儀式
```

retroactive であることは欠陥ではなく、**作品テーマの開発プロセスへの再帰**として読める。

---

## 3. 何をもって "勝負" するか

ハッカソン審査において、本プロジェクトは以下を主張する：

### 主張 1: 公式 v0.1.7 階層に厳密準拠
- Inception / Construction / Operations の 3 フェーズ
- `aidlc-state.md` / `audit.md` / `execution-plan.md` の必須3ファイル
- stage フォルダ命名規則の踏襲

### 主張 2: 方法論的乖離を隠さず明示
- 本書の存在自体が誠実性の証拠
- "production-grade" な数字を捏造せず、retroactive 事実を documentation で先回り開示

### 主張 3: retroactive 再構成こそが、AI 共生時代の現実的な SDLC 適用の起点である
- Wipro や東京海上日動システムズの Unicorn Gym のような **「AWS SA 帯同 + 集中合宿」を前提とできない一般的な開発現場**へ、AI-DLC の精神を移植するための **第一歩としての retroactive 適用**
- これは AI-DLC を「現場運用可能な実践知」へ降ろす実証

---

## 4. 対する反論への先回り

### 反論 A: 「retroactive は本物ではない」
**応答**: AI-DLC の核心は意思決定構造であり、その構造は事後でも検証可能。Wipro の "3か月→20時間" 数値も、AWS SA 帯同という人為的圧縮環境下のものであり、現実の開発組織の実態とは乖離している。本プロジェクトの retroactive は、その意味で**より一般的な現場の実態に近い適用例**である。

### 反論 B: 「audit.md が後付けなら何でも書ける」
**応答**: 本プロジェクトの `audit.md` の retroactive エントリは、リポジトリの git log と GitHub Actions ログを参照して再構成可能（Phase 2 で `scripts/aidlc-evaluator/verify_audit_against_git.py` を実装予定）。**外部証拠との整合性は監査可能**である。

### 反論 C: 「Mob Construction を実施しないなら AI-DLC を名乗るな」
**応答**: 公式 README にも "Adaptive Workflow" という原則があり、Mob 儀式は必須ではなく適応的に選択される。本プロジェクトは個人開発スコープに対して **Mob を Solo + retroactive 文書化に置換** した適応事例として位置づけられる。

---

## 5. Phase 2 で何が変わるか

| 項目 | Phase 1（現在） | Phase 2 |
|---|---|---|
| audit.md のエントリ | retroactive 中心 | real-time |
| Mob Elaboration | 不実施 | 最低 1 セッション（仮想可） |
| Mob Construction | 不実施 | 実装中の主要ステージで実施 |
| `extensions/meta/bolts/` | プレースホルダー | 各 Bolt のセッションログ完備 |
| `extensions/meta/living-spec/` | 未配置 | spec ↔ code 同期 CI 稼働 |
| `verify_audit_against_git.py` | 未実装 | git log との整合性自動検証 |

---

## 参考文献

- kiakiraki. "The Essence of AI-DLC is 'Extreme Decision-Making via Mob Work'." Zenn, 2026.
- AWS DevOps Blog. Raja SP. "AI-Driven Development Life Cycle: Reimagining Software Engineering." 2025-07-31.
- AWS DevOps Blog. "Open-Sourcing Adaptive Workflows for AI-DLC." 2025-11-29.
- Tilsen, Peter. "The AI-Driven Development Lifecycle (AI-DLC): A critical, yet hopeful view." Medium / Data Science Collective, 2025.
- AWS re:Invent 2025 セッション DVT214. Anupam Mishra, Raja SP. 2025-12.
- Findy Team+. 「AI-DLC（AI 駆動開発ライフサイクル）とは何か？」2026.

---

*本書は本プロジェクトの方法論的姿勢の宣言文書である。事実は隠さず、構造で勝負する。*
