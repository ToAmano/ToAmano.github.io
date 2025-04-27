---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: LaTeXで原稿を最後にflatternできるような構造を考える
layout: single
date:   2025-2-16 21:00:00 +0900
categories: coding
tags:
 - latex
header:
  teaser:
description: LaTeXでの論文作成において、ファイルを階層化して管理し、最終的にすべてのファイルを一つにまとめる方法を検討。投稿時には、すべてのファイルを同一ディレクトリに配置し、必要なツールを使って統合することが重要。ファイル名の管理も注意が必要。
---

`LaTeX` で論文原稿を作る際はファイルを分割してディレクトリも階層化して作成したいが，最後`arXiv` やジャーナルに投稿するときはソースファイルを一つにまとめ，図表も同じ階層に置かないといけない．ここのワークフローをなんとか楽にする方法を検討するのがこの記事の目的である．答えや最適解があるわけではなく，現時点での自分用のまとめ．

## `LaTeX` プロジェクトの現在の構成

プロジェクトディレクトリの直下におおもとのソースファイル`main.tex` があり，`/docs`に文書ファイル，`/figures`に図，`/tables`に表，`/include`に図表をいれるフロート環境のファイル，`/reference`に参考文献のbibファイルが配置される以下のような構成を考える．`/submit` には最終的に投稿するひとまとめのファイル群を格納する．`/history` はrevisionの履歴を残すためのディレクトリである．

レポジトリを以下のリンクに配置した．
- [paper_template](https://github.com/ToAmano/paper_template)

<aside>
💡

revisionについてはgithubのworkflowを利用して都度コンパイルするという方法もある（別途記事化予定）．ただし，結局上位者にレビューしてもらうときはacrobatにコメント入れてもらうとかだったりするので，完全にgithubだけでやるのは大変そう．

</aside>

```bash
.
├── README.md
├── docs
│   ├── abst.tex
│   ├── acknowledgment.tex
│   ├── appendix.tex
│   ├── conclusion.tex
│   ├── intro.tex
│   ├── path_setting.tex
│   ├── preamble.tex
│   ├── result.tex
│   ├── theory.tex
│   └── title_and_author.tex
├── figures #図と表
│   ├── fig01
│   │   ├── fig01.pdf
│   │   └── fig01.tex
│   ├── fig02
│   │   ├── fig02.pdf
│   │   └── fig02.tex
│   ├── fig03
│   │   ├── fig03.pdf
│   │   └── fig03.tex
│   ├── table01
│   │   └── table01.tex
│   ├── table02
│   │   └── table02.tex
├── include # float環境
│   ├── fig01_include.tex
│   ├── fig02_include.tex
│   ├── fig03_include.tex
│   ├── table01_include.tex
│   └── table02_include.tex
├── main.tex # mainファイル
├── references # bibtex
│   └── ref.bib
└── submit # 投稿用にmain.texをひとまとめにする
    └── READE.md
```

このような構成にするとすべての要素を別々に管理できるため，例えば外部発表で図だけ使いたいときなどに便利である．図表は`standalone` パッケージで個別にタイプセットしてpdf化することでこれを実現できる．

個別のディレクトリ名やファイル名の命名ルールは，両方に`fig01_` や`table01_`のように図表番号を接頭辞としてつけておくことである．例えば図1用のファイル群は，`fig01_sample` ディレクトリの中に`fig01_sample.tex` ソースファイルを作って`fig01_sample.pdf` を作成する．これを本文中でinputするときは`include` ディレクトリに`fig01_include.tex` ファイルを配置し，その中でfloat環境を作成し，キャプション等をこの中で管理する．このように接頭辞を入れておくとジャーナルによっては勝手に図表の識別をやってくれる．

<aside>
💡

includeディレクトリにfloat環境を分割するのは，最後に自分で体裁を整えるときに\begin{figure}の位置を調整するのが楽（1行書き換えるだけなので）だからである．その心配がないときはわざわざ分ける必要はないと思う．

</aside>

<aside>
💡

ファイル名に図表番号を入れるのはわかりやすくなる反面，後から図を足すときに番号を振り直さないといけないという大きなデメリットも存在する．

</aside>

一つの図の中に複数のsub figureがある場合は，可能なら一つのpdfにまとめたいところだが現実的には難しい場合も多い．このときは`fig01a_` ，`fig01b_` のようにディレクトリやファイルを命名して分割する．この例となるレポジトリを作成したので，順次拡充していきたい．

[https://github.com/ToAmano/paper_template](https://github.com/ToAmano/paper_template)

## 投稿時のプロジェクト構成

投稿時には，すべてのファイルが同一ディレクトリにあるようにする．メインのソース・ファイルはひとつのLaTeXファイルにまとまっていないといけない．従って上の構成では，main.texにdocs/以下のファイルとinclude/以下のファイルの内容がまとめて入り，各種図もこのディレクトリに格納されている状態だ．さらに，メインファイルから図表までの相対パスが書き換わったので，`\includegraphics`でのパスの設定も変更しないといけない．これらを手でやるのは大変なので，何らかのツールを利用してsubmitディレクトリに自動で展開するようにしたい．

投稿時には，すべてのファイルが同一ディレクトリにあるようにする．メインのソース・ファイルはひとつのLaTeXファイルにまとまっていないといけない．従って上の構成では，main.texにdocs/以下のファイルとinclude/以下のファイルの内容がまとめて入り，各種図もこのディレクトリに格納されている状態だ．さらに，メインファイルから図表までの相対パスが書き換わったので，`\includegraphics`でのパスの設定も変更しないといけない．これらを手でやるのは大変なので，何らかのツールを利用してsubmitディレクトリに自動で展開するようにしたい．

```bash
submit/
├── table01.tex
├── table02.tex
├── fig01.pdf
├── fig02.pdf
├── fig03.pdf
├── submit.pdf
└── submit.tex
```

## 図表読み込み時の設定

例として簡単な例でどのように図表が読み込まれるかを紹介する．まず，一番トップの`main.tex` から各種`docs/` ディレクトリにある文書ソースファイルを読み込む．文書ソースからはさらに`include/` 配下にあるフロート環境を読み込み，フロート環境内では図なら`\includegraphics` ，表なら`\input`で`figures/` 内の図を読み込む．

これを実現するためのMWEは以下の通り．ただし，適当なfig01.pdfを用意する必要がある．（面倒なら`example-image-a`で置き換えると場所だけ確保してくれる．）

```latex
\documentclass{article}
\usepackage{lipsum} % dummy text
\usepackage{graphicx}
\begin{document}
\input{result.tex}
\end{document}
```

```latex
\lipsum[10]

\input{include/fig01_include.tex}
\input{include/table01_include.tex}
```

```latex
\begin{figure}[thb]  
\centering
\includesgraphics{fig01.pdf} % need to prepare the figure
\caption{HOGEHOGE}
\label{fig:01}
\end{figure}
```

```latex
 \begin{table}[htb] 
 \centering
  \caption{HOGEHOGE}
  \input{table01.tex}
  \label{table:01}
 \end{table}
```

```latex
  \begin{tabular}{lcc}
   \hline\hline
      & A  & B    \\
    A & $1$ & $2$ \\
    B & $1$ & $2$ \\
    \hline\hline
  \end{tabular}
```

最終的にはすべて平らなディレクトリ構造にすることを考えると，`\includesgraphics{figures/fig01/fig01.pdf}` のようにフルパス指定の表記だと後で書き直す必要がでてくる．そこで`\includegraphics` および`\input`のパスの指定をして`\includesgraphics{fig01.pdf}`としたほうが便利である．そこでプリアンブルで以下のようにパス指定する．`\graphicspath` はincludegraphics用のコマンドで，一方でinputの方はそのようなコマンドがないので自前で定義する必要がある．

```latex
{% raw %}
\documentclass{article}
\usepackage{lipsum} % dummy text
\usepackage{graphicx}
\graphicspath{{figures/fig01}
              {figures/fig02}} % includegraphics path
 \makeatletter
 \providecommand*{\input@path}{}
 \g@addto@macro\input@path{{figures/table01/}
                           {figures/table02/}}% append path
 \makeatother
               
\begin{document}
\input{result.tex}
\end{document}
{% endraw %}
```

これでinputファイルやincludegraphicsのパス指定は簡略化できる．

```latex
 \begin{table}[htb] 
 \centering
  \caption{HOGEHOGE}
  \input{table01.tex}
  \label{table:01}
 \end{table}
```

```latex
\begin{figure}[thb]  
\centering
\includesgraphics{fig01.pdf} % need to prepare the figure
\caption{HOGEHOGE}
\label{fig:01}
\end{figure}
```

一方で，main.texから呼び出すdocs/result.texのようなファイルはそのままパスベタ書きでも特に問題がないのでそのままにする．

## ディレクトリ構造変換ツールの検討

最初の階層的な構造から投稿用のディレクトリを得るために必要なことは大きく分けて以下の２つ．

1. `\input` で取り込んだLaTeXファイルを一つのファイルにまとめる
2. `\includegrapgics` で取り込む図表を一つの場所にまとめる．ついでにパスの書き換えも行う．

よく使われるツールとしてperlベースの`latexpand` があり，これは要件1を満たしてくれる．このコマンドの良いところは通常デフォルトで入っており，またCTANでも配布されていることだ．

```bash
$latexpand　input.tex > submit.tex
```

また，ほぼ同様の機能を提供する`flatex` もある．こちらはpythonベースで，pipからインストールする．

[https://github.com/johnjosephhorton/flatex](https://github.com/johnjosephhorton/flatex)

```bash
$pip install flatex
$flatex input.tex submit.tex
```

これらのツールは要件2の方をみたさないので手動で図表ファイルの格納をやらないといけないのが面倒くさい．

次にファイルの格納もやってくれるツールとして`texdirflatten` がある．これは通常すでにインストールされており，すぐ使える状態になっているはず．

[https://github.com/cengique/texdirflatten](https://github.com/cengique/texdirflatten)

ただし，自身の環境ではどうも画像ファイルの拡張子を潰してしまってうまく動かないという問題がある．拡張子を手で追加するくらいなら大した手間ではないので目を瞑って使っている．

```bash
$texdirflatten -1 -f input.tex -o submit
```

## Tips

- 最後にまとめる際に同じファイル名のファイルがあると上書きされてしまうため，ファイル名は構成時からちゃんと分けること．

## 問題点

- tableの扱い： tableをstandalone環境で作っていると，最後に手動で直す必要がある．tableは単体で発表とかに転用することが（図よりは）少ないので，単に`\input` で読み込むので良いかと思って運用している．
- まともに動くsubmit用のファイル作成ツールがない．

## TODO

- サンプルリポジトリの拡充（図表パターン，文書，引用，参照）
- texdirflattenの代替ツールの開発

## 参考文献

[分割TeX fileを単一TeX fileに統合する](https://zenn.dev/ultimatile/articles/b3fbd4ec65373d)

[Replace \input{fileX} by the content of fileX automatically](https://tex.stackexchange.com/questions/21838/replace-inputfilex-by-the-content-of-filex-automatically)

[https://github.com/google-research/arxiv-latex-cleaner](https://github.com/google-research/arxiv-latex-cleaner)

[https://github.com/johnjosephhorton/flatex](https://github.com/johnjosephhorton/flatex)

flapというツールもあってこちらも図表を移動してくれるらしいが，手元の環境ではエラーで動かなかった．

[https://github.com/fchauvel/flap](https://github.com/fchauvel/flap)
