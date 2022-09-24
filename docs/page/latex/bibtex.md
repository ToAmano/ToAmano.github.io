---
layout: default
title:  "bibtex"
date:   2022-09-04 10:03:40 +0900
categories: latex
---

bibtexとbiberでページを分けるかうまいことやらないと後々混乱しそう．．．

## bibtexの基本的な使い方

bibtexを使う場合，メインの文書ファイルに加えて参考文献のデータをまとめたbibliographyファイル(.bib)が必要．これはgoogle scholarから引っ張ってこれる他，zoteroなどの文献管理ソフトから作成できる．簡単な例は以下のようなものである[^1]．

```latex:sample.bib
@article{einstein,
    author =       "Albert Einstein",
    title =        "{Zur Elektrodynamik bewegter K{\"o}rper}. ({German})
        [{On} the electrodynamics of moving bodies]",
    journal =      "Annalen der Physik",
    volume =       "322",
    number =       "10",
    pages =        "891--921",
    year =         "1905",
    DOI =          "http://dx.doi.org/10.1002/andp.19053221004"
}
```

一行目の`article`が文書種別を指定するタグで他に`book`などが利用可能．その後の`einstein`がcitation keyと呼ばれるもので，tex文書中からはこのcitation keyで文献を参照できる．その他の部分は説明しなくても直感的にわかりやすいと思う．このような`sample.bib`ファイルを用意した上で，メインの文書は以下のようにする．

```latex
\documentclass{article}
\begin{document}

citation example. Einstein journal paper \cite{einstein}

%Sets the bibliography style to UNSRT and imports the 
%bibliography file "sample.bib".
\bibliographystyle{unsrt} % 引用スタイルの指定
\bibliography{sample}        % bibファイル
\end{document}

```

重要なのは以下の3点．

- `\bibliography`コマンドでbibファイルを指定する．このとき**拡張子はいらない**．
- `bibliographystyle`コマンドで参考文献の出力スタイルを指定．このコマンドはプリアンブルに書いても良い．スタイルについては後述．
- 実際に文中で引用する時は`\cite`コマンドで引用する．この時の引数はbibファイルの1行目に書いてある`citation key`を利用する．

bibファイルが別のディレクトリにあってもよくて，その場合は`\bibliography{hoge/sample} `のようにすればよい．

## 参考文献の表示スタイルの変更

bibtexで表示スタイルを変更できるのは，「引用部分のスタイル（citation style、引用スタイル）」と「参考文献部分のスタイル（bibliography style、参考文献スタイル）である．

後者の`bibliography style`から説明する．論文や書籍によって参考文献の表示スタイルは異なるため，これに合わせて`bibliographystyle`コマンドで自分の好きなスタイルに変更できる．一例としてデフォルトでは`abbrv`，`acm`，`alpha`，`apalike`，`ieeetr`，`plain`，`siam`，`unsrt`などが利用可能で，他のスタイルを追加することもできる．

参考文献の引用スタイルを変更したい場合，`natbib`パッケージが使える．以下の例のようにプリアンブルで`\usepackage[option]{natbib}`として，オプション部分に細かいスタイルの指定を行う．

```latex
\documentclass{article}
\usepachage[square,numbers]{natbib} % ここを追加．
\begin{document}

citation example with natbib package. Einstein journal paper \cite{einstein}. we can use citet command to include auther in citation regardless of citation style like \citet{einstein}.

%Sets the bibliography style to UNSRT and imports the 
%bibliography file "sample.bib".
\bibliographystyle{unsrt} % 引用スタイルの指定
\bibliography{sample}        % bibファイル
\end{document}

```

