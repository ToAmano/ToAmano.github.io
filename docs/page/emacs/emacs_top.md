---
layout: default
title:  "emacsトップページ"
date:   2022-09-04 10:03:40 +0900
categories: emacs
---



自分のEmacsの用途は主にシェル上でのサーバーの作業とLaTeX文書の作成である．コードを書く時はVScodeを利用しているが，Emacsで使えるTeX文書用メジャーモードyatexが非常に便利であるためなかなかVScodeに移行できずにいる．

## init.elの設定

[initelの設定はこちら](initel.md)

<!--https://mamewo.ddo.jp/emacs.html -->


## emacs --daemonによる運用

init.elで読み込むパッケージが増えてくるとemacsの起動時間がだんだん長くなってきてしまう．このような場合，バックグラウンドで常にemacsを動かしておくことで起動を速くすることができる．


## 空白行削除

```lisp
M-x flush-lines
> ^$    #(改行の表現)
```


<!-- https://higepon.hatenablog.com/entry/20080731/1217491155 
https://cortyuming.hateblo.jp/entry/20101125/p1
https://sanryuu.hatenadiary.org/entry/20131207/1386432684
-->


## 文法チェック

https://qiita.com/niitsuma/items/d3f06755e956e6fa32c9