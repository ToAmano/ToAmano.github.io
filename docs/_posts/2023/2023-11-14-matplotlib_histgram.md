---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: matplotlibの散布図やヒストグラムで，legendを見やすくする方法
layout: single
date:   2023-11-14 21:00:00 +0900
categories: 
 - code
tags:
 - bash
 - emacs
description: matplotlibで散布図やヒストグラムなどを作成していると，みやすさの観点で図中の点は透明度や点の大きさをいじりたい場合が出てくる．しかしながら，点を非常に小さくした場合，凡例の点まで一緒に小さくなってしまい，これでは見にくい，ということがある．そこで凡例のいじり方を調べたので今日はそれを紹介する．
---

matplotlibで散布図やヒストグラムなどを作成していると，みやすさの観点で図中の点は透明度や点の大きさをいじりたい場合が出てくる．しかしながら，点を非常に小さくした場合，凡例の点まで一緒に小さくなってしまい，これでは見にくい，ということがある．そこで凡例のいじり方を調べたので今日はそれを紹介する．

## テストデータ生成

例として散布図を取り上げるが，他のプロット種別でも良い．テスト用に以下のようなランダムデータを用意する．

```python
import random
data_x = np.array([random.random() for i in range(100)])
data_y = np.array([random.random() for i in range(100)])
```

## 散布図の作成

散布図の作成はスタンダードな以下のようなコードで実行する．大切なのは`scatter`での点サイズをパラメータ`s`で，透過率を`alpha`で指定すること．`alpha=1`が完全不透明．`alpha=0`が完全透明に対応する．ここを色々いじると図のみやすさが変わるが，同時にlegend中の点も連動して変化することがわかるだろう．

```python
import matplotlib as mpl
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(8,5),tight_layout=True) # figure, axesオブジェクトを作成

ax.scatter(test_x, test_y, label="test data", s=5, alpha=0.5) # 作図

# 各要素の設定を行うsetコマンド
xlabel="x label"
ylabel="y label"
ax.set_xlabel(xlabel,fontsize=22)
ax.set_ylabel(ylabel,fontsize=22)

ax.grid() # grid 表示

# 軸サイズ
ax.tick_params(axis='x', labelsize=20 )
ax.tick_params(axis='y', labelsize=20 )

# legend設定
lgnd=ax.legend(loc="upper right",fontsize=20)

# save figure
fig.savefig("scatter_figure_test.png",bbox_inches='tight')
```

## legendhandlesによる凡例変更

legendを変更するのにはいくつか方法があるようだが，ここでは`legendHandles`を使う方法を紹介する．[公式マニュアル](https://matplotlib.org/stable/api/legend_api.html)も参照のこと．legendHandlesは凡例の要素をまとめて保持しているオブジェクトで，プロットの数だけのリストになっている．以下で`legendHandles[0]`としているのは，この１つ目の要素を取り出していることになる．今回はプロットは一つだけなので要素はこの一つだけだが，他のプロットもある場合は`legendHandles`の全ての要素に対して変更が必要だ．

```python
lgnd=ax.legend(loc="upper right",fontsize=20)
lgnd.legendHandles[0]._sizes = 30 #サイズの変更
lgnd.legendHandles[0]._alpha = 1.0 #透過度の変更
```


## 参考

[python - Setting a fixed size for points in legend - Stack Overflow](https://stackoverflow.com/questions/24706125/setting-a-fixed-size-for-points-in-legend)