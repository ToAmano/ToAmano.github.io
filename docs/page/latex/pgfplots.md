---
layout: default
title:  "tikz/pgf"
date:   2022-09-04 10:03:40 +0900
categories: latex
tags:
- tikz
- pgfplot
---

とりあえず参考になるurlの列挙だけ．

[公式のマニュアル](https://tikz.dev/)


## 基本的な使い方


```latex
\documentclass{article}

\usepackage{tikz,pgfplots,pgfplotstable} % 基本となる3つのパッケージ

\pgfplotsset{compat = newest}

\begin{document}
    \begin{tikzpicture}
        \begin{axis}[
            xmin = 0, xmax = 30,
            ymin = -1.5, ymax = 2.0,
            xtick distance = 2.5,
            ytick distance = 0.5,
            grid = both,
            minor tick num = 1,
            major grid style = {lightgray},
            minor grid style = {lightgray!25},
            width = \textwidth,
            height = 0.5\textwidth,
            xlabel = {$x$},
            ylabel = {$y$},
            legend cell align = {left},
        ]
            \addplot[
                domain = 0:30,
                samples = 200,
                smooth,
                thick,
                blue,
            ] {exp(-x/10)*( cos(deg(x)) + sin(deg(x))/10 )};

            \addplot[
                smooth,
                thin,
                red,
                dashed
            ] file[skip first] {cosine.dat};
           \legend{Plot from expression, Plot from file}
        \end{axis}
    \end{tikzpicture}
\end{document}
```

https://bombrary.github.io/blog/posts/tikz-note01/

https://mathlandscape.com/latex-color/
https://konoyonohana.blog.fc2.com/blog-entry-97.html

https://latexdraw.com/plot-a-function-and-data-in-latex/

### フォントの大きさを変える．
https://tex.stackexchange.com/questions/107057/adjusting-font-size-with-tikz-picture


### p in pを作る．
scope環境を利用して作ることができる．

https://tex.stackexchange.com/questions/124453/connecting-subplots

### Legendを消す
https://tex.stackexchange.com/questions/14506/pgfplots-prevent-single-plot-from-being-listed-in-legend

https://tex.stackexchange.com/questions/6114/hide-tick-numbers-in-a-tikz-pgf-axis-environment
yticklabels


### ファイルのパスを追加する

プロジェクトで複数のディレクトリを利用している場合，standaloneクラスの文書とメインの文書でpathが異なる場合がある．この場合，`\pgfplotsset`コマンドでファイルのパスを追加できる．

```latex
    \pgfplotsset{
        table/search path={plots/data},
    }
```

### 複数の図を入れる
https://tex.stackexchange.com/questions/457844/align-two-tikz-pictures-vertically-in-standalone-environment




## 色を変える
defaultだと基本的な色しか使えないが，中にはyellowなど蛍光色で見にくい色がある．グラフの見やすさなどの観点で違う色を使いたい場合，基本的な方法はxcolorパッケージを利用する方法．
```
# 基本の19色
\usepackage{xcolor}

# dvipsnamesオプション付きで読み込むと追加の色を使える
\usepackage[dvipsnames]{xcolor}
```

https://mathlandscape.com/latex-color/
https://konoyonohana.blog.fc2.com/blog-entry-97.html


### フォントの大きさを変える．
https://tex.stackexchange.com/questions/107057/adjusting-font-size-with-tikz-picture


### p in pを作る．
scope環境を利用して作ることができる．

https://tex.stackexchange.com/questions/124453/connecting-subplots


### 矢印

https://latexdraw.com/exploring-tikz-arrows/

### 参考文献
#### 全体的なことに関して
[基本的なこと1](https://bombrary.github.io/blog/posts/tikz-note01/)

[gnuplotとの連携](https://aprikose.sumomo.ne.jp/madchemiker/latex/figures-with-comments/)

[pgfplotsマニュアル](http://pgfplots.sourceforge.net/pgfplotstable.pdf)

[tikz+minipage](https://atatat.hatenablog.com/entry/cloud_latex27_tikz_layout)%


## compileをスピードアップする・グラフの作成の外部化1:tikzexternalize

https://tex.stackexchange.com/questions/45/how-to-speed-up-latex-compilation-with-several-tikz-pictures
<!--
Whenever you'd use a tikzpicture environment or a \tikz macro, give your picture a suggestive name, say riemann_sum, put the TikZ code in a single standalone document (with some boilerplate such that it matches the style of your main document. For example we don't want Computer Modern in our pictures while the main document is typeset with Times or a 10pt/12pt font size clash) called riemann_sum_sag.tex and use \includepdf{riemann_sum_sag} instead. The goal is to not have a single picture being compiled when you run make without having modified a *_sag.tex file. If this is not possible because you need to \ref something inside a picture, then so be it, but try to keep that to a minimum and instead choose good captions or something.

You'll also notice that there is a rule for files matching *_input.tex. This is for splitting the project into multiple files which is of course always a good idea when doing large projects. The rule detects whether such a file has been modified, and if it has triggers a recompilation of the document. LaTeX's \includeonly feature might be a good companion to this.
-->

<!-- https://blog.miz-ar.info/2016/12/latex-and-output-directory/ -->
<!-- 
https://github.com/pgf-tikz/pgf/issues/932
https://tex.stackexchange.com/questions/360794/using-externalize-with-standalones-for-tikz-figures-output-directory-and-tik
https://tex.stackexchange.com/questions/183023/combining-beamer-tikz-externalize-and-standalone
https://aprikose.sumomo.ne.jp/madchemiker/latex/tikzexternalize/
-->

```latex
\documentclass{article}
\usepackage{tikz}
\usetikzlibrary{external}
\tikzexternalize[prefix=_tikz/]
\tikzexternalize
\begin{document}
\begin{tikzpicture}
  \draw (0,0) -- (1,0) -- (1,1) -- (0,1) -- cycle;
\end{tikzpicture}
\end{document}
```


## compileをスピードアップする・グラフの作成の外部化2::standaloneクラス


## グラフの外部化3::externalize
https://tikz.dev/library-external

## 解決方法がわかっていないこと

- subcaptionやminipageなどの分割を行う環境との相性がよくない．

  % % 注意 !! ここの二つのグラフはそのままlualatex --jobnameコマンドを使ってもうまく図が生成されない．．．
  % % 全体的にonecolumngrid+minipageとpgfplotsの組み合わせがよくない気がする．
  % % 一旦minipageをコメントアウトしてからlualatexを実行するとまあ悪くない図が得られる．

- semilogyaxisとaxis環境で作られる左側の余白が異なる．
  
  これは別に気にしなければそのままで良いと思う．
  ```latex

  ```

  図表のサイズ(軸ラベルを含まない四角く囲まれた部分)は同じだが，左側のラベルを含む余白の大きさが異なる．semilogyaxisの方が余白が大きく，普通に並べると揃わない．とりあえずの解決策としては後からpdfを編集するか，standaloneクラス+tikzオプションを利用する．
  
  システマチックにできるのはstandaloneクラスを使う方法．これはグラフの幅はある程度同じになるように指定しておかないといけない．しかしstandaloneクラスで図を作ると余白はなくなるものの引用の番号がおかしくなってしまうという新しい問題が発生する．．． これを解決するにはstandaloneクラスの文書に直接メインファイルのbblファイルをインポートすることで一応対応できる．

  ```latex
  \input{main.bbl}
  ```
  対処療法だけどとりあえずはこれで．．．

  追記::biblatexではなくてnatbibを利用する場合，standaloneの方でnatbibのstyleを指定しないとまずい？ (revtexはnatbibなので．．．）

  ```latex
  \usepackage[numbers]{natbib}
  本文
  \input{main.bbl}
  ```


- 図表のサイズ指定
  
  [APSのマニュアル](https://journals.aps.org/prl/authors)によると横幅は8.6cmにするべき？ これがおそらく2カラム組の場合の1カラム幅に対応しているのだろう．これもstandalone環境だとうまくいっているように見える．




https://tex.stackexchange.com/questions/480910/pgfplots-how-to-align-plot-width-to-same-width-as-legend


https://tex.stackexchange.com/questions/301594/scale-only-axis-only-for-one-axis

https://tex.stackexchange.com/questions/528695/pgfplots-how-to-get-values-of-width-and-height-of-axis-rectangle

https://tex.stackexchange.com/questions/192424/pgfplots-single-legend-in-a-group-plot

https://tex.stackexchange.com/questions/131446/common-label-for-a-groupplot

https://tex.stackexchange.com/questions/169433/pgfplots-relative-node-positioning-in-axis-cs

https://tex.stackexchange.com/questions/136836/dashed-axis-lines