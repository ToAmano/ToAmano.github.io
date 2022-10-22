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


実際に論文や書籍でみる表のスタイルは，
 - 極力罫線を使わない
 - 表の上下に二重線
 - 最初の行だけ線で区切る
というもので，これは最も単純には以下のようにすれば実現できる．

```latex
\begin{table}[!htb]
\centering
\caption{test table} % tableの場合，captionは上に来ないといけない！
\begin{tabular}{ccc} \hline\hline　%表の上に二重線
      & Height & Weight \\ \hline  %要素名の下に線
Taro  & 175    & 60     \\
Jiro  & 180    & 70     \\ 
\hline\hline %表直下に二重線
\end{tabular}
\end{table}
```

あとは単位を付けたり，行間の調整を行なったりすれば実用に耐える表になる．



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

- 表の一部分のみに横線を入れる場合，`\cline`コマンドを使う．

- 表の直下に脚注を入れたい場合，`threeparttable`パッケージを使う．
<!-- https://qiita.com/kumamupooh/items/38795811fc6b934a950d -->
	```latex
	\usepackage{threeparttable} %プリアンブル

	\begin{table}[h]
	\begin{threeparttable} % table環境内にthreeparttable環境を設置
	¥caption{threeparttableのテスト}
	\begin{tabular}{ccc}
	cell1 & cell2 & cell3\tnote{1} \\  %tnodeで脚注を追加
	cell4 & cell5 & cell6 \\
    cell7 & cell8\tnote{2} & cell9
	\end{tabular}
	¥begin{tablenotes} % tabular環境直下にtablenotes環境を追加
	¥item[1] 脚注1
	¥item[2] 脚注2
	¥end{tablenotes}
	¥end{threeparttable}
	\end{table}
	```



[^1]: figure環境とのおおきな違いは，captionを打った時にFigureと表示されるかTableと表示されるかということ．
