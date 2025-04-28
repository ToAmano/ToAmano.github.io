---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: tikzexternalize/standaloneパッケージでLaTeX図表を個別管理する
layout: single
date:   2025-4-27 21:00:00 +0900
categories: coding
tags:
 - latex
header:
  teaser:
description: LaTeXにて，tikzで作成した図表を本文書と分離する二つの代表的方法，tikzexternalizeとstandaloneの使い方について解説．
gallery1:
 - url: /assets/posts/2025-04-27-latex-standalone-figure/test.png
   image_path: /assets/posts/2025-04-27-latex-standalone-figure/test-figure0.png
   alt: "placeholder image 1"
   title: "Image 1 title caption"
gallery2:
 - url: /assets/posts/2025-04-27-latex-standalone-figure/main.png
   image_path: /assets/posts/2025-04-27-latex-standalone-figure/sine_cosine.png
   alt: "placeholder image 1"
   title: "Image 1 title caption"

---

論文用の図表をどのソフトウェアで作成するかは人によるところだが，私はLaTeXの中で閉じるのが好きでtikz/pgfplotを利用している．この時に問題になるのがtikzのコンパイルの遅さである．特に図表が増えて来たり，データ点が多い図があると平気で数分以上かかるようになり，頻繁に再コンパイルして変更をチェックすることができない．

この問題を解決するための基本的な考え方は「図表を事前にコンパイルし、本文コンパイル時には完成した図を読み込む」というものである。これにより本文の修正時に図表を再コンパイルする必要がなくなり、全体のコンパイル時間を大幅に短縮できる．実現するための二つの方法である「tikzexternalize」と「standaloneパッケージ」の活用法を詳しく解説する。

後者のstandaloneパッケージを利用したtikz図表の作成は，以下のレポジトリに随時サンプルを足しているので参考にされたい．