詳しい各スタイルの詳細については[ここ](https://www.reed.edu/cis/help/LaTeX/bibtexstyles.html)が参考になるかも．APSスタイルの引用をやりたい場合は`apsrev4-2`スタイルを利用すれば良い．基本的にはデフォルトで入っていると思う．

また，`citet`コマンドを使うと引用スタイルに関わらず引用部分に名前を追加できるので便利．

## biber/biblatexの基本的な使い方

bibtexではなくてbiber/biblatexを使う場合も用意するbibファイルは同じだが，tex文書中での指定にやや違いがあるのでこちらで解説する．まずはbibtexのところで説明したものと全くおなじsample.bibファイルを用意する．メインのtex文書を以下のように作成する．

```latex
\documentclass{article}
\usepachage[backend=bibtex,style=unsrt]{biblatex} % ここを追加．
\addbibresource{sample.bib}           % 参考文献ファイル
\begin{document}

citation example with biblatex package. Einstein journal paper \cite{einstein}. 

% Here print bibliography
\printbibliography
\end{document}
```

重要なのは以下の3つ．

- `biblatex`パッケージを利用する．optionでスタイル(style)や処理系(backend)を指定可能．この例では処理系としてbibtexを利用，スタイルはunsrtになっている．詳しくは後述．
- 参考文献ファイルは`\addbibresource`コマンドでプリアンブルに書く．
- 参考文献を表示したい場所に`\printbibliography`コマンドをかく．

基本的にはこれでbibtexと同様に文書を作成できる．処理系（backend)としては`bibtex`のほか`biber`（公式推奨）を指定できる．どちらでも良いが，対応してコンパイル時のコマンドやlatexmkrcの設定を変える必要があるので注意しよう．

<!--
https://qiita.com/shiro_takeda/items/fac1351495f32c224a28
https://qiita.com/shiro_takeda/items/81f2c50c28eccbec08be
-->

bibtexでAPSスタイルの引用をする場合の指定方法も簡単に紹介する．これはbibtexで自分用のノートを作りたいけど引用スタイルはAPSにしておきたい場合には便利（本家APSはnatbibなのでこの方法は使えない．）単に`biblatex`のオプションとして以下の設定をするだけで良い．

```latex
\usepackage[style=phys,articletitle=false,biblabel=brackets,chaptertitle=false,pageranges=false]{biblatex}
```

## 脚注への引用方法

通常の文中での引用に加えて，`\footcite`コマンドをつかうと脚注に引用を加えることもできる．これは個人的な文書だとわざわざ参考文献のページまで文献を見に行かなくて良いので助かる他，プレゼンテーションをtexで作る場合にも同じスライドに文献情報が載るので向いている．この場合でも文末に参考文献リストが載るのは同様．プレゼンテーションの場合は参考文献と全く同じスタイルで出力される`\footfullcite`コマンドを利用するのがおすすめ．

| コマンド            | 意味  |
| --------------- | --- |
| `\footcite`     |     |
| `\footfullcite` |     |
|                 |     |

`footcite`と`footfullcite`の違いを見るには以下のような例を実行してみるとよい．

```latex
\documentclass{article}
\usepachage[backend=bibtex,style=unsrt]{biblatex} % ここを追加．
\addbibresource{sample.bib}           % 参考文献ファイル
\begin{document}

citation example with biblatex package. Einstein journal paper \footcite{einstein}. See deferences in footcite and footfullcite by Einstein journal paper \footfullcite{einstein}. 

% Here print bibliography
\printbibliography
\end{document}
```


## hyperrefを使って参考文献リストに飛べるようにする

hyperrefパッケージを利用すると，文献の引用番号をクリックすると参考文献リストまで飛べるようになる．さらに，bibファイルでurlの指定がされていれば，参考文献から外部サイトに飛ぶこともできる．文書を他の点で変更する必要はないが，naiga,hyperrefパッケージは一部のパッケージと競合することがあるので注意が必要だ．

```latex
\documentclass{article}
\usepackage[hyperref] % ここを追加
\usepachage[backend=bibtex,style=unsrt]{biblatex} 
\addbibresource{sample.bib}          
\begin{document}

citation example with hyperref and biblatex package. You can jump to bibliography by click citation number like Ref. \cite{einstein}. 

% Here print bibliography
\printbibliography
\end{document}
```

hyperrefのオプションはお好みで追加する．色に関しては個人的な好みで青で統一したいので

```latex
\usepackage[colorlinks=true,citecolor=blue,linkcolor=blue,urlcolor=blue]{hyperref}
```

としている．

## bibtexの仕組み（？）

<!-- https://tex.stackexchange.com/questions/99726/how-tell-latex-to-use-existing-bbl-file-without-running-bibtex -->

## 参考文献




[^1]: 今回はサンプルとしてbibファイルを自作したが，ほとんどの場合はgoogle scholarや他のソフトから自動で生成する場合がほとんどなので，自分でbibファイルを作ることはほとんどないと思う．