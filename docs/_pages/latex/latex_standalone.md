---
 layout: single
 title:  "LaTeX standaloneクラス"
 date:   2022-09-04 10:03:40 +0900
 categories: latex
---


<!-- https://geniusium.hatenablog.com/entry/2022/03/16/200355 -->

standaloneクラスは図表を外部化する時に役立つ．外部化のメリットは図表だけを他の用途に使うことができたり，特にtikzの場合にコンパイルの時間を減らせることだろう．利用手順としてはまずstandaloneクラスで書かれた図表のファイルだけを先にコンパイルし，これを`\includestandalone`コマンドでメインのファイルから読み込む．図表読み込みの優先順位をコンパイルずみのpdf，texから再コンパイルと切り替えることができるので，通常の`includegraphics`や`input`に比べて柔軟に運用できるメリットがある．


## standaloneクラスを使って図表だけのpdfをつくる

単にstandaloneクラスを利用して図表を作ることも可能である．通常の`\documentclass{article}`では，pdfのサイズもA4になってしまうが，standaloneクラスを使うと図表の周囲の余分な余白を消してくれる．一例として，次の例では表だけのpdfを作成できる．こうやって作った図表をパワポなどで利用できるので便利だ．

```latex:table.tex
\documentclass{standalone} % これが必須


```

このファイルを単に以下のようにコンパイルするとtable.pdfという表ができる．このとき通常のlatex文書と違って，余白が全くなくなっていることがわかるだろう．

```bash
lualatex table.tex
```

## standaloneクラスで作成した図表を他の文書から読み込む

プロジェクトの中でstandaloneクラスを使いたい場合，メインファイルでstandaloneパッケージを読み込む必要がある．ここでは上で作ったtable.texを読み込むことを考えている．

```latex:main.tex
\documentclass{article}
\usepackage{standalone} % これが必須

\begin{document}
  
\end{document}
```

<!-- https://konoyonohana.blog.fc2.com/blog-entry-389.html -->
standaloneクラスの図表の横幅の制御について．standaloneクラスではデフォルトの横幅として`linewidth: 4.7747in`，`textwidth: 4.7747in`という特殊な値を用いている．このためtikzpictureなどの横幅をこれらの値を使って指定するとメイン文書（例えば2段組のrevtexだと`textwidth: 7.05826in`，`linewidth: 3.40457in`）と整合性が取れなくなる．そこで，完全な対処法ではないものの，standalone文書の方で`varwidth`オプションにメイン文書の`textwidth`の値を指定し，図表の横幅を`textwidth`で指定する．

```latex
\documentclass[varwidth=7.05826in]{standalone}

\begin{document}
\begin{tikzpicture}
\begin{axis}
[width=0.45\textwidth]
\end{axis}
\end{tikzpicture}
\end{document}
```

こういう煩わしさを回避するために本来は横幅を絶対値で指定するのが良いのかもしれない．例えばAPSは横幅8.6cmで図表を作るように指示している．

ちなみに，`textwidth`の値を知りたければ`layout`パッケージをロードして以下のようにすれば確認できる．（もっと良い方法があるかもしれない）

```latex
\documentclass{article}
\usepackage{layout}
\begin{document}
textwidth: \printinunitsof{in}\prntlen{\textwidth} % 単位がインチの場合
linewidth: \printinunitsof{in}\prntlen{\linewidth}
\end{document}
```


## 複数の図表を一つにまとめる．

<!--
https://tex.stackexchange.com/questions/329359/subcaption-formatting-changes-when-using-standalone-documentclass
https://texblog.org/2015/10/07/combining-sub-figures-to-a-single-figure-for-submission-to-journal/
-->

latex内で一つのfigure環境に複数の図表を含める場合，通常はsubcaptionパッケージを使って図表を整列させるが，あらかじめ複数の図表を一つのpdfにまとめたい場合もある．この場合，文中から(a)，(b)のようにrefでそれぞれの図を参照することはできなくなるが，図表の取り回しは簡単になる．

この場合にもstandaloneクラスが使える．`varwidth`オプションを指定するのがポイントで，このオプションをつけるとfloat環境を扱えるようになる．個人的にはさらに図表の幅を指定することをおすすめする．`varwidth`で指定された幅はtextwidthとして扱われる．

また，これは原因不明だが`caption`のオプションに`justification=centering`を指定しないとキャプションがセンタリングしてくれなかった．

```latex
\documentclass[varwidth=8.6cm]{standalone}

% subcaption class
\usepackage{subcaption}
\usepackage[labelformat=parens,justification=centering]{caption}
\usepackage{graphicx}

% minipage+subfloatを使う例
\begin{document}
\begin{figure}[]
\centering
\begin{minipage}[b]{0.45\linewidth}
\centering
\subfloat[][Test 1]{\includestandalone{test1}}
\end{minipage}
\begin{minipage}[b]{0.45\linewidth}
\centering
\subfloat[][Test 2]{\includestandalone{test2}}
\end{minipage}

\begin{minipage}[b]{0.45\linewidth}
\centering
\subfloat[][Test 3]{\includestandalone{test3}}
\end{minipage}
\begin{minipage}[b]{0.45\linewidth}
\centering
\subfloat[][Test 4]{\includestandalone{test4}}
\end{minipage}
\end{figure}

\end{document}
```

この例では`\includestandalone`を使ってstandaloneで作成した図を呼び込んでいる．こうやって運用すれば，一つにまとめる前の図も，まとめた後の図もpdfとして保持できるので，例えばまとめる前の図はパワーポイントで使いたい，というような場合にも柔軟に対応できる．

もう一つ例として比較的新しいsubcaptionブロック環境を使う例も示す．

```latex
 \documentclass[varwidth=8.6cm]{standalone}

 % subcaption class
 \usepackage{subcaption}
 \usepackage[labelformat=parens,justification=centering]{caption}
 \usepackage{graphicx}
 
\begin{document}
\begin{figure}[t]
\hfill
\centering
\begin{subcaptionblock}{0.45\linewidth}
\centering
\includegraphics[]{test1.pdf}
\subcaption{test1}
\end{subcaptionblock}\hfill
\begin{subcaptionblock}{0.45\linewidth}
\centering
\includegraphics[]{test2.pdf}
\subcaption{test2}
\end{subcaptionblock}\hfill
\begin{subcaptionblock}{0.45\linewidth}
\centering
\includegraphics[]{test3.pdf}
\subcaption{test3}
\end{subcaptionblock}\hfill
\begin{subcaptionblock}{0.45\linewidth}
\centering
\includegraphics[]{test4.pdf}
\subcaption{test4}
\end{subcaptionblock}\hfill
\end{figure}

\end{document}
```
