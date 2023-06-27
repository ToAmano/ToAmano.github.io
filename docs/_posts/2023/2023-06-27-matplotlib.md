---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: jupyterで作った図表を管理する方法を考える
layout: single
date:   2023-6-27 21:00:00 +0900
description: 
---

最近pythonでコードを書くことが増えた．特にメインの計算はc++で実行し，その解析をjupyterでやるようなことが多い．jupyterは簡単に可視化できることや試行錯誤しやすいのが強みで計算結果の解析にはもってこいだと感じている．一方でgitで管理しにくいのがいちばんの問題だ．加えて試行錯誤がしやすいがゆえにためした結果が乱雑に溜まってしまい，後から見返したときに自分が何をやったかわかりにくいことが多い，今回は運用を改善するためのふたつの試みを紹介する．


## 1：解析を始めるときに日毎にディレクトリを掘る

図表があちこちにちらかるとよくないので，保存場所は予め決めておいた方がよいと考えている．私は日付のついたディレクトリを作成し，その下に保存するようにしている．ディレクトリはプロジェクトごとでもよいし，ノートブックごとでもよいと思う．ノートブックの上に以下の部分を貼って全てのノートブックでこれを実行する習慣をつけた．

```python
import datetime
import os

# 今日の日付を取得
dt_now = datetime.datetime.now()
datetoday = dt_now.strftime('%Y%m%d')  # yymmddの形に整形

# ディレクトリを作成
if not os.path.isdir(datetoday)
os.mkdir(str(datetoday))
```

## 2：matplotlibで生成するグラフに擬似的なcaptionをつける

matplotlibでグラフを作って貯めておくとき，後から見返してわかりやすいのはグラフにちゃんと一通りの情報が入っているのが一番よいと考えている．zoteroなどのpdf管理ツールに全てのグラフを突っ込んでメモを残すことも考えたが，jupyterだと簡単にグラフが作れて数が増えてしまい，その手の方法だと面倒くさい．そこである程度簡単にpdfに情報を残す手段としてmatplotlibに擬似的なcaptionを残すことにした．残念ながらmatplotlibにはcaptionをつけるメソッドは存在しないので，代替案として`fig.text`メソッドで画像上にテキストを残す．以下が簡単な例だ．

```python
import numpy as np
import matplotlib as mpl
import matplotlib.pyplot as plt
# 描画データとしてy=xを使う
x = np.arange(1000)
y = x

fig, ax = plt.subplots(figsize=(8,5),tight_layout=True) # figure, axesオブジェクトを作成

ax.plot(x, y, label="sample", lw=3)  # 描画

# 軸ラベル
xlabel="xaxis [m]"
ylabel="yaxis [m]"
ax.set_xlabel(xlabel,fontsize=22)
ax.set_ylabel(ylabel,fontsize=22)
# 軸グリッド
ax.grid()
ax.tick_params(axis='x', labelsize=20 )
ax.tick_params(axis='y', labelsize=20 )
# legendの設定
lgnd=ax.legend(loc="upper left",fontsize=20)
# ここ！！ テキストを追加
fig.text(0.5, 0.01, "The sample figure to show how to use pseudo-caption in matplotlib figure. \n \
    The two number indicate the x and y coordinate of the caption, respectively.", ha='center')
# 図表の保存
fig.savefig("sample.png", bbox_inches='tight')
```

最後の方で`fig.text(0.5,0.01,"text",ha="center")`としてあるのがそれで，最初の二つの数字は文字列の相対座標を表す．x軸0.5は図表のx軸真ん中にテキストを配置することを表していて，固定でよい．一方y軸の値は-0.1から0.1くらいで軸と被らないように微調整が必要だ．また図表の保存のところでは`bbox_inches='tight'`と指定するのがポイントで，基本的にはこれを設定すると追加したテキストがはみ出ないように図を保存してくれると思う．私はpngとpdfを作成し，pngの方をnotionに貼り付けてノート的に使えるようにしている．

## まとめ

今回は簡単にjupyterで作成した図表を管理する方法を考えた．まだまだ改善の余地があると思うので色々試してみたい．
