---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: 論文投稿時のLaTeXテンプレートリンク集
layout: single
date:   2024-10-12 21:00:00 +0900
categories: coding
tags:
 - latex
header:
  teaser: 
description: 代表的な雑誌のLaTeXテンプレートへのリンクをまとめる．使い方についても簡単に述べる．
---

論文を書く時，投稿先のテンプレートに合わせてLaTeX原稿を作るのが通常のやり方だと思う．そこで，投稿したことのある，または今後投稿する可能性がある雑誌のテンプレートへのリンクページをまとめ，今後の参考にする．ちなみにこれらのテンプレートは優れたものが多いので，自分でノートを作る時にも便利だと思う．

> [!NOTE]
> 良いものがあれば追加していく予定．

## American Physics Society

Physical Reviewを代表とするAPSジャーナル系は**revtexパッケージ**が用意されており，デフォルトでインストールされているケースがほとんどである．追加でインストールが不要なので手軽に利用でき，フォーマットも綺麗なのでおすすめ．ただし日本語には非対応．

- [revtex](https://journals.aps.org/revtex)

## ACS Publishing

Americal Chemical Societyの発行するJournal of physical chemistryやJournal of Chemical Theory and Computationといった雑誌には**achemsoパッケージ**が用意されている．これも追加インストールが不要なので使いやすい．

- [achemso](https://pubs.acs.org/page/4authors/submission/tex.html)

## IOP Publishing

英国Institute of Physicsの発行する雑誌には，**iopartパッケージ**が用意されている．これは自力でインストールしないといけない．

- [iopart](https://publishingsupport.iopscience.iop.org/questions/latex-template/)

## Springer

Springerの書籍用のテンプレートも用意されている．これは自力でインストールしないといけない．これは使って見たが余白が大きすぎるため，デフォルトだとちょっと使いにくいと思った．Springerの本自体は別に普通の余白なのだが，なぜこのテンプレートだけこれだけ余白が大きいのかはちょっと謎．また，投稿時にこのテンプレートを使う必要はない（編集者に確認ずみ）ため，Springerから書籍の出版をする際も使いにくければ利用する必要はない．

- [springer](https://www.springer.com/gp/authors-editors/book-authors-editors/your-publication-journey/manuscript-preparation?srsltid=AfmBOorHEidanV7_-zEi0M_l6XzTXGOhgB0TZO-um1V_MQTnNPe5zYIM#toc-49272)

## NeurIPS

機械学習系の論文で見かけるNeurIPSは，どうも毎年違うスタイルファイルを利用しているようだ．中身は同じかもしれないが，`usepackage`で利用するパッケージ名が`neurips_2024`のように年を付記する形になっている．こちらも手動でインストールする必要がある．

- [neurips 2024](https://neurips.cc/Conferences/2024/CallForPapers)

## ICML

おなじく機械学習系のトップカンファレンスであるICMLも毎年スタイルファイルを利用するようだ．

- [ICML 2024](https://icml.cc/Conferences/2024/AuthorInstructions)

## まとめ

物理，化学系雑誌，あとは機械学習系で物理化学分野でたまに見かける会議でLaTeXテンプレートのあるものをいくつかとりあげた．投稿時はもちろん，日常のノート作成にも大いに使えるテンプレートだと思うので時間があるときに覗いて見ると良いと思う．