#!/usr/bin/env bash
# AI-DLC 公式 v0.1.7 階層への移行スクリプト
#
# 旧構造: aidlc-docs/01-...08-*.md (フラット番号付き)
# 新構造: aidlc-docs/{inception,construction,operations,extensions}/... (公式階層)
#
# 使用法:
#   bash scripts/migrate-to-aidlc-structure.sh
#
# 前提:
#   - リポジトリのルートで実行すること（scripts/ 経由でも自動でルートに移動）
#   - Step 1 が完了している（aidlc-docs/{inception,...}/ が存在する）
#   - 新しいブランチを切ってから実行することを強く推奨
#
# 動作:
#   - 既存ファイルを git mv で新パスへ移動（git の rename 履歴を保持）
#   - ファイルが存在しない場合は warn のみで継続
#   - audit.md への移行記録の append は別途手動で行う

set -euo pipefail

# リポジトリルートに移動
if ! cd "$(git rev-parse --show-toplevel 2>/dev/null)"; then
    echo "❌ git リポジトリではありません。git init してから実行してください。"
    exit 1
fi

echo "🔧 AI-DLC v0.1.7 公式階層への移行を開始..."
echo "   作業ディレクトリ: $(pwd)"
echo ""

# 事前チェック: Step 1 が完了しているか
if [ ! -d "aidlc-docs/inception" ] || [ ! -f "aidlc-docs/aidlc-state.md" ] || [ ! -f "aidlc-docs/audit.md" ]; then
    echo "❌ Step 1 が完了していません。"
    echo "   aidlc-docs/inception/ と aidlc-docs/{aidlc-state.md, audit.md} が必要です。"
    exit 1
fi

# ブランチ確認
current_branch=$(git rev-parse --abbrev-ref HEAD)
if [ "$current_branch" = "main" ] || [ "$current_branch" = "master" ]; then
    echo "⚠️  現在のブランチは '$current_branch' です。"
    read -p "   別ブランチを切らずに続行しますか？ (y/N): " confirm
    if [ "$confirm" != "y" ] && [ "$confirm" != "Y" ]; then
        echo "中止しました。'git checkout -b feature/aidlc-migration' などで新ブランチを作成してください。"
        exit 0
    fi
fi

migrate() {
    local from="$1"
    local to="$2"
    if [ -f "$from" ]; then
        mkdir -p "$(dirname "$to")"
        # .gitkeep が同ディレクトリにある場合は削除（ファイルが入るので不要）
        local gitkeep="$(dirname "$to")/.gitkeep"
        if [ -f "$gitkeep" ]; then
            git rm -f "$gitkeep" > /dev/null 2>&1 || rm -f "$gitkeep"
        fi
        git mv "$from" "$to"
        echo "  ✓ $from"
        echo "    → $to"
    else
        echo "  ⚠ $from (not found, skipped)"
    fi
}

echo "📦 既存ファイルを公式階層へ移行..."
echo ""

# Inception phase 配下へ
migrate "aidlc-docs/01-intent.md"               "aidlc-docs/inception/application-design/intent.md"
migrate "aidlc-docs/02-requirements.md"         "aidlc-docs/inception/requirements/requirements.md"
migrate "aidlc-docs/03-application-design.md"   "aidlc-docs/inception/application-design/components.md"
migrate "aidlc-docs/05-aws-architecture.md"     "aidlc-docs/inception/application-design/aws-architecture.md"

# Construction phase 配下へ
migrate "aidlc-docs/04-unit-of-work-plan.md"    "aidlc-docs/construction/plans/construction-plan.md"

# extensions 配下へ
migrate "aidlc-docs/06-ai-dlc-self-reference.md" "aidlc-docs/extensions/meta/self-reference.md"
migrate "aidlc-docs/07-demo-scenario.md"         "aidlc-docs/extensions/demo/demo-scenario.md"
migrate "aidlc-docs/08-business-intent.md"       "aidlc-docs/extensions/business/business-intent.md"

# 旧 ルート aidlc-state.md（あれば退避）
if [ -f "aidlc-state.md" ]; then
    echo ""
    echo "📍 ルート直下の旧 aidlc-state.md を検出..."
    git mv "aidlc-state.md" "aidlc-docs/aidlc-state.md.legacy"
    echo "  ✓ aidlc-state.md"
    echo "    → aidlc-docs/aidlc-state.md.legacy (Step 1 で新規作成済のため退避)"
fi

echo ""
echo "✅ Step 2 移行完了"
echo ""
echo "次のアクション:"
echo "  1. git status で結果を確認"
echo "  2. 移行したファイル内のリンクを修正（手動、または sed スクリプト）"
echo "  3. audit.md に「Entry-008: Step 2 完了」を append"
echo "  4. Step 3: README.md は既に痩身化済み。差分を git diff で確認"
echo "  5. レビュー → コミット → PR"
echo ""
echo "ヒント: 移行したファイル内の相対リンクは手動修正が必要です。"
echo "       例) [01-intent.md] → [inception/application-design/intent.md]"
