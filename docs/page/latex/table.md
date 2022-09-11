



ここの記述はほとんど以下のoverleafのページの写経．テーブル関連でやりたいことがある場合はまずは以下のページを参照するとよい．

[overleafの解説ページ](https://ja.overleaf.com/learn/latex/Tables)


```latex
\begin{center}
\begin{tabular}{ c c c }
 cell1 & cell2 & cell3 \\ 
 cell4 & cell5 & cell6 \\
 cell7 & cell8 & cell9
\end{tabular}
\end{center}
```



## 見た目の調整

- 表の行間を調整する

	デフォルトだと

	```latex
	\renewcommand{\arraystretch}{1.8}
	% 表をかく
	\renewcommand{\arraystretch}{1}
	```


