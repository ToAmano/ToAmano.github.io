---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: nglviewで得た構造の画像を保存する
layout: single
date:   2023-8-2 21:00:00 +0900
categories: 
 - code
tags:
 - bash
description: youtube-dlでzoomの動画をダウンロードする．
---

python+jupyter notebookで使える強力な原子構造の描画ツールnglviewを使っていて，えられた画像を保存したいということがあった．この場合に使える手法について調べた．

## 想定する場面

分子動力学のトラジェクトリファイルがあり，それを読み込んでnglviewで表示させ，さらに画像を保存したい．pythonでトラジェクトリファイルを読み込む方法は色々あり，特に有名なライブラリとして`MDtraj`と`ase`が知られている．nglviewはどちらにも対応しているので読み込みはどちらでやっても以下の記述は全てそのまま使える．

今回は`ase`を使う方法でやっていく．MDトラジェクトリの読み込み部分は以下のように`ase.io.read`関数を使って実現できる．

```python
import ase
import ase.io

traj = ase.io.read("filename.xyz", index=':')
```

重要なのは`index`パラメータで読み込むフレームを指定すること．デフォルトだと最後のフレームだけを読み込んでしまう．indexの指定は通常のスライスと同じようにすればよくて，上の":"だと全フレームを読み込む．一般に`a`番目から`b`番目までのフレームを`c`ステップごとに読み込みたければ

```python
traj = ase.io.read("filename.xyz", index='a:b:c')
```

で良い．後ほど紹介するgifアニメを作りたい場合，読み込みの段階で例えば100ステップごとに読み込んでおくと余計な読み込みが発生しないのでおすすめ．

さて，こうして取り込んだトラジェクトリをnglviewに渡すには以下のようにする．

```python
import nglview
trajview = nv.show_asetraj(traj_wc,gui=True)
trajview
```

`show_asetraj`はase形式のリストを渡す時に使う関数で，他にも様々な関数がある．3行目のtrajviewを実行することで，jupyter notebook上でちゃんと画像が表示される．


問題はここからで，画像を保存したい時だ．nglviewに画像やgifを保存する純正の関数があるのだが，私の環境ではちゃんと動かなかった．まずはそれらのコードを紹介してから最後に回り道で画像を保存できた方法を紹介する．


## nglviewの純正関数download_imageを利用する方法

この方法はjupyter notebookではうまくいくがVScodeではうまくいかなかった．nglviewの関数download_imageを使うといかんおようにスマートにかける．

```python
import time 
import numpy as np
import os
import shutil
import moviepy.editor as mpy
from PIL import Image

# save frames every step
for frame in range(len(traj)):
    print("frame is ... ", frame)
    # set frame to update coordinates
    w.frame = int(frame)
    time.sleep(0.2)
    w.download_image(filename="0image{}.png".format(frame))
    time.sleep(0.2)
```

実際に上のセルで表示させているtrajviewを動かしてスクリーンショットを保存するという仕組みになっているので，`time.sleep`でちゃんとフレームが読み込まれるまで待たないといけない．数字はもっと小さくできるかもしれないが環境によって試行錯誤が必要だろう．

このコードはjupyter notebook上ではうまくいくのだが，VScode上ではdownload_imageを実行するたびにどこに保存するかを問うポップアップが表示されてしまい，gifアニメを作りたい場合には使えなかった．jupyter notebook上で実行するときもファイルの保存場所がダウンロードディレクトリだった（jupyter notebookのディレクトリではない！）ので保存先を決める仕様が特殊なのかもしれない．

## nglviewの純正関数MovieMakerを使ってgifを作る

nglviewにはgifを作るための関数MovieMakerもあるが，これは私の環境では全く動かなかった．

```python
# http://nglviewer.org/nglview/latest/_api/nglview.contrib.movie.html
from nglview.contrib.movie import MovieMaker
mov = MovieMaker(trajview,   step=100 , output="my_test.gif", timeout=0.2, in_memory=False)
# mov = MovieMaker(view2,   step=10 ,output=‘my.avi’, in_memory=True, moviepy_params=moviepy_params)
mov.make()
```

in_memoryはスナップショットの画像をメモリに保存するかディスクに保存するかの変数で，もしgifが小さいならTrueでも良いが普通はFalseの方が安全だと思われる．

いずれにしよこの関数は動かなかった．．．

## 自分で書き込む方法

純正の関数がどちらもVScodeで動かなかったので，以下のページの方法を使ってみるとうまくいった．

[How to make nglview view object write PNG file?](https://github.com/nglviewer/nglview/blob/master/docs/FAQ.md#how-to-make-nglview-view-object-write-png-file)

[How to make nglview view object dump PNG file #928](https://github.com/nglviewer/nglview/issues/928)

この方法は，`render_image`メソッドで画像を取り出し，それを普通にファイルにかきこむ方法で，もっとも確実性が高いと思われる．ただし，純正でない代償として別スレッドで動かさないといけないらしく，ちょっとトリッキーなコードになる．

```python
import time
import numpy as np
import os
import shutil
import moviepy.editor as mpy
from PIL import Image

def process_images():
        # save frames every step
        for frame in range(len(trajview):
                print("frame is ... ", frame)
                # set frame to update coordinates
                w.frame = int(frame)
                test = w.render_image() # イメージを取得
                while not test.value:
                        time.sleep(0.1)
                # 画像の保存
                with open("figure_{}.png".format(frame),"wb") as fh:
                        fh.write(test.value)

import threading
thread = threading.Thread(
    target=process_images,
)
thread.daemon = True
thread.start()
```

`sleep`で画像のレンダリングを待たないといけないのはこちらの方法でも同じ．


## (option) 画像からgifを作る方法

最後に，上の方法で沢山の画像をダウンロードしてからgifを作る方法を紹介して終わりにする．`moviepy`というライブラリを使うので先に入れておく．

```python
from time import sleep
import numpy as np
import os
import shutil
import moviepy.editor as mpy
from PIL import Image


# 画像のディレクトリ
dwn_dir = "/path/to/images_dir/" 

# 実際にpicturesにappendする
pictures=[]
for i in range(len(traj)):
    img=Image.open(dwn_dir+"figure_{}.png".format(str(i)))
    pictures.append(img)

#gifアニメを出力する
# durationは１枚の画像を表示する期間をミリ秒単位で表す．
# つまりduration=500で４枚の画像を合体させると500×4=2000ミリ秒⇒2秒の動画を作成することになる．
# frame_per_sec(fps)に直すには，frame_per_sec*duration=1000 に注意．
# fps=8ならduration=125

pictures[0].save("test_animation.gif",save_all=True, append_images=pictures[1:],\
optimize=False, duration=125, loop=0)
```


