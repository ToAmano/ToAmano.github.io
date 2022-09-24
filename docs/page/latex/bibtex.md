---
layout: default
title:  "bibtex"
date:   2022-09-04 10:03:40 +0900
categories: latex
---

bibtexとbiberでページを分けるかうまいことやらないと後々混乱しそう．．．

## 基本的な使い方

bibtexを使う場合，メインの文書ファイルに加えて参考文献のデータをまとめたbibliographyファイル(.bib)が必要．これはgoogle scholarから引っ張ってこれる他，zoteroなどの文献管理ソフトから作成できる．簡単な例は以下のようなものである．

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

このようなbibファイルを用意した上で，メインの文書は以下のようにする．

```latex
\documentclass{article}
\begin{document}

citation example. Einstein journal paper \cite{einstein}

\bibliographystyle{abbrvnat}
\bibliography{sample}
\end{document}

```

重要なのは以下の3点．

- `\bibliography`コマンドでbibファイルを指定する．このとき拡張子はいらない．
- `bibliographystyle`コマンドで参考文献の出力スタイルを指定．これは後述．
- 実際に文中で引用する時は`\cite`コマンドで引用する．この時の引数はbibファイルの1行目に書いてあるcitation keyと呼ばれるもの．（今回の例だと@article{の後のeinsteinがそれ．）


## 参考文献の表示スタイルの変更

参考文献の表示を変更したい場合，`natbib`パッケージが使える．

https://www.reed.edu/cis/help/LaTeX/bibtexstyles.html
https://qiita.com/convolm/items/8a1f2a3028df5bbdea16

https://tex.stackexchange.com/questions/429277/how-to-get-same-citation-numbering-in-two-standalone-documents-with-same-bibliog

https://qiita.com/shiro_takeda/items/fac1351495f32c224a28

https://fock.hatenablog.com/entry/biblatex

https://qiita.com/shiro_takeda/items/81f2c50c28eccbec08be

引用部分のスタイル（citation style、引用スタイル）」と「参考文献部分のスタイル（bibliography style、参考文献スタイル）

## bibtexの仕組み（？）

<!-- https://tex.stackexchange.com/questions/99726/how-tell-latex-to-use-existing-bbl-file-without-running-bibtex -->
