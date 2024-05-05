---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: Deepmd installation with AMD ZEN on Linux 
layout: single
date:   2024-5-4 21:00:00 +0900
header:
  teaser: 
description: AMD EPYC用のtensorflowを使ったdeepmdのビルド方法
---

今回はAMD CPU用に最適化されたTensorflowと，それを用いたdeepmdのinstallを行う．この場合は当然ながらcondaなどのパッケージマネージャは利用できず，全て手で入れる必要がある．

## ZenDNN とは

ZenDNNはAMDが開発しているオープンソースライブラリで，AMD EPYC CPUsでの機械学習実行の最適化を目的としている．これを元に，tensorflowがTF-ZenDNNを開発している．TF-ZenDNNには2種類あり，一つが元のtensorflowを大幅に書き換えるdirect integrationと呼ばれるもの，もう一つがプラグイン方式で実装されたTensorFlow-ZenDNN plug-inであり，今回はこちらをインストールする．プラグイン方式は元のtensorflowはいじらないので問題が発生する可能性が低い．

## 環境

|      |     |
| ---  | --- |
| 日付 | 2024/4/10 |
| OS   | Red Hat Enterprise Linux 8.6 |
| gcc  | gcc (GCC) 10.1.0 |


## tensorflow installation

最初にtensorflowと，tensorflow向けのZenDNNプラグインをインストールする．手順は[tensorflowのブログ記事](https://blog.tensorflow.org/2023/03/enabling-optimal-inference-performance-on-amd-epyc-processors-with-the-zendnn-library.html)に詳しく載っているので合わせて要参照．

1. ZenDNN Plug-in CPU wheel fileを`https://github.com/tensorflow/build#community-supported-tensorflow-builds`からダウンロードする．リストの中から`AMD	Linux AMD ZenDNN Plug-in CPU Stable : TF 2.x`をダウンロードすること．

2. pipを使って`tensorflow`とプラグインをインストールする．1でダウンロードしたファイルと同じ所で（あるいはpathを指定して）実行すること．

```bash
pip install tensorflow-cpu==2.12.0 

pip install tensorflow_zendnn_plugin-0.1.0-cp38-cp38-manylinux_2_17_x86_64.manylinux2014_x86_64.whl
```

以上でtensorflowは正常に入ったので，あとはこのtensorflowを使ってdeepmdをビルドする．

## Deepmdのpython interfaceのインストール

基本的に以下の手順は[deepmdのHPで紹介されているもの](https://docs.deepmodeling.com/projects/deepmd/en/master/install/install-from-source.html)と同じ．まずはgithubからrepositoryをダウンロードする．

```bash
git clone https://github.com/deepmodeling/deepmd-kit.git deepmd-kit
```

公式に従って，repositoryのroot directoryを変数に当てておく．

```bash
cd deepmd-kit
deepmd_source_dir=`pwd`
```

python interfaceは`pip`を用いてインストールできる．

```python
cd $deepmd_source_dir
pip install .
```

モデルの訓練をするだけならここまででOK．lammpsなどと合わせて使いたい場合は次へ．

## DeepmdのC++ interfaceのインストール

C++ interfaceのインストールにはcmake(>=3.16)とgcc(>=4.8)が必要なのであらかじめ入れておく．その上で，cmakeを実行する．本記事に示すように`pip`でtensorflowを入れて入れば`-DUSE_TF_PYTHON_LIBS=TRUE`と指定することで自動でtensorflowを探してきてくれる．

```bash
# buildディレクトリを作成
cd $deepmd_source_dir/source
mkdir build
cd build
# installしたいディレクトリの指定（今回はbuildディレクトリ）
deepmd_root=`pwd`
# cmakeを実行
cmake -DUSE_TF_PYTHON_LIBS=TRUE -DCMAKE_INSTALL_PREFIX=$deepmd_root ..
```

cmakeが成功したら，あとはmakeでインストールする．インストールが成功すれば，`$deepmd_root/bin`と`$deepmd_root/lib`にファイル群が入る．

```bash
make 
make install
```

最後に，lammpsを利用するためのmoduleのインストールをやっておく．`USER-DEEPMD`というディレクトリにファイル群が入っていれば成功だ．

```bash
cd $deepmd_source_dir/source/build
make lammps
```




## LAMMPSのインストール

今回はなぜかcmakeを使ったインストールが上手くいかなかったので，makeを利用してインストールした．

まずはgithubからlammpsのrepositoryをダウンロードする．

```bash
cd /some/workspace
wget https://github.com/lammps/lammps/archive/stable_2Aug2023_update2.tar.gz
tar xf stable_2Aug2023_update2.tar.gz
```

lammpsのディレクトリへ行ってビルドする．大事なのは前節でインストールした`USER-DEEPMD`ディレクトリをlammpsの`src`ディレクトリへコピーすること．

```bash
cd lammps-stable_2Aug2023_update2/src/
cp -r $deepmd_source_dir/source/build/USER-DEEPMD .
make yes-kspace
make yes-extra-fix
make yes-user-deepmd
make yes-openmd

# installation
make mpi 
```

## 実行時の注意

ZenDNNプラグインを有効化するには，実行時に二つの環境変数を設定する．今回はせっかくインストールしたにも関わらずこれらの環境変数を設定してもlammpsの実行速度にさほど変わりはなかった．圧倒的にGPUの方が早いことには変わりないので，GPUが使える環境ならおとなしくGPUを使うべきだろう．

```bash
export TF_ENABLE_ZENDNN_OPTS=1
export TF_ENABLE_ONEDNN_OPTS=0
```

その他に，より一般的なCPUでの実行時の注意として，環境変数`TF_INTRA_OP_PARALLELISM_THREADS`と`TF_INTER_OP_PARALLELISM_THREADS`の最適化をするとだいぶ速度が変わるのでその点も忘れずに．

