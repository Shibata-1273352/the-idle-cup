# Self-Reference — The Idle Cup ⇔ AI-DLC の同型

> **役割**: 本作品（The Idle Cup）と本プロジェクトの開発プロセス（AI-DLC）が、**同じ構造を異なるドメインに適用したものである**ことを論証する。
> **読者**: ハッカソン審査員（独自性の評価軸）/ AI-DLC コミュニティ
> **配置根拠**: 公式 v0.1.7 では meta 文書は明示の場を持たない。本作品の主張上不可欠なため `extensions/meta/` に独自配置。

---

## 1. 主張の一文

> **作品テーマ「人をダメにする = 判断を AI に委譲する」と、AI-DLC「実装を AI に委譲する」は、ドメインを違えただけの同一の構造である。**

両者はいずれも以下の対構造を持つ：

```
        AI が判断・実装を主導
                 │
                 ▼
        (時間経過・委譲の完了)
                 │
                 ▼
        人間が承認・儀式を行う
```

この同型性は本プロジェクトの差別化の核であり、ハッカソンの審査基準のうち「創造性とテーマ適合性」を最も強く満たす。

---

## 2. 二つの世界の対応表

| 軸 | 作品 (The Idle Cup) | 開発プロセス (AI-DLC) |
|---|---|---|
| **委譲する判断** | 朝の一杯の選定・抽出パラメータ・気分の調律 | 要件・設計・コードの一部 |
| **委譲を受ける主体** | LLM（Bedrock 上の Claude） | Coding Agent (Claude Code / Kiro) |
| **承認単位** | 「カップを受け取る」の一行為 | Stage 完了の `Approve & Continue` |
| **説明可能性** | Confirmation Whisper（長押し） | `audit.md` の append-only ログ |
| **委譲の純度の指標** | Idle Index 87% / Human Agency 3% | Stage 内の AI 寄稿率 |
| **儀式** | コーヒーを淹れて飲む | テックリードがレビューして承認する |
| **失敗モード** | 押し付けがましいレコメンド | 過剰な自動化と監査不能 |
| **緩和策** | Whisper / Idle Index 同時表示 | audit.md の不変ログ / 2-option 完了承認 |

---

## 3. 同型性の根拠

### 3.1 構造同型 — 三項関係

両者はいずれも次の三項関係に還元できる。

```
Agent (委譲先)  ──┐
                  ├── (関係 R: 提案する)
Subject (委譲元) ─┘
                  ├── (関係 R': 承認する)
Artifact (儀式) ──┘
```

| | Agent | Subject | Artifact |
|---|---|---|---|
| 作品 | LLM (Bedrock) | ユーザー | 抽出された一杯 |
| 開発 | Coding Agent | テックリード | コード / ドキュメント |

R / R' は構造的に対称であり、ドメインの語彙を入れ替えても保存される。

### 3.2 時間軸同型 — 「事後の儀式」

両者は「Agent が動いた事後に、Subject が儀式を行う」という時間軸を共有する。

- 作品: AI が選定 → 配送 → ユーザーが朝に承認 → 抽出儀式
- 開発: AI が起案 → 文書生成 → テックリードが承認 → 採用儀式

この時間軸は、本プロジェクトの `audit.md` が **retroactive に再構成された** という事実とも整合する（[`methodology-honesty.md`](./methodology-honesty.md) §2.3）。**事後性こそが両世界を貫く** のである。

### 3.3 倫理軸同型 — 「委譲の純度の可視化」

両者はいずれも、委譲の純度を**過剰でも過少でもなく可視化する責務**を持つ。

- 作品: Idle Index 87% / Human Agency 3% を**同時に**表示
- 開発: `aidlc-state.md` の AI 寄稿率と Approval Trail を**同時に**保つ

「全部 AI に任せた」も「全部人間がやった」も虚偽である。両者の **同時可視化** が誠実性の最低ラインである。

---

## 4. なぜ同型性が差別化になるか

### 4.1 ハッカソンの一般的応募作品

多くの応募作品は次のいずれかに分類される：

| 類型 | 限界 |
|---|---|
| AI を使ったプロダクト | テーマと方法論が分離。AI-DLC は単なる開発手段 |
| 開発プロセス自体を見せる作品 | プロダクトの世界観が薄い |

### 4.2 The Idle Cup の位置

The Idle Cup は **作品の世界観と開発方法論が同じ問いに答える**。

> **「AI に何を委譲するのか、何を残すのか」**

作品はこの問いをユーザーの生活に対して問い、開発は同じ問いを開発チームに対して問う。**問いが同じなら、答えも同型である**。

### 4.3 審査員視点での価値

- 「これは AI-DLC の作品です」という主張に、**作品それ自体が証拠を提供する**
- 単なる手段としての AI-DLC ではなく、**思想としての AI-DLC** を体現する
- メンタリング段階で議論を深めうる、二重底のある作品である

---

## 5. 同型を逸脱する箇所（誠実な記録）

完全な同型は美しいが、現実には乖離がある。本書はそれを隠さない。

| 乖離点 | 作品 | 開発 | 補足 |
|---|---|---|---|
| **承認の頻度** | 1日1回（朝） | Stage ごと（数十分〜数時間） | 作品のほうが極限化している |
| **委譲の取消可能性** | カップは淹れたら戻らない | コードは git revert 可能 | 開発のほうが安全 |
| **Mob 性** | 個人体験 | Mob Construction（公式想定） | 本プロジェクトは Solo + retroactive で運用、Phase 2 で Mob 化 |
| **Living Spec の有無** | 製品仕様は固定的 | Phase 2 で Living Spec 化予定 | 構造ではなく実装段階 |

これらの乖離は「美しさ」のための演出ではなく、**事実の正確な観測** である。

---

## 6. Phase 2 での深化計画

| 項目 | Phase 2 |
|---|---|
| **同型性のリアルタイム実証** | Mob Construction の最低 1 セッションを開催し、その意思決定の対構造を audit.md に記録、作品の Confirmation Whisper の生成と並列観測する |
| **Idle Index ⇔ AI 寄稿率の連動可視化** | 作品 UI と開発 dashboard を一画面で並べた展示物の制作 |
| **儀式の二重展示** | 観客の前で AI が一杯を選定し、同じ画面で AI-DLC が次のコードを起案する、ライブ実演 |

---

## 7. 関連ドキュメント

| 観点 | 参照先 |
|---|---|
| Intent | [`../../inception/application-design/intent.md`](../../inception/application-design/intent.md) |
| Methodology Honesty | [`./methodology-honesty.md`](./methodology-honesty.md) |
| Demo Scenario | [`../demo/demo-scenario.md`](../demo/demo-scenario.md) |
| Business Intent | [`../business/business-intent.md`](../business/business-intent.md) |

---

## 参考文献

- Larry Wall. *Programming Perl*. "Three virtues of a programmer: Laziness, Impatience, and Hubris."
- kiakiraki. "The Essence of AI-DLC is 'Extreme Decision-Making via Mob Work'." Zenn, 2026.
- AWS DevOps Blog. "Open-Sourcing Adaptive Workflows for AI-DLC." 2025-11-29.

---

*本書は本作品の独自性の主張文書であり、`audit.md` のエントリ群とともに同型性の証拠を構成する。*
