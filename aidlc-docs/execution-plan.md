# Execution Plan

> **役割**: AI-DLC が計画した stage 列の宣言。人間の承認を経て実行に入る。
> **承認規約**: 本ファイルは AI が生成し、人間が approve した上で実行に入る。
> **更新タイミング**: 計画変更時のみ（実行ログは `audit.md` 側）。

---

## Approval

- **Initial Approval**: テックリード, 2026-05-04T00:04:00+09:00
- **Latest Revision**: 2026-05-10T14:45:00+09:00（Inception 成果物 real-time authoring の確定反映）

---

## 計画された Stage 列

### 🔵 Inception Phase

| # | Stage | Status | 備考 |
|---|---|---|---|
| 1 | Workspace Detection | ✅ Complete (retroactive) | Greenfield 確定 |
| 2 | Reverse Engineering | ⏭ Skipped | Greenfield のため不要 |
| 3 | Requirements Analysis | ✅ Complete (real-time, 2026-05-10) | `inception/requirements/requirements.md` |
| 4 | User Stories | ✅ Complete (real-time, 2026-05-10) | `inception/user-stories/{personas,stories}.md` |
| 5 | Application Design | ✅ Complete (real-time, 2026-05-10) | `inception/application-design/{intent,components,aws-architecture}.md` |
| 6 | Workflow Planning | ✅ Complete | 本書 + audit.md が成果物 |
| 7 | Units Generation | ✅ Complete (real-time, 2026-05-10) | `construction/plans/construction-plan.md` |

### 🟢 Construction Phase（Phase 2 / 予選会・決勝で実装）

| # | Unit | Status |
|---|---|---|
| 1 | Construction Planning | ✅ Complete (`construction/plans/construction-plan.md`) |
| 2 | U1: User State Estimator | ⏸ Phase 2 |
| 3 | U2: Coffee Selection Engine | ⏸ Phase 2 |
| 4 | U3: Brewing Parameter Generator | ⏸ Phase 2 |
| 5 | U4: Idle Index Calculator | ⏸ Phase 2 |
| 6 | U5: Confirmation Whisper | ⏸ Phase 2 |
| 7 | U6: Life Delegation Console | ⏸ Phase 2 |
| 8 | Build and Test | ⏸ Phase 2 |

### 🟡 Operations Phase

- Phase 2 / Designed のみ
- 詳細は [`operations/README.md`](operations/README.md)

---

## 構造移行 Sub-plan（完了 / Obsolete 化）

| Step | 内容 | Status | スコープ |
|---|---|---|---|
| Step 1 | 公式階層作成 + ルート3ファイル | ✅ Complete | 必須 |
| Step 2 | 既存 `01-...08-` ファイル移行（スクリプト経由） | ⏭ Obsolete (Direct Authoring on 2026-05-10) | 旧階層は記述上のみ存在し実体なし、real-time authoring で直接新階層へ配置 |
| Step 3 | README.md 痩身化 | ✅ Complete | 必須 |
| Step 4 | Self-Reference 強化 (`extensions/meta/`) | ✅ Complete (2026-05-10) | 採用 |
| Step 5 | Bolt 単位ログの real-time 化 | 🟡 部分完了 (2026-05-10〜 real-time) / 完成は Phase 2 | 採用 |
| Step 6 | Living Spec 化 | ⏸ Phase 2 | 採用するが Phase 2 |
| Step 7 | 旧ファイル削除 | ⏭ N/A | 旧ファイルは存在せず |

---

## Adaptive Skip 判断ログ

| Stage | Skip 判断 | 根拠 |
|---|---|---|
| Reverse Engineering | Skip | Greenfield プロジェクト |
| Operations 詳細実装 | Defer to Phase 2 | 公式 v0.1.7/v0.1.8 でも placeholder、ハッカソンスコープ外 |
| Bolt real-time 化（完成形） | Defer to Phase 2 | 2026-05-10 から real-time 開始、完成は Phase 2 |
| Construction Per-Unit Loop の実装 | Defer to Phase 2 | 書類審査の評価対象は Inception 成果物 |

---

## 旧 SDLC からの置換

| 旧 Agile 概念 | AI-DLC での置換 | 本プロジェクトでの位置づけ |
|---|---|---|
| Sprint (2-4 週) | Bolt (時間〜日) | retroactive + real-time の二段運用 |
| Epic / Story | Unit of Work | U1〜U6 の 6 Units |
| Backlog 管理 | execution-plan.md (本ファイル) | 計画一元化 |
| Standup / Planning / Retro | Mob Elaboration / Mob Construction | Phase 2 で real-time 実装 |

---

## 提出関連の最終チェックリスト

- [ ] 全 Inception 成果物が `aidlc-docs/` 配下に揃っている
- [ ] README.md がリポジトリルートに存在し、世界観 + 内部ファイル目次が機能している
- [ ] aidlc-state.md / audit.md / execution-plan.md が整合している
- [ ] git リポジトリが初期化されコミット済み
- [ ] GitHub の **public** リポジトリへ push 済み
- [ ] チーム全員の AWS Builder ID が取得されている
- [ ] 応募フォームに公開リポジトリ URL を入力済み
- [ ] 提出締切（2026-05-10 23:59）に間に合っている

---

*Approved plans flow into `audit.md` as execution entries. Updates here trigger an audit entry.*
