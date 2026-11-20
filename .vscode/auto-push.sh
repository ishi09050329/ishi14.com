#!/bin/bash
set -e

cd "$(git rev-parse --show-toplevel)"

# mainブランチ以外では実行しない
if [ "$(git branch --show-current)" != "main" ]; then
  echo "停止: mainブランチではありません"
  exit 1
fi

# マージ中・リベース中は実行しない
if [ -f "$(git rev-parse --git-path MERGE_HEAD)" ] || \
   [ -d "$(git rev-parse --git-path rebase-merge)" ] || \
   [ -d "$(git rev-parse --git-path rebase-apply)" ]; then
  echo "停止: Gitの競合処理中です"
  exit 1
fi

# GitHubの最新状態を確認
git fetch origin main

if ! git merge-base --is-ancestor origin/main HEAD; then
  echo "停止: GitHub側に先行する変更があります。先にPullしてください"
  exit 1
fi

# pages内のHTMLだけを登録
git add -- 'pages/*.html'

# 変更がなければ終了
if git diff --cached --quiet -- pages/; then
  echo "変更なし"
  exit 0
fi

# 自動Commit
git commit -m "Auto update website: $(date '+%Y-%m-%d %H:%M:%S')" -- pages/

# GitHubへPush
git push origin main

echo "GitHubへの自動Pushが完了しました"
