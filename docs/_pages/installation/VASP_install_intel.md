---
layout: single
title:  "VASP.5.4.4 installation with intel"
date:   2022-10-28 10:03:40 +0900
categories: intel
tags:
 - vasp
---


## 日付：2022/04/10

VASP5.4.4のインテルマシンでのコンパイルはかなり簡単というか，あまり対処が大変なエラーにでくわしたことがない．さすが商用ソフトウェアだけあってよく練られているのだと思う．今回はintel oneapi環境下にインストールする．

基本的には[公式wikiのページ](https://www.vasp.at/wiki/index.php/Installing_VASP.5.X.X)にくわしくのっているのでそちらを参照するとよい．

コンパイラのバージョンは以下の通り(モジュール環境でoneapi 2020.04を利用した)
```
mpiifort --version
ifort (IFORT) 19.1.3.304 20200925
Copyright (C) 1985-2020 Intel Corporation.  All rights reserved.
```

追記：2021.07のversionでも同様にcompileできることを確認した．


## make.includeの作成

archディレクトリにいくつかのアーキテクチャ用のmake.includeのサンプルがある．今回はインテル用を利用する．

```
cp arch/makefile.include.linux_intel  ./makefile.include
```

ファイルの`MKL_PATH   = $(MKLROOT)/lib/intel64`の前にMKLROOTを追加する．これは環境変数のMKLROOTと同じpathを設定すればよい．

```
MKLROOT    = /home/local/intel/compilers_and_libraries_2020.4.304/linux/mkl
```

このディレクトリの場所はマシンごとに異なる．mpiifortの場所などから探すとよいだろう．

## make

あとはmakeするだけ．経験的にVASPのmakeは並列化しても通る気がするが，不可解なエラーでとまったらまずは`-j`を外してみることをおすすめする．

```
make -j 16 all
```


## R2SCANパッチの当て方 2022/6/12

パッチのページは[こちら](https://gitlab.com/dhamil/r2scan-subroutines)．READMEにpatchのあてかたがかいてあるが，`src`ディレクトリに行って単に

```
# git clone 
git clone https://gitlab.com/dhamil/r2scan-subroutines.git

# srcディレクトリに行ってpatchを当てる
cd /path/to/vasp.5.4.4/src
patch < /path/to/r2scan-subroutines/vasp_patch_files/metagga544.diff*
```

でよい．patchをあてたら再コンパイルが必要だが，これは1分程度でおわる．

```
# vaspのルートディレクトリへ移動
cd .. 
# make
make all
```

これでR2SCANを使えるようになる．
