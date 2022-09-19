---
layout: default
title:  "LaTeXトップページ"
date:   2022-09-04 10:03:40 +0900
categories: latex
---

数式などを美しく組版してくれるLaTeXの使い方に関するメモ書き．自分の環境としては，エディタとして`emacs`か`VsCode`，エンジンとして`lualatex`[^1]を利用し，コンパイルには`latexmk`を利用している．

ネット上の日本語文献としては[TeXwiki](https://texwiki.texjp.org/)が非常に参考になると思う．書籍としては自分は祖父からLaTeX2e美文書作成入門をもらって勉強したがまずはこれを読んでみると良いと思う．最近はなんと第8版になっているらしい．

英語の文献としてはウェブ上でTeX文書を作成できる[overleafのHP](https://ja.overleaf.com/learn)に解説ドキュメントがおいてあってわかりやすい．

---
## 環境設定

TeXを利用するための環境設定としては，TeX自体のインストール・パスの設定が必須．加えて快適に文書を作成するにはエディターの設定やビューワーも必要である場合が多い．以下ではmacにmactexをhomebrewでインストールする例を述べる．

1. MacTeXのinstall(nessesary)
   
    これはhomebrewを利用するか，DMGファイルをダウンロードしてくるかのどちらでも良い．homebrewを利用する場合は以下のコマンドで良いが，かなり時間がかかるので注意．

    ```bash
    brew install --cask mactex
    ```

    mactexは同時にLaTeXITやTeXShopなどのGUIアプリケーションもインストールする．これらのGUIツールを利用しないという場合は

    ```bash
    brew install --cask mactex-no-gui
    ```
    でも良い．個人的には数式の画像を作成してくれるLaTeXITがスライドの作成などで便利なので全てインストールしている．初心者はとりあえず全てインストールすることをおすすめする．

    MacTeXの特徴として，
    ```bash
    /usr/local/texlive/2022
    ```
    のようにバージョンの出た年ごとにディレクトリを掘ってインストールされるので，過去のバージョンとconflictを起こさないようになっているという利点がある．したがって現在の環境を壊さずに新しいバージョンのインストールを気軽に行える．

    以上で長いインストールが終わったら，コマンドが入っているかを確認する．`/usr/local/texlive/`以下のコマンドが反応すればインストールは完了だ．
    ```
    $ lulatex --help
    $ which lulatex
    ```

    latexのパッケージ管理ソフト`tlmgr`のアップデートもおこなっておく．
    ```bash
    sudo tlmgr update --self --all
    ```

1. latex文書が作成されるかのテスト
    
    以上でインストールは終了して，latex文書をpdfに変換できるようになった．ちゃんとlatexが動くかのテストとして以下のようなファイル`test.tex`を作成してみる．(注意::lualatexはデフォルトで日本語を受け付けない!)

    ```latex:test.tex
     \documentclass[a4]{article}
    \usepackage{blindtext}
    \title{Lualatex test}
    \begin{document}
    \maketitle
    Here you can add texts.

    \blinddocument
    \end{document}
    ```

    このファイルをpdf化するためにターミナルで
    ```bash
    lualatex test.tex
    ```
    と打つ．いくつかファイルが生成されるが，その中の`test.pdf`にLualatex testというタイトルで文書ができていれば成功だ．

    lulatexは遅いし使いたくない場合，uplatex+ptex2pdfの組み合わせを試す．以下のようなtext2.texを用意する．uplatexの場合は日本語でも大丈夫．

    ```latex:test2.tex
    \documentclass[a4j]{jsarticle}
    \usepackage{blindtext}
    \title{uplatex test}
    \begin{document}
    \maketitle
    みなさんこんにちは．uplatexのコンパイルテスト用のファイルです．
    \blinddocument
    \end{document}
    ```
    コンパイルするには二つのコマンドが必要．これでtest2.pdfというファイルが生成されていれば成功だ．
    ```bash
    # test2.dviファイルを作成
    $ uplatex test2.tex 
    # test2.pdfファイルを作成
    ptex2pdf -u -l test2
    ```
    ターミナルからやるとコマンドがいくつか必要で面倒くさいが，ちゃんとエディタの設定を行えばlualatexもuplatexもコマンド一つで簡単にコンパイルできるようになるので心配ない．

1. latexmk (option)
   
    latexmkとはTeXからPDFファイルを作成するまでの流れを自動で行ってくれるもの．例えばTeX文書が参考文献を含む場合にはPDFファイルを作成するには複数回コンパイルが必要であるが，latexmkはこの複数回のコンパイルをコマンド一つで自動でやってくれる．コマンドはMacTeXのインストールで自動で入っているが，`.latexmkrc`という設定ファイルをホームディレクトリに設置する必要がある．TeXコンパイラとして何を利用するかで設定が異なる．

<!-- http://www2.yukawa.kyoto-u.ac.jp/~koudai.sugimoto/dokuwiki/doku.php?id=latex:latexmk%E3%81%AE%E8%A8%AD%E5%AE%9A
    
https://sites.google.com/site/lifeslash7830/home/tex/latexmkdeshittashedingnitsuite 

https://sites.google.com/site/lifeslash7830/home/tex/lualatexwoshittemiru -->

---
## LaTeXでできることの概要

大体以下のようなことができる．主にレポートやノート，論文の作成の観点から述べていく．

- 数式を書く
- 図表を作成する
- 図表のキャプションやレイアウトの調整
- 相互参照や参考文献



## 数式の挿入，数学記号など

数式の挿入は文中，または独立した環境内どちらでも可能．文中に挿入する場合は$$で囲み，独立した環境としてはデフォルトで`equation`環境が用意されている．これらの環境の中ではギリシャ文字や数学記号などのコマンドを利用できる．

```latex
\documentclass[a4]{article}
\usepackage{blindtext}
\begin{document}
これがequation環境です．ギリシャ文字や分数などの数学記号もお手のもの．
\begin{equation}
  f(x)=\alpha x^2+\beta x +\gamma \\
  \frac{1}{x}=\sqrt{x} \\
  \sum_{n=0}^{\infty}\frac{1}{n^2}=
\end{equation}

文中に数式を入れることもできます．例えば$f(x)=\alpha x^2+\beta x +\gamma$のように．

文中と独立環境では，分数や総和記号などの表記が若干異なっている場合があります．
\blinddocument
\end{document}
```

デフォルトの状態でも数多くの数学記号が定義されているが，さらに追加で使うと便利なパッケージに`amsmath`や`physics`環境がある．くわしくは[数式に関する記述](latex_equation.md)を参照．


## 箇条書き

LaTeXでは箇条書き用の環境も標準で用意されている．ぶっちゃけ自分の場合は通常の文書で使うことは少ないのだが，後述のスライドショーでは頻繁に用いる．詳細は[こちら](latex_item.md)を参照．
<!-- http://www.yamamo10.jp/yamamoto/comp/latex/make_doc/item/item.php -->



## 表や図の挿入

latexでは図と表を配置するための専用のfigure環境とtable環境が用意されている．基本的にこれらの環境は図表用の場所を用意するだけで，中身についてはまた他の環境を利用する．表の作成はtablular環境でかなり容易に行うことができる一方，図の作成のための代表的な環境であるtikz環境はなかなか思い通りの図を作るのには時間がかかる印象がある．

図の挿入に関して個人的に苦戦するポイントはおよそ以下の3点に集約される．

-  図の場所はLaTeXが自動で決めるのだが，これがあまり賢くない．
-  captionのスタイル調整
-  図表を複数並べる時の余白などの調整

tabular+table環境を利用した表の作り方については[ここ](table.md)を参照．figure環境を利用した基本的な図表の挿入方法については[ここ](insert_figure.md)を参照．図の作成については記述することも多いので後述．


## 図の作り方

もちろんpythonやgnuplotなどで作成した図をincludegraphicsで取り込んでも良いが，文字のサイズなどをLaTeX文書と一緒に扱いたい場合はグラフ自体をLaTeX内で作成した方がよい．本節ではその概要についてまとめる．LaTeXで図を作成する方法はいくつかあって，LaTeXのパッケージであるTikz/PGFを利用する方法や，外部コマンドの力を借りるasymptote環境，gnuplot環境を利用する方法がある．自分の場合は基本的にはTikz/PGFの利用から考えて，やりたいことが実現できないなら他を当たるというようにしている．tikz/pdfplotに関する詳細は[別ページ](pgfplots.md)を参照．

外部コマンドを利用する場合，一番手っ取り早いのはgnuplotと思う．一旦gnuplotでtikzファイルを作成し，そのtikzファイルをlatexに読み込む方法か，latex内でgnuplot環境を利用する方法が使える．他にpythonを利用する人にはmatplotlib+tikzという組み合わせも利用できる．asymptoteはこれらに比べるとドキュメントが充実していないが，環境光を利用した作図ができるので立体図形などの綺麗なグラフィックを作る時（例えば結晶構造とか）には非常に有効．

<!--
https://qiita.com/satl/items/0c11c8808b43f806ee21
https://geniusium.hatenablog.com/entry/2018/09/16/114600
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
https://tex.stackexchange.com/questions/141363/draw-realistic-3d-crystal-structures-diamond

[asymptote公式マニュアル](https://asymptote.sourceforge.io/asymptote.pdf)


## 参考文献の処理：bibtex/biblatex

<!-- 
https://gist.github.com/Yarakashi-Kikohshi/986bb23547866e32c8916b81099a470a 
https://tex.stackexchange.com/questions/25701/bibtex-vs-biber-and-biblatex-vs-natbib
https://tex.stackexchange.com/questions/12175/biblatex-submitting-to-a-journal
-->

参考文献を処理するツールとしてbibtexというツールが用意されている． 参考文献の番号などの処理を自動でやってくれるのである程度以上大きい文書ではほぼ必須と思う．以下の3つのバリエーションがよく利用されている．

| プログラム | | 利用できるパッケージなど |
|---|---|---|
| BibTeX | 古くからある| natbib |
| upBibTeX | 和文用 | |
| biber    | 完全なunicodeを提供 | biblatex | 

基本的には`biber`が最も新しいのでこれを使っていれば問題ないのだが，論文投稿の際にジャーナルによってbibtexだったりするので使い分ける必要も生じる．

細かい使い方については[こちらのページ](bibtex.md)を参照．


## スライド資料を作成する．

LaTeXではスライドショーを作成することもできる．スライド資料を作るdocumentclassとして，beamerがある．
<!-- https://qiita.com/sh05_sh05/items/3d7ea00c97971de15851
https://risa.is.tokushima-u.ac.jp/~tetsushi/howtomakeslides.pdf
https://joker.hatenablog.com/entry/2014/10/18/222303
https://qiita.com/termoshtt/items/756aec542fb4c812a405
https://joker.hatenablog.com/entry/2014/10/18/222303
https://qiita.com/zr_tex8r/items/69e8cc32038ff29f5ac3
https://paper.hatenadiary.jp/entry/2017/01/10/031523
chrome-extension://efaidnbmnnnibpcajpcglclefindmkaj/http://m.sc.niigata-u.ac.jp/~prtana/digital/HowToBeamer.pdf
-->




## githubでの文書管理
https://zenn.dev/junkato/articles/github-actions-to-generate-pdfs-for-pages



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


## predifinedな変数
https://cns-guide.sfc.keio.ac.jp/2001/11/5/1.html



[^1]: LaTeX文書はそのままではpdfに変換することができず，LaTeXエンジンと呼ばれるプログラムを実行する必要がある．このエンジンには色々種類があって難しいのだが，自分は近年登場したlualatexを利用している．以前はupLaTeXを利用していたのだが，これはtex文書を一旦DVI形式に変更し，さらにDVIからpdfへ変換するpdflatexを利用する必要があった．lualatexはtex文書から直接pdf文書を生成してくれるために煩わしさがないので気にいっている．一方でデフォルトでは日本語が使えなかったり，従来のエンジンに比べてコンパイルに時間がかかるといった欠点もある．


## プロジェクトでのファイル管理（ファイルの分割など） 

ディレクトリ構成：
ファイル分割: \inputコマンド，subfileクラス，standaloneクラス

[overleafのマニュアル](https://ja.overleaf.com/learn/latex/Multi-file_LaTeX_projects)も参考になる．

```bash
|
|- main.tex
|
|- images
```

standaloneクラスは図表を外部化する時に役立つ．外部化のメリットは図表だけを他の用途に使うことができたり，特にtikzの場合にコンパイルの時間を減らせることだろう．利用手順としてはまずstandaloneクラスで書かれた図表のファイルだけを先にコンパイルし，これを`\includestandalone`コマンドでメインのファイルから読み込む．図表読み込みの優先順位をpdf，texから再コンパイルと切り替えることができるので，通常の`includegraphics`や`input`に比べて柔軟に運用できるメリットがある．

単にstandaloneクラスを利用して図表を作ることも可能である．例えば次の例では表だけのpdfを作成できる．こうやって作った図表をpowerpointできるので便利だ．

```latex:table.tex
\documentclass{standalone}
```

このファイルを単に以下のようにコンパイルするとtable.pdfという表ができる．このとき通常のlatex文書と違って，余白が全くなくなっていることがわかるだろう．

```bash
lualatex table.tex
```

プロジェクトの中でstandaloneクラスを使いたい場合，メインファイルでstandaloneパッケージを読み込む必要がある．ここでは上で作ったtable.texを読み込むことを考えている．

```latex:main.tex
\documentclass{article}
\usepackage{standalone}

```


## 参考文献

[投稿論文のためのテンプレート](https://sharelatex.psi.ch/templates/journals.1)
もちろん本当に投稿するときはちゃんとその雑誌の公式のテンプレートを用いるべし．TeXの勉強をする際の勉強になる．



<!-- 
https://blog.miz-ar.info/2016/12/running-tex/
https://text.baldanders.info/remark/2015/luatex-ja/
-->