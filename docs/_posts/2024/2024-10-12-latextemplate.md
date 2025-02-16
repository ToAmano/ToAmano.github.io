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

**Note:** 良いものがあれば追加していく予定．
{: .notice--warning}

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

Springerの論文投稿用テンプレートとして，`sn-jnl`クラスが用意されている．

- [springer](https://www.springernature.com/gp/authors/campaigns/latex-author-support)

Springerの書籍用のテンプレートも用意されている．これは自力でインストールしないといけない．これは使って見たが余白が大きすぎるため，デフォルトだとちょっと使いにくいと思った．Springerの本自体は別に普通の余白なのだが，なぜこのテンプレートだけこれだけ余白が大きいのかはちょっと謎．また，投稿時にこのテンプレートを使う必要はない（編集者に確認ずみ）ため，Springerから書籍の出版をする際も使いにくければ利用する必要はない．

- [springer](https://www.springer.com/gp/authors-editors/book-authors-editors/your-publication-journey/manuscript-preparation?srsltid=AfmBOorHEidanV7_-zEi0M_l6XzTXGOhgB0TZO-um1V_MQTnNPe5zYIM#toc-49272)

## NeurIPS

機械学習系の論文で見かけるNeurIPSは，どうも毎年違うスタイルファイルを利用しているようだ．中身は同じかもしれないが，`usepackage`で利用するパッケージ名が`neurips_2024`のように年を付記する形になっている．こちらも手動でインストールする必要がある．

- [neurips 2024](https://neurips.cc/Conferences/2024/CallForPapers)

## ICML

おなじく機械学習系のトップカンファレンスであるICMLも毎年スタイルファイルを利用するようだ．

- [ICML 2024](https://icml.cc/Conferences/2024/AuthorInstructions)

## 日本物理学会

日本語用のテンプレートということで，国内のものも探した．日本物理学会は学会誌用ののテンプレートをいくつか用意している．スタイルファイルとしては`newbutsuri.sty`と`butsuri2.sty`の二種類あり自身でインストールする必要あり．サンプルファイルがいくつか用意されており，物理系で２段組の日本語ノートを作りたい場合はこれが良さそうに思う．

- [物理学会](https://www.jps.or.jp/books/shippitsu_style.php)

## LaTeXパッケージのインストール方法

`revtex`のようにデフォルトで入っていないものはLaTeXパッケージとして追加でインストールする必要がある．以下にインストール方法を簡単に記す．まずはファイル一式をダウンロードし，Zipなら解答しておく．以下NeurIPSを例に進める．

```bash
$ wget https://media.neurips.cc/Conferences/NeurIPS2024/Styles.zip
$ unzip Styles.zip
```

解凍すると，`Styles`ディレクトリに`neurips_2024.pdf`，`neurips_2024.sty`，`neurips_2024.tex`の3つのファイルがあった．どういうファイルがあるかはパッケージによるが，`.sty`拡張子を持つのが`usepackage`から呼び出すLaTeXのスタイルファイルだ．他にも`.cls`の場合もあり，こちらは`documentclass`から呼び出す．このファイルをLaTeXの既定の場所に置く必要がある．これは`kpsewhich`コマンドでどこに置くべきかわかる．ここでは例として絶対に入っているamsmathパッケージの場所を探す．

```bash
$ kpsewhich amsmath.sty 
/usr/local/texlive/2023/texmf-dist/tex/latex/amsmath/amsmath.sty
```

`/usr/local/texlive/2023/texmf-dist/tex/latex/`ディレクトリに`<パッケージ名>/<ファイル名>`の形でファイルを配置する．sudo権限が必要．

```bash
sudo mv Styles /usr/local/texlive/2023/texmf-dist/tex/latex/neurips_2024
```

最後に`mktexlsr`でパッケージ一覧を更新する．

```bash
sudo mktexlsr
```

これで無事利用できるようになる．以下簡単なMWEだ．

```latex
\documentclass{article}

% if you need to pass options to natbib, use, e.g.:
%     \PassOptionsToPackage{numbers, compress}{natbib}
% before loading neurips_2024

% ready for submission
\usepackage{neurips_2024} % use [preprint] option for arXiv, [final] for the final version
% to avoid loading the natbib package, add option nonatbib:
%    \usepackage[nonatbib]{neurips_2024}

\usepackage{lipsum}
\usepackage[utf8]{inputenc} % allow utf-8 input
\usepackage[T1]{fontenc}    % use 8-bit T1 fonts
\usepackage{booktabs}       % professional-quality tables
\usepackage{amsfonts}       % blackboard math symbols
\usepackage{nicefrac}       % compact symbols for 1/2, etc.
\usepackage{microtype}      % microtypography

\title{MWE for NeurIPS2024}

\author{
  Taro Yamada \\
  Department of Japan\\
  \texttt{hogehoge@email.com} \\
}

\begin{document}
\maketitle
\begin{abstract}
   \lipsum[2]
\end{abstract}

\section{HOGE}
 \lipsum[10]
\end{document}
```

つぎに，bibtexのスタイルファイル（`.bst`）を含むパッケージの場合，これはまた別のディレクトリに配置する必要がある．基本的にはスタイルファイルのディレクトリ（`tex/latex`）と似た場所（`bibtex/bst`）にあるが，あるが，これも`kpsewhich`で検索できる．

```bash
$ kpsewhich apsrev4-2.bst
/usr/local/texlive/2023/texmf-dist/bibtex/bst/revtex/apsrev4-2.bst
```

このディレクトリに同じ形式でファイルを配置し，`mktexlsr`コマンドでファイルデータベースを更新する．

## まとめ

物理，化学系雑誌，あとは機械学習系で物理化学分野でたまに見かける会議でLaTeXテンプレートのあるものをいくつかとりあげた．投稿時はもちろん，日常のノート作成にも大いに使えるテンプレートだと思うので時間があるときに覗いて見ると良いと思う．

## TODO

- パッケージごとに例を表示
- 対応している主要機能の調査