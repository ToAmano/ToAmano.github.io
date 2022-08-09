# gnuplot

## 軸の設定について

### ラベルがはみ出す
<!--https://ikarino99.hatenablog.com/entry/2014/08/25/170351-->
ラベルを大きくするとはみ出す場合がある．ラベルの場所はoffsetによって変更できる．これとグラフの左右上下の余白を設定することで解決できる．
```gnuplot
# ラベルの場所の設定
set xlabel offset 0,-1
set ylabel offset -2,0
# 余白の設定
set bmargin 6
set lmargin 11
```


## xとy軸で別々のデータを参照する．
https://gordiustears.net/multiple-data-file-refere-in-gnuplot/


## 全般
https://data-science.gr.jp/implementation/ida_gnuplot_basic_usage.html


## 複数のグラフを並べる
https://auewe.hatenablog.com/entry/2013/05/17/214956
