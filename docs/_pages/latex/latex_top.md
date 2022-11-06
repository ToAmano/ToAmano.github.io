---
layout: single
title:  "LaTeXトップページ"
date:   2022-09-04 10:03:40 +0900
categories: latex
---

数式などを美しく組版してくれるLaTeXの使い方に関するメモ書き．自分の環境としては，エディタとして`emacs`か`VsCode`，エンジンとして`lualatex`[^1]を利用し，コンパイルには`latexmk`を利用している．

ネット上の日本語文献としては[TeXwiki](https://texwiki.texjp.org/)が非常に参考になると思う．書籍としては自分は祖父からLaTeX2e美文書作成入門をもらって勉強したがまずはこれを読んでみると良いと思う．最近はなんと第8版になっているらしい．英語の文献としてはウェブ上でTeX文書を作成できる[overleafのHP](https://ja.overleaf.com/learn)に解説ドキュメントがおいてあってわかりやすい．一通り勉強してさらに細かいhowtoが知りたい場合はstackexchangeなどを漁ってみるとかなり勉強になるほか，パッケージの細かい利用方法がしりたければマニュアルを見るのが手っ取り早い．

LaTeXを利用すると大体以下のようなことができる．主にレポートやノート，論文の作成の観点から述べていく．

- 数式を書く
- 図表を作成する
- 図表のキャプションやレイアウトの調整
- 相互参照や参考文献


---
## 環境設定

まずはTeXをインストールする必要がある．[こちら]({% link _pages/latex/latex_install.md %})を参照．本文書の環境設定は断りがない限りこのページでおこなったものを利用している．


--- 

## 日本語対応

LaTexはそのままでは日本語が使えず，対応させるための専用のdocumentclassなどを利用する必要がある．ここではlualatexでの設定方法について書いておく．lualatexでは[`luatexja`](https://texwiki.texjp.org/?LuaTeX-ja)というパッケージが日本語対応をやってくれるのでこれを利用する．ただし，タイプセットにかなり時間がかかるという弱点があり，日本語文書を多用する場合は従来よく利用されているupTeXなどの方がよいかも．．．

```latex
\documentclass[unicode,12pt, A4j]{ltjsarticle}% 'unicode'が必要
\usepackage{luatexja}

% フォント指定する場合はこっち
% \usepackage[hiragino-pron,deluxe,expert,bold]{luatexja-preset}

% あとは欧文の場合と同じ
\begin{document}
こんにちは．これは日本語対応の文書です．
\end{document}
```

大切なのは以下の2点．

- documentclassで`ltjsarticle`を指定する．他に標準で`ltjarticle`，`ltjbook`, `ltjreport`，`ltjtarticle`，`ltjtbook`，`ltjtreport`，`ltjsbook`，`ltjsreport`，`ltjskiyou`が対応している．日本語用のドキュメントクラスの先頭に`lt`がついている．
- `\usepackage{luatexja}`でパッケージを読み込む．

`luatexja`にはさらに先進的なパッケージがいくつか存在し，たとえば`luatexja-preset`パッケージはフォントの指定ができるパッケージで，上の例ではヒラギノフォントを使うように指定してある．詳しいことはluatexjaのドキュメントpdfを参照．

## 基本的な使い方
### 数式の挿入，数学記号など

数式の挿入は文中，または独立した環境内どちらでも可能．文中に挿入する場合は$$で囲み，独立した環境としてはデフォルトで`equation`環境が用意されている．これらの環境の中ではギリシャ文字や数学記号などのコマンドを利用できる．デフォルトの状態でも数多くの数学記号が定義されているが，さらに追加で使うと便利なパッケージに`amsmath`や`physics`環境がある．くわしくは[数式に関する記述]({% link _pages/latex/latex_equation.md %})を参照．


### 箇条書き

LaTeXでは箇条書き用の環境も標準で用意されている．自分の場合は通常の文書で使うことは少ないのだが，後述のスライドショーでは頻繁に用いる．詳細は[こちら]({% link _pages/latex/latex_item.md %})を参照．
<!-- http://www.yamamo10.jp/yamamoto/comp/latex/make_doc/item/item.php -->



### 表や図の挿入

latexでは図と表を配置するための専用のfigure環境とtable環境が用意されている．基本的にこれらの環境は図表用の場所を用意するだけで，中身についてはまた他の環境を利用する．表の作成はtablular環境でかなり容易に行うことができる一方，図の作成のための代表的な環境であるtikz環境はなかなか思い通りの図を作るのには時間がかかる印象がある．もちろん，図はgnuplotなどの他のツールで作成したものを挿入することもできる．

図の挿入に関して個人的に苦戦するポイントはおよそ以下の3点に集約される．

-  図の場所はLaTeXが自動で決めるのだが，これがあまり賢くない．
-  captionのスタイル調整
-  図表を複数並べる時の余白などの調整

tabular+table環境を利用した表の作り方については[ここ]({% link _pages/latex/table.md %})を参照．figure環境を利用した基本的な図表の挿入方法については[ここ]({% link _pages/latex/insert_figure.md %})を参照．図の作成については記述することも多いので後述．


### 図の作り方

もちろんpythonやgnuplotなどで作成した図をincludegraphicsで取り込んでも良いが，文字のサイズなどをLaTeX文書と一緒に扱いたい場合はグラフ自体をLaTeX内で作成した方がよい．本節ではその概要についてまとめる．LaTeXで図を作成する方法はいくつかあって，LaTeXのパッケージであるTikz/PGFを利用する方法や，外部コマンドの力を借りるasymptote環境，gnuplot環境を利用する方法がある．自分の場合は基本的にはTikz/PGFの利用から考えて，やりたいことが実現できないなら他を当たるというようにしている．tikz/pdfplotに関する詳細は[別ページ]({% link _pages/latex/pgfplots.md %})を参照．

外部コマンドを利用する場合，一番手っ取り早いのはgnuplotと思う．一旦gnuplotでtikzファイルを作成し，そのtikzファイルをlatexに読み込む方法か，latex内でgnuplot環境を利用する方法が使える．他にpythonを利用する人はmatplotlib+tikzという組み合わせも利用できる．asymptoteはこれらに比べるとドキュメントが充実していないが，環境光を利用した作図ができるので立体図形などの綺麗なグラフィックを作る時（例えば結晶構造とか）には非常に有効．

<!--
https://qiita.com/satl/items/0c11c8808b43f806ee21
https://geniusium.hatenablog.com/entry/2018/09/16/114600
https://unity-yuji.xyz/latex-subcaption-subfigure-ref-parenthesis/
-->


### 色を変えたい場合

defaultだと基本的な色しか使えないが，中にはyellowなど蛍光色で見にくい色がある．グラフの見やすさなどの観点で違う色を使いたい場合，基本的な方法は[xcolorパッケージ](https://www.ctan.org/pkg/xcolor) を利用する方法．
```
# 基本の19色
\usepackage{xcolor}

# dvipsnamesオプション付きで読み込むと追加の色を使える
\usepackage[dvipsnames]{xcolor}
```

### 結晶構造の図を作る

VESTAソフトウェアなどの既存ソフトを利用することもできるが，公開文書用に自分で色々手を加えたい場合，asymptoteを利用することで綺麗な図が作成できる．
<!--
https://tex.stackexchange.com/questions/141363/draw-realistic-3d-crystal-structures-diamond
https://tex.stackexchange.com/questions/306846/draw-a-3d-srtio3-structure
https://tex.stackexchange.com/questions/554769/how-to-draw-an-arrow-over-a-rod-in-crystal-structure
-->
[asymptote公式マニュアル](https://asymptote.sourceforge.io/asymptote.pdf)


## 参考文献の処理：bibtex/biblatex

<!-- 
https://gist.github.com/Yarakashi-Kikohshi/986bb23547866e32c8916b81099a470a 
https://tex.stackexchange.com/questions/25701/bibtex-vs-biber-and-biblatex-vs-natbib
https://tex.stackexchange.com/questions/12175/biblatex-submitting-to-a-journal
-->

参考文献を処理するツールとしてbibtexというツールが用意されている． 参考文献の番号などの処理を自動でやってくれるのである程度以上大きい文書ではほぼ必須と思う．以下の3つのバリエーションがよく利用されている．

| プログラム |                     | 利用できるパッケージなど |
|------------|---------------------|--------------------------|
| BibTeX     | 古くからある        | natbib                   |
| upBibTeX   | 和文用              |                          |
| biber      | 完全なunicodeを提供 | biblatex                 |

基本的には`biber`が最も新しいのでこれを使っていれば問題ないのだが，論文投稿の際にジャーナルによってbibtexだったりするので使い分ける必要も生じる．細かい使い方については[こちらのページ]({% link _pages/latex/bibtex.md %})を参照．


## スライド資料を作成する．

LaTeXではスライドショーを作成することもできる．スライド資料を作る専用のドキュメントクラスとして`beamer`がある．試しに以下のようなサンプルを用意した．

```latex

```








## githubでの文書管理
<!-- https://zenn.dev/junkato/articles/github-actions-to-generate-pdfs-for-pages -->



## 化学


- 化学式を描く

簡単な化学式であれば`mhchem`パッケージがある．
```tex
^usepackage{mhchem}
\ce{H2O}
```



- 化学式を描く
<!-- https://aprikose.sumomo.ne.jp/madchemiker/latex/chemfig/chemfig1/ -->
TikZをベースとした`chemfig`パッケージがある．
```tex
% ベンゼンの例
\usepackage{chemfig}
\chemfig{*6(-=-=-=)} 
```

## 単位をシステマチックに書く

単位を書くときには数字との間にスペースが必要，ローマン体（立体）でないといけないなどの細かい習慣があって意外と普通にlatex文書を書くのは面倒くさい．例えば以下のようにする必要がある．

```latex
\begin{document}
単位と数字の間にはスペースが必要で，数式環境内だと通常のスペースは無視されてしまうために$1\,\mathrm{m}$のように明示的にスペースを入れる必要がある．また，単位はローマン体，変数はイタリックという決まりがあるので，いちいちmathrmかtextで修飾しないといけない．
```

このような面倒を回避するため，またタイポを避けるために`siunitx`パッケージを利用するのが良い．このパッケージは名前の通りSI単位の記述に重きをおいたパッケージだが，それ以外の単位系でも利用できるので自分は単位についてはこのパッケージを使うことで統一している．使い方については[別途ページ]({% link _pages/latex/siunitx.md %})を用意したのでそちらを参照．


## 数式や図表の相互参照について

参照をよりスマートにやるために`cleveref`というパッケージがある．これを使えばいままで`Fig. \ref{fig:test}`と参照していた部分を`\cref{fig:test}`と書くだけでよくなる．つまり`\ref`している環境がfigureか，tableかなどを見極めて勝手に`Fig.`，`Table.`などと補完してくれる．人間の手でやっているとどうしてもミスが発生しやすいので，特に理由がなければ使うことをおすすめしたい．

<!-- https://qiita.com/wktkshn/items/110cd6007837938e6c88 -->
<!-- https://blog.miz-ar.info/2021/01/alternatives-to-autoref/ -->


## predifinedな変数
https://cns-guide.sfc.keio.ac.jp/2001/11/5/1.html


## プロジェクトでのファイル管理（ファイルの分割など） 

ディレクトリ構成：
ファイル分割: \inputコマンド，subfileクラス，standaloneクラス

プログラミングと同様，文章が大きくなってくるとそれを分割したくなってくる．たとえば論文ならintro.texとtheory.texは別々のファイルになっていれば管理が楽だ．latexにはそれをサポートする機能やパッケージがいくつか用意されていてこの目的を達成することができる． [overleafのマニュアル](https://ja.overleaf.com/learn/latex/Multi-file_LaTeX_projects)も参考になる．

簡単な例として以下のようなディレクトリ構成の文書を考える．`main.tex`がコンパイルするべきファイルで，sectionsディレクトリに分割した文章がはいっている．

```bash
|
|- main.tex
|
|- sections/
      |- 01.tex
      |- 02.tex
```

ファイルを分割する最も簡単な方法は`\input`コマンドを利用すること．メインファイルから以下のようにサブファイルを読み込める．この時パスの設定には注意が必要で，コンパイルするファイル（ここだとmain.tex）からの相対パスで指定する．複数のファイルが入れ子になっている場合でも，コンパイルするファイル（これは一つだけ！）からのパスで指定する必要がある．

```latex:main.tex
\documentclass[a4]{article}

\begin{document}
  %% 目次
  \tableofcontents

  %% 本文
  \input{sections/section01.tex}
  \input{sections/section02.tex}

  %% 文献
  \bibliographystyle{junsrt}
  \bibliography{mybib}
\end{document}
```


- 図表の外部化
  文書ではなく図表の外部化も重要．特にTikzを使って図を作る場合，コンパイルのたびにtikzで図を再コンパイルしていたら時間がかかって仕方がない．この自体を回避するため，tikzの図はそれ単体で先にコンパイルしてpdf化しておいて，メインのTeX文書からはpdfを読みこむようにする．この仕組みを実現する方法としては，個人的におすすめな`standalone`クラスを利用する方法と，tikzに付属する`tikzexternalize`がある．後者は自分の環境ではどうも挙動が安定しないことが多い．standaloneクラスについては[こちら]({% link _pages/latex/latex_standalone.md %})を参照．

- 分割したファイルをまとめる方法．
<!--https://zenn.dev/ultimatile/articles/b3fbd4ec65373d -->
	論文投稿の際には分割したファイルを再度まとめたい場合がある．手でやるのは大変なので，`latexpand`コマンドか`texdirflatten`コマンドを利用する．homebrewでmactexを入れた場合にはこれらのコマンドも既にインストールされているはず．
	```bash
	# latexpandを使う場合．こちらはメインファイルだけsubmit.texに展開する．
	latexpand input.tex > submit.tex
	
	# texdirflattenを使う場合．こちらは依存ファイル（図表ファイルなど）を全てsubmitディレクトリ以下にコピーする．
	texdirflatten -1 -f input.tex -o submit
	```

<!--

履歴書をlatexで：https://text.baldanders.info/remark/2018/11/resume-in-latex/
cover letterのためのクラスもある．

-->


<!--
LaTeXソースのinput path - はだメモ
https://scrapbox.io/hada/LaTeX%E3%82%BD%E3%83%BC%E3%82%B9%E3%81%AEinput_path
-->


## 参考文献

[投稿論文のためのテンプレート](https://sharelatex.psi.ch/templates/journals.1)
もちろん本当に投稿するときはちゃんとその雑誌の公式のテンプレートを用いるべし．TeXの勉強をする際の勉強になる．

[^1]: LaTeX文書はそのままではpdfに変換することができず，LaTeXエンジンと呼ばれるプログラムを実行する必要がある．このエンジンには色々種類があって難しいのだが，自分は近年登場したlualatexを利用している．以前はupLaTeXを利用していたのだが，これはtex文書を一旦DVI形式に変更し，さらにDVIからpdfへ変換するpdflatexを利用する必要があった．lualatexはtex文書から直接pdf文書を生成してくれるために煩わしさがないので気にいっている．一方でデフォルトでは日本語が使えなかったり，従来のエンジンに比べてコンパイルに時間がかかるといった欠点もある．

<!-- 
https://blog.miz-ar.info/2016/12/running-tex/
https://text.baldanders.info/remark/2015/luatex-ja/
-->
