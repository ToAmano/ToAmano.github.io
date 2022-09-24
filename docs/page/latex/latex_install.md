---
layout: single
title:  "LaTeX installation"
date:   2022-09-04 10:03:40 +0900
categories: latex
---

## LaTeXのインストール（mac）


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



## latexmk (option)
   
latexmkとはTeXからPDFファイルを作成するまでの流れを自動で行ってくれるもの．例えばTeX文書が参考文献を含む場合にはPDFファイルを作成するには複数回コンパイルが必要であるが，latexmkはこの複数回のコンパイルをコマンド一つで自動でやってくれる．コマンドはMacTeXのインストールで自動で入っているが，`.latexmkrc`という設定ファイルをホームディレクトリ（かlatex文書があるディレクトリ）に設置する必要がある．TeXコンパイラとして何を利用するかで設定が異なる．

<!-- http://www2.yukawa.kyoto-u.ac.jp/~koudai.sugimoto/dokuwiki/doku.php?id=latex:latexmk%E3%81%AE%E8%A8%AD%E5%AE%9A
    
https://sites.google.com/site/lifeslash7830/home/tex/latexmkdeshittashedingnitsuite 

https://sites.google.com/site/lifeslash7830/home/tex/lualatexwoshittemiru 

https://konn-san.com/prog/why-not-latexmk.html

-->

lualatexを利用する場合の一例が以下．

```latex:.latexmkrc
#!/usr/bin/env perl
# tex options
# $biber        = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
# $bibtex       = 'bibtex %O %B';
# $makeindex    = 'mendex %O -o %D %S';

$latex            = 'platex -synctex=1 -halt-on-error';
$latex_silent     = 'platex -synctex=1 -halt-on-error -interaction=batchmode';
$bibtex           = 'bibtex'; # 
$dvipdf           = 'dvipdfmx %O -o %D %S';
$makeindex        = 'mendex %O -o %D %S';
$max_repeat       = 100;    # コンパイルのmax回数
$pdf_mode         = 4; # 0: none, 1: pdflatex, 2: ps2pdf, 3: dvipdfmx, 4: lualatex

# ----- tex options -----
$lualatex     = 'lualatex -shell-escape -synctex=1 -interaction=nonstopmode';
$pdflualatex  = $lualatex;
$pdflatex = 'lualatex %O -synctex=1 %S';

# ----- preview -----
# 
$pvc_view_file_via_temporary = 6;


## output directory
#$aux_dir          = "build/";
#$out_dir          = "build/";

# 
# $aux_dir           = "$ENV{HOME}/.tmp/tex/" . basename(getcwd);
# $out_dir           = $aux_dir;
```
