---
layout: default
title:  "LaTeXトップページ"
date:   2022-09-04 10:03:40 +0900
categories: latex
---

# LaTeX各種設定


## 環境設定

TeXを利用するための環境設定としては，TeX自体のインストール・パスの設定が必須だが，加えて快適に文書を作成するにはエディターの設定も必要である場合が多い．

1. MacTeXのinstall(nessesary)
これはhomebrewを利用するか，DMGファイルをダウンロードしてくるかのどちらでも良い．homebrewを利用する場合は以下のコマンドで良いが，かなり時間がかかるので注意．
```bash
brew install --cask mactex
```
mactexは同時にLaTeXITやTeXShopなどのGUIアプリケーションもインストールする．これらを利用しないという場合は
```bash
brew install --cask mactex-no-gui
```
でも良い．個人的には数式の画像を作成してくれるLaTeXITがスライドの作成などで便利なので全てインストールしている．

MacTeXの特徴として，
```bash
/usr/local/texlive/2022
```
のようにバージョンの出た年ごとにディレクトリを掘ってインストールされるので，過去のバージョンとconflictを起こさないようになっている．

1. パスを通す(nessesary)





1. latexmk(option)
latexmkとはTeXからPDFファイルを作成するまでの流れを自動で行ってくれるもの．例えばTeX文書が参考文献を含む場合にはPDFファイルを作成するには複数回コンパイルが必要であるが，latexmkはこの複数回のコンパイルをコマンド一つで自動でやってくれる．コマンドはMacTeXのインストールで自動で入っているが，`.latexmkrc`という設定ファイルをホームディレクトリに設置する必要がある．TeXコンパイラとして何を利用するかで設定が異なる．

<!--http://www2.yukawa.kyoto-u.ac.jp/~koudai.sugimoto/dokuwiki/doku.php?id=latex:latexmk%E3%81%AE%E8%A8%AD%E5%AE%9A
-->
<!-- https://sites.google.com/site/lifeslash7830/home/tex/latexmkdeshittashedingnitsuite -->


<!-- https://sites.google.com/site/lifeslash7830/home/tex/lualatexwoshittemiru -->


## predifinedな変数
https://cns-guide.sfc.keio.ac.jp/2001/11/5/1.html



## 図の作り方
もちろんpythonなどで作成した図をincludegraphicsで取り込んでも良いが，文字のサイズなどをLaTeX文書と一緒に扱いたい場合はグラフ自体をLaTeX内で作成した方がよい．本節ではその方法についてまとめる．LaTeXで図を作成する方法はいくつかあって，LaTeXのパッケージであるTikz/PGFを利用する方法や，外部コマンドの力を借りるasymptote環境，gnuplot環境を利用する方法がある．


ファイルに入ったデータをプロットしたい場合は，pgfplotsを利用する．
[pgfplotsの使い方](pgfplots.md)


### 色を変えたい場合

defaultだと基本的な色しか使えないが，中にはyellowなど蛍光色で見にくい色がある．グラフの見やすさなどの観点で違う色を使いたい場合，基本的な方法は[xcolorパッケージ](https://www.ctan.org/pkg/xcolor)
を利用する方法．
```
# 基本の19色
\usepackage{xcolor}

# dvipsnamesオプション付きで読み込むと追加の色を使える
\usepackage[dvipsnames]{xcolor}
```


### gnuplotとtikzの連携
https://qiita.com/satl/items/0c11c8808b43f806ee21

https://geniusium.hatenablog.com/entry/2018/09/16/114600


### 結晶構造のグラフを作る
VESTAソフトウェアを使うのも一案だが，asyを利用することで綺麗な図が作成できる．
https://tex.stackexchange.com/questions/141363/draw-realistic-3d-crystal-structures-diamond

[asymptote公式マニュアル](https://asymptote.sourceforge.io/asymptote.pdf)


## スライド資料を作成する．
スライド資料を作るdocumentclassとして，beamerがある．
<!-- https://qiita.com/sh05_sh05/items/3d7ea00c97971de15851
https://risa.is.tokushima-u.ac.jp/~tetsushi/howtomakeslides.pdf
-->

## minipage
<!-- 
https://texblog.org/2007/08/01/placing-figurestables-side-by-side-minipage/
-->

## githubでの文書管理
https://zenn.dev/junkato/articles/github-actions-to-generate-pdfs-for-pages



## 化学式を描く
<!-- https://aprikose.sumomo.ne.jp/madchemiker/latex/chemfig/chemfig1/ -->
TikZをベースとした`chemfig`パッケージがある．
```tex
% ベンゼンの例
\usepackage{chemfig}
\chemfig{*6(-=-=-=)} 
```



- subfloatやsubcaptionから(a)，(b)を消す
<!-- https://tex.stackexchange.com/questions/165508/remove-a-b-from-subfigure-numbering-but-keep-the-subfigure-caption -->