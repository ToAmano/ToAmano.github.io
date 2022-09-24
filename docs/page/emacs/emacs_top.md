---
layout: default
title:  "emacsトップページ"
date:   2022-09-04 10:03:40 +0900
categories: emacs
---

自分のEmacsの用途は主にシェル上でのサーバーの作業とLaTeX文書の作成である．コードを書く時はVScodeを利用することが多いが，Emacsで使えるTeX文書用メジャーモードyatexが非常に便利であるためなかなかVScodeに移行できずにいる．

## init.elの設定

- [init.elの設定はこちら](initel.md)
- [フォントやアイコンの設定について](emacs_font.md)
- [flyspellによる英語チェック](emacs_aspell.md)

<!--https://mamewo.ddo.jp/emacs.html -->

## emacs --daemonによる運用

init.elで読み込むパッケージが増えてくるとemacsの起動時間がだんだん長くなってきてしまう．このような場合，バックグラウンドで常にemacsを動かしておくことで起動を速くすることができる．


## emacsコマンドについて

[emacsコマンドはこちら](emacs_command.md)


## 文法チェック

- [文法チェック](https://qiita.com/niitsuma/items/d3f06755e956e6fa32c9)


- [yamlモード](https://mugijiru.github.io/.emacs.d/programming/yaml-mode/)


<!--
emacsの設定: https://uwabami.github.io/cc-env/Emacs.html
emacsの設定: https://takaxp.github.io/init.html
neotree: https://myemacs.readthedocs.io/ja/latest/neotree.html
neotree: https://pxaka.tokyo/blog/2021/0417-emacs-icons-in-terminal/
neotree: https://qiita.com/minoruGH/items/2034cad4efe8c5dee4d4
emacsの一括置換: https://qiita.com/masa16/items/e9ddaecfd514552153b1
-->