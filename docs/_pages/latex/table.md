---
layout: single
title:  "latex table"
date:   2022-09-04 10:03:40 +0900
categories: latex
---

ここの記述はほとんど以下のoverleafのページの写経．テーブル関連でやりたいことがある場合はまずは以下のページを参照するとよい．

[overleafの解説ページ](https://ja.overleaf.com/learn/latex/Tables)


## 基本的なtable/tabluar環境の使い方

tabularがtable本体を作る環境，table環境[^1]がその場所を確保するfloat環境である．table環境のオプションはfigure環境のオプションと同じで表の配置場所を決める．最小の例は以下のようなものである．

```latex
\begin{table}[!htb]
\centering
\caption{test table} % tableの場合，captionは上に来ないといけない！
\begin{tabular}{ccc}
 cell1 & cell2 & cell3 \\ 
 cell4 & cell5 & cell6 \\
 cell7 & cell8 & cell9
\end{tabular}
\end{table}
```

tabular環境内で表を作成する．一列の形式をどうするかを`{ccc}`で指定してある．これは横に3つの要素を並べるという意味で，`c`は要素を中央揃えにする．c (center)のほかにl (left)とr (right)が選択できる．例えば`{lcc}`とすれば左端の要素は左揃え，残りのふたつの要素は中央揃えになる．横方向の要素を増やしたければ`c`や`r`などの数を増やせばよい．次の行からは要素ごとに`&`で区切り，行末は`\\`で改行する．縦方向にはいくらでも続けることができる．

オプション部分についてはさらに以下のような各種の書式が利用可能で，これだけでかなり柔軟に表をいじることができる．


## 見た目の調整

- 表の行間を調整する

	デフォルトだと表の行間が狭すぎる．

	```latex
	\renewcommand{\arraystretch}{1.5}
	% 表をかく
	\renewcommand{\arraystretch}{1}
	```

- デフォルトだとtableとcaptionの間が狭すぎる．

	captionパッケージを使う．
	```latex
	\usepackage{caption} 
	\captionsetup[table]{skip=10pt}	
	```




[^1]: figure環境とのおおきな違いは，captionを打った時にFigureと表示されるかTableと表示されるかということ．
