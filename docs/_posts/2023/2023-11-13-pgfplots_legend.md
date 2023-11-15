---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: tex pgfplotsでの凡例の指定方法について簡単に紹介
layout: single
date:   2023-11-14 21:00:00 +0900
categories: 
 - code
tags:
 - bash
 - emacs
description: pgfplotsで凡例の設定を行う際に頻出の項目を簡単に紹介する．
---

pgfplotsで凡例の設定を行う際に個人的頻出の項目を簡単に紹介する．より詳しい説明は公式ドキュメントも参照のこと．


## pgfplotsにおける凡例の見た目の設定

pgfplotsにおける凡例の設定は代表的なところではlegendの場所を指定する`legend pos`，凡例文字の左寄せや右寄せを指定する`legend cell align`，凡例を何×何で表示するかを決定する`legend columns`などがある．詳細はpgfplotマニュアルの`4.8.5 Legend Appearance`に記載がある．

```tex
legend pos = north east,
legend columns=3,
legend cell align=left,
```

これらは`legend style`でまとめて指定することも可能．

```tex
legend style={legend pos = north east, legend columns=3, legend cell align=left}
```

## 凡例の場所指定について

一番単純にやるには`legend pos`で指定する．これは凡例を四隅のどこに配置するかの指定で，例えば右上なら`north east`，左下なら`south west`のように方角で指定する．グラフ外に凡例を指定する場合は追加で`outer`を指定して

```tex
legend pos = outer north east,
```

のようにする．

さらに細かく自分で座標を指定したい場合は`at`コマンドで指定できる．この時の座標はグラフの左下が`(0,0)`，右上が`(1,1)`となる相対座標で，したがって1より大きい値を指定すればグラフ外に凡例を設定できる．このとき`anchor`で「どこの点がatの座標に対応するか」を指定する．例えば`anchor=center`なら凡例の中心点が`at`で指定した座標に対応する．

```tex
legend style={at={(0.5,1.12)},anchor=north}
```

## 凡例の透明度の指定

透明度は`opacity`で指定可能で，特に下地の透明度を`fill opacity`で，描画の透明度を`draw opacity`で，文字の透明度を`text opacity`で指定できる．

```tex
legend style={fill=white, fill opacity=1, draw opacity=1, text opacity=1},
```

## 凡例ごとに指定を変更する

例えばグラフの線は太さ`2`で書いたけど，凡例では太さ`4`でより太く見せたい，というような場合，`\addlegendimage`コマンドで細かく指定できる．このとき，`addplot`の方の凡例を表示しないようにするためにはオプションで`[forgot plot]`を指定する．以下に例を示す．

```tex
\documentclass{standalone}
\usepackage{pgfplots}
\pgfplotsset{compat=newest}
\begin{document}
\begin{tikzpicture}
    \begin{axis}
    \addplot+[forget plot] coordinates {(1,2) (2,1)};
\addlegendimage{line legend,green} % or mark=none?
\addlegendentry{Simulation}
\addlegendimage{line legend,blue}
\addlegendentry{Measurement}
\addlegendimage{green,mark=square}
\addlegendentry{Set 1}
\addlegendimage{blue,mark=o}
\addlegendentry{Set 2}
    \end{axis}
\end{tikzpicture}
\end{document}
```



## 参考文献

[Opacity of a legend fill in pgfplots - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/178732/opacity-of-a-legend-fill-in-pgfplots)
[pgfplots - How to modify the image of an legend entry - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/113749/how-to-modify-the-image-of-an-legend-entry)
