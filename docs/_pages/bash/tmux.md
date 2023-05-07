---
layout: single
title:  "tmux"
date:   2022-09-04 10:03:40 +0900
categories: bash zsh
---

## tmux使い方


操作	コマンド
セッションの作成	tmux, tmux new
名前を付けて作成	tmux new -s mysession
セッションの削除	tmux kill-session -t mysession
現在のセッション以外を削除	tmux kill-session -a
セッションの一覧表示	tmux ls
セッションを再開	tmux attach、tmux a
名前指定でセッションを再開	tmux attach -t mysession、tmux a -t mysession


## tmuxの設定

`tmux`の設定は`~/.tmux.conf`ファイルに書く．

```

```


## iterm2との連携

