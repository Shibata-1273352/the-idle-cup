# Contributing

本プロジェクト（The Idle Cup）への貢献は、以下の規約に従ってください。

---

## Commit Message 規約: Conventional Commits 1.0.0

すべてのコミットメッセージは [Conventional Commits 1.0.0](https://www.conventionalcommits.org/ja/v1.0.0/) に準拠します。

### 形式

```
<type>[optional scope]: <description>

[optional body]

[optional footer(s)]
```

- **subject 行**: `<type>: <description>` の形式。72 文字以内推奨。命令形・小文字始まり・末尾ピリオドなし。
- **body**: 「なぜ」を中心に書く（「何を」は diff から読める）。72 文字で改行。subject から空行 1 行で区切る。
- **footer**: `Co-Authored-By:`、`BREAKING CHANGE:`、Issue 参照 (`Refs: #123`) 等。

### 採用する type 一覧

| type | 用途 | 本リポでの主な使用場面 |
|---|---|---|
| `feat` | ユーザー向け新機能の追加 | Phase 2 で MVP 実装が始まったら頻出 |
| `fix` | ユーザー向けバグ修正 | Phase 2 以降 |
| `docs` | ドキュメントのみの変更 | **Phase 1 で最頻出**。README / aidlc-docs / audit / 仕様書 |
| `chore` | ビルド・補助ツール・ライセンス等、ユーザー直接影響のない雑務 | LICENSE 追加 / バージョン migration / 不要ファイル削除 / 初期化 |
| `refactor` | 機能変更を伴わないリファクタ | コード実装後 |
| `perf` | 性能改善 | Phase 2 以降 |
| `test` | テストの追加・修正 | Phase 2 以降 |
| `build` | ビルドシステム・依存関係の変更 | Phase 2 以降 |
| `ci` | CI 設定の変更 | Phase 2 以降 |
| `style` | コードスタイルのみ（フォーマット等） | Phase 2 以降 |
| `revert` | 過去コミットの取り消し | 必要時 |

### Phase 1（書類審査時点）の特徴

- Phase 1 はドキュメント中心のため、**`docs:` と `chore:` が支配的**
- `feat:` `fix:` `refactor:` 等のコード系 type は Phase 2（Construction Phase）開始後に出現する想定

### Breaking Changes

破壊的変更は subject に `!` を付与、または footer に `BREAKING CHANGE:` を記載：

```
docs!: restructure aidlc-docs to v0.2.0 hierarchy

BREAKING CHANGE: aidlc-docs/inception/* paths changed; update bookmarks.
```

### 例

```
docs: apply Codex review fixes (pre-submission quality gate)

- README: clarify Construction directory description (Plan-only, not implementation)
- components.md: add FR-22 to U4, add Share Card Generator to U6
- aws-architecture.md: add explicit rows for NFR-05 and NFR-12
- audit.md: log Entry-016 (Codex review) and Entry-017 (applied fixes)

Co-Authored-By: Claude Opus 4.7 (1M context) <noreply@anthropic.com>
```

```
chore: migrate AI-DLC compliance target from v0.1.7 to v0.1.8

VERSION bump and core-workflow path updates per upstream changelog.
Updated all current-state version labels (README badge, aidlc-state.md
Compliance, document headers). Migration recorded in audit Entry-018.
```

```
chore: remove obsolete migration script and redundant .gitkeep
```

### scope（任意）

本リポでは scope は基本的に省略します。必要時のみ：
- `docs(audit): record Entry-026 …`
- `chore(license): switch from MIT to Apache-2.0`

---

## Pull Request 規約

Phase 1（個人開発）では PR を使わず main 直接運用。
Phase 2（Mob Construction 着手）から `feat/{unit-id}-{short-desc}` ブランチ → PR → 審査の運用に移行する想定。詳細は Phase 2 着手時に追記。

---

## 関連

- [Conventional Commits 1.0.0 仕様](https://www.conventionalcommits.org/ja/v1.0.0/)
- [Semantic Versioning 2.0.0](https://semver.org/lang/ja/) — Phase 2 で採用
- [`aidlc-docs/extensions/meta/methodology-honesty.md`](aidlc-docs/extensions/meta/methodology-honesty.md) — 開発プロセス全体の規約姿勢
