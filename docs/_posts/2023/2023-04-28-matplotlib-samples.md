---
layout: single
title:  "pythonのmatplotlibでグラフを作るいくつかのサンプル"
date:   2023-4-28 21:00:00 +0900
categories: python
---

最近機械学習を扱うようになって，pythonを使ってデータ処理を行うことが増えてきました．今まではグラフを作成する際に，latexのpgfplotかgnuplotを使うことが多かったのですが，pythonだとmatplotlibを使ってそこそこ高品位なグラフを作ることができるということで，身内の発表程度だったら良いかな〜と感じています．

そこで今日は主に自分用に，いくつかグラフを描く際のサンプルコードを残しておこうというのが趣旨です．図表を作る目的はいくつかあって，自分用に残しておくものの他に，ディスカッション用の図表，対外発表用（ある程度綺麗な）の図表があります．それぞれに合わせたtipsなども書いていきたいです．

## matplotlibで描画する二つの方法

matplotlibで描画する方法は大きく二つあり，一つは`matplotlib.pyplot`の`plot`関数を使うシンプルな方法です．もう一つがオブジェクト指向で描画する方法で，`matplotlib.pyplot.figure`オブジェクトを使う方法です．前者は簡単にコーディングでき，後者は細かい設定ができるというのが強みで，私は極力後者を使うようにしています．そこで今日は基本的に後者のみ扱います．


## matplotlib.pyplot.figureの基本構造


## 関数のプロット

関数のプロットには`plot(x,y)`メソッドが使える．頻繁に使うオプションパラメータとしては

- 凡例のラベルを指定する`label`
- 線の幅を指定する`lw`
- 線の色を指定する`color`
- 透明度を指定する`alpha`
- 
が挙げられる．

```
import matplotlib.pyplot as plt

fig, ax = plt.subplots(figsize=(8,5),tight_layout=True) # figure, axesオブジェクトを作成

ax.plot(x, y, label="sample", lw=3)  # 描画


# 各要素で設定したい文字列の取得
xticklabels = ax.get_xticklabels()
yticklabels = ax.get_yticklabels()
xlabel=r'frequency [$\mathrm{cm}^{-1}$]'
ylabel="epsilon'' "
title="Dielectric function (liquid methanol)"


# 各要素の設定を行うsetコマンド
ax.set_xlabel(xlabel,fontsize=22)
ax.set_ylabel(ylabel,fontsize=22)

ax.set_title(title,fontsize=22 )

ax.set_xlim(0,4000)
ax.set_ylim(0,2)
ax.grid()

ax.tick_params(axis='x', labelsize=20 )
ax.tick_params(axis='y', labelsize=20 )


# ax.legend = ax.legend(*scatter.legend_elements(prop="colors"),loc="upper left", title="Ranking")

lgnd=ax.legend(loc="upper right",fontsize=20)
# lgnd.legendHandles[0]._sizes = [30]
# lgnd.legendHandles[0]._alpha = [1.0]


# plt.show()
fig.savefig("dielec_func_IR_0428_dt01.pdf", transparent=True)
# ax.show()
# fig.delaxes(ax)

```

## 散布図

散布図のlegendが

## ヒストグラム