[https://github.com/ToAmano/latex_examples](https://github.com/ToAmano/latex_examples)

## tikzexternalizeによる解決法

### 基本的な設定方法

tikzexternalizeは、TikZ/PGFに組み込まれた機能で、図表を個別のPDFファイルとして出力し、次回以降のコンパイル時にはそのPDFを再利用する仕組みを提供する。

基本的な設定手順は以下の通りである：

1. プリアンブルに必要なパッケージとコマンドを追加
2. `\usetikzlibrary{external}`で外部化を有効にする
3. 一度コンパイルするとpdfが外部に書き出され，次回以降のコンパイルで再利用される．

### 実践例: tikzexternalize

以下に、tikzexternalizeを使用した最小限の動作例（Minimal Working Example: MWE）を示す：

```latex
\documentclass{article}
\usepackage{lipsum}
% 必要なパッケージを読み込む
\usepackage{tikz}
\usepackage{pgfplots}
\pgfplotsset{compat=newest}

% 外部化機能を有効にする
\usetikzlibrary{external}
\tikzexternalize[prefix=figures/]  % 出力先ディレクトリを指定（事前に作成しておく）

\begin{document}

\section{Sample}

\lipsum[10]
\lipsum[10]

\begin{figure}[htbp]
  \centering
  \input{sine_cosine.tex}
  \caption{The sin and cosin functions.}
\end{figure}

\end{document}

```

**図表ファイル（sine_cosine.tex）：**

```latex
  % この図は自動的に外部化される
  \begin{tikzpicture}
    \begin{axis}[
      width=10cm,
      height=7cm,
      xlabel={$x$},
      ylabel={$y$},
      grid=both,
      legend pos=north west
    ]
      \addplot[blue, thick] {sin(deg(x))};
      \addplot[red, thick] {cos(deg(x))};
      \legend{$\sin(x)$, $\cos(x)$}
    \end{axis}
  \end{tikzpicture}

```

コードのコンパイルは通常通りで良い．

```bash
latexmk document.tex
```

初回コンパイル時には、TikZ図が処理され、指定したディレクトリ（この例では `figures/`）にPDFファイルが生成される。その後のコンパイルでは、図に変更がない限り、生成済みのPDFファイルが再利用される。図が変更されたら自動的に検知して新たなPDFファイルが作成される．

{% include gallery id="gallery1" caption="左が本文書，右が独立に生成された図表" %}

### tikzexternalizeのメリット・デメリット

**メリット：**

- 既存のLaTeX文書に簡単に導入できる
- 個別のファイルを作成する必要がない
- 図表の変更を自動的に検出して再コンパイルする
- 本文書と図表の引用番号の一貫性が保てる

**デメリット：**

- 投稿時にはすべて`includegraphics`形式で書き直す必要がある．
- 設定によっては思ったように動作しないことがある
- 複雑な文書構造では管理が難しくなることがある

## standaloneパッケージによる解決法

### 基本的な使い方

standaloneパッケージは、ファイルを分割して管理するためのパッケージである。各図表を独立したファイルとして作成し、それを本文書に取り込む形となる。

基本的な使用手順は以下の通りである：

1. 図表ごとに独立したLaTeXファイルを作成（documentclassとして`standalone`を使用）
2. これらのファイルを個別にコンパイルしてPDFを生成
3. 本文書から`\includegraphics`コマンドを使って生成したPDFを取り込む

`standalone`クラスは，作成した図表の余白を自動でなくしてくれるのが優れもので，完全に図表だけのpdfファイルを生成できる．`tikzexternalize`におけるpdfとほぼ同じものができると考えて良い．

作成した図をメイン文書から読み込む際は，通常通り`\includegraphics` を利用する．また，これをラップした`\includestandalone`コマンドも存在する．modeオプションを`image` にすれば`\includegraphics` と全く同じ動作をし，`tex` にするとソース・ファイルを読み込んで再度コンパイルする．ファイル名は拡張子を覗いた部分を引数にいれる．

```latex
\includestandalone[mode=image, width=\linewidth]{sine_cosine}
\includestandalone[mode=tex, width=\linewidth]{sine_cosine}
```

<aside>
💡

ただし，includestandaloneは投稿時には動かないことが多いので，投稿時にはincluegraphicsを利用した方が良い．

</aside>

### 実践例: standalone

以下に、standaloneを使用した例を示す．図表ファイルでは`standalone` クラスを利用し，メイン文書では`includestandalone`か`includegraphics` で読み込む．

**本文書（main.tex）：**

```latex
\documentclass{article}

\usepackage{graphicx}
\usepackage{standalone}
\usepackage{lipsum}
\begin{document}

\section{Sample figure}

\lipsum[10]

\begin{figure}[htbp]
  \centering
  \includegraphics[width=\linewidth]{sine_cosine.pdf}
  \caption{The sin and cosin functions.}
\end{figure}

\begin{figure}[htbp]
  % includestandaloneコマンドも存在し，これでもよみこめる．
  \centering
  \includestandalone[mode=image, width=\linewidth]{sine_cosine}
  \caption{The sin and cosin functions.}
\end{figure}

\end{document}

```

**図表ファイル（sine_cosine.tex）：**

```latex
\documentclass[tikz, border=10pt]{standalone}

\usepackage{pgfplots}
\pgfplotsset{compat=newest}

\begin{document}
\begin{tikzpicture}
  \begin{axis}[
    width=10cm,
    height=7cm,
    xlabel={$x$},
    ylabel={$y$},
    grid=both,
    legend pos=north west
  ]
    \addplot[blue, thick] {sin(deg(x))};
    \addplot[red, thick] {cos(deg(x))};
    \legend{$\sin(x)$, $\cos(x)$}
  \end{axis}
\end{tikzpicture}
\end{document}

```

コンパイル手順：

```bash
# まず図表ファイルをコンパイル
$ latexmk sine_cosine.tex

# 次に本文書をコンパイル
$ latexmk main.tex
```

コンパイルの仕上がりはtikzexternalizeと全く一緒だ．もしかしたら微妙に違うのかもしれないが，素人にはわからない．．．

{% include gallery id="gallery1" caption="左が本文書，右が独立に生成された図表" %}

### standaloneのメリット・デメリット

**メリット：**

- 図表を完全に独立したファイルとして管理できる
- 図表の修正・確認が容易（個別にコンパイル可能）
- 図表を他の文書でも再利用しやすい

**デメリット：**

- 図表ごとに別ファイルを作成・管理する必要がある
- 図表の更新を手動で行う必要がある
- 本文書と図表の間のクロスリファレンスが難しい

### 本文書と図表のレファレンス番号管理

先行研究の実験値をプロットに入れるなど図表中で参考文献の番号を入れたい場合がある．standaloneだとこれが少々むずかしいので，以下のような回避策を取る．

- メイン文書を正常にコンパイルできるよう，一回図表をコンパイルしておく．
- 一回メイン文書をbibtex含めてコンパイルする．この時，必ず図表で入れたい参考文献をどこかで`cite` しておく．（通常これは含めるので大丈夫だと思うが．．．）
- 図表ファイルの方では，メイン文書をコンパイルした時に作成した`bbl`ファイルをinputすることで本文書と同一の参考文献番号を挿入する．

具体的な例で見てみよう．以下のような簡単な参考文献ファイル(`references.bib`)を準備する．

```latex
@article{example_reference,
  author  = {Doe, John},
  title   = {An Example Study},
  journal = {Sample Journal},
  year    = {2024},
  volume  = {10},
  pages   = {1--10}
}
```

本文書でこの文献を読み込む．この方法を使う場合，参考文献の読み込みは`biblatex` ではなく`bibtex` を使わないといけないが，大半の出版社はbibtexからのbblファイル作成しかサポートしていないのであまり大きな問題はないだろう．

```latex
\documentclass{article}

\usepackage{graphicx}
\usepackage{standalone}
\usepackage{lipsum}
\usepackage[numbers]{natbib} % ここが必要
\begin{document}

\section{Sample figure}

Please cite references in the main text like this~\cite{example_reference}．

\lipsum[10]

\begin{figure}[htbp]
  \centering
  \includegraphics[width=\linewidth]{sine_cosine.pdf}
  \caption{The sin and cosin functions.}
\end{figure}

\begin{figure}[htbp]
  % includestandaloneコマンドも存在し，これでもよみこめる．
  \centering
  \includestandalone[mode=image, width=\linewidth]{sine_cosine}
  \caption{The sin and cosin functions.}
\end{figure}

\bibliography{references}
\end{document}
```

図表ファイルからは本文書のbblを読み込み，通常通りに引用する．

```latex
\documentclass[tikz, border=10pt]{standalone}

\usepackage{pgfplots}
\pgfplotsset{compat=newest}
\usepackage[numbers]{natbib} % ここが必要

\begin{document}
\begin{tikzpicture}
  \begin{axis}[
    width=10cm,
    height=7cm,
    xlabel={$x$},
    ylabel={$y$},
    grid=both,
    legend pos=north west
  ]
    \addplot[blue, thick] {sin(deg(x))};
    \addplot[red, thick] {cos(deg(x))};
    \legend{$\sin(x)$, $\cos(x)$~\cite{example_reference}}
  \end{axis}
\end{tikzpicture}
\input{main.bbl} % 1回目のコンパイルでは存在しないファイルなのでコメントアウトする．
\end{document}

```

これで本文書と全く同じ引用番号を利用して文献を引用できる．

{% include gallery id="gallery2" caption="左が本文書，右が独立に生成された図表．いずれも[1]という形で文献が引用されているのがわかる．" %}

<aside>
🚫

注意点として，この方法を使う場合は投稿前最後にもう一回文献引用している図表を再コンパイルしないと，本文と図表で引用番号が違うという事態になる．私も何回かやらかしたのでこの点だけは要注意．

</aside>

## 両方法の比較と使い分け

| 機能/特性 | tikzexternalize | standalone |
| --- | --- | --- |
| 実装の容易さ | 既存文書への追加が容易 | 図表ごとにファイル分割が必要 |
| 図表の再利用 | やや難しい | 非常に容易 |
| 図表と本文の一体管理 | 容易 | やや難しい |
| 大規模文書での管理 | 複雑になりうる | 整理しやすい |

使い分けのポイントは以下のとおりである：

- **tikzexternalizeが適しているケース**
  - 既存の文書に後から導入する場合
  - 本文と図表を一つのファイルで管理したい場合
  - 図表の自動更新が重要な場合
- **standaloneが適しているケース**
  - 最初から図表を独立して管理したい場合
  - 図表を他の文書でも再利用する予定がある場合

## まとめ

本記事では、LaTeX論文における図表管理の効率化を目的として、tikzexternalizeとstandaloneパッケージの二つの方法を紹介した．どちらの方法も、tikz/pgfplotによる図表作成時のコンパイル時間を大幅に短縮できる効果的な手段である．
