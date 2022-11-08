---
layout: single
title:  "QE v6.7/6.8/7.0 installation with intel"
date:   2022-10-28 10:03:40 +0900
categories: intel
tags:
 - vasp
---

## 動作確認済みのバージョン

v6.7/6.8/7.0

## 日付：2022/04/10

Quantum Espressoをインテルマシン/インテルコンパイラでコンパイルする．

コンパイラのバージョンは以下の通り(モジュール環境でoneapi 2021.7.0を利用した)

```
$ mpiifort --version
ifort (IFORT) 2021.7.0 20220726
Copyright (C) 1985-2022 Intel Corporation.  All rights reserved.
```

## ソースのDL

[公式ページ](https://www.quantum-espresso.org/download-page/)からダウンロード可能．


## ./configureの実行

./configureでMakefileを作成する．オプションの`--with-scalapack`と`--enable-openmp`はデフォルトでオフになっているので利用する場合は明示が必要．gcc環境などと混在している場合はCC, FC, F77などの環境変数にintelコンパイラを指定した方がよい．また，デフォルトだと`/usr/local`以下にインストールされてしまうのでそれを嫌う場合は`--prefix`でインストールするディレクトリを指示する．

```
# 環境変数を指定する場合
# ほかにFCFLAGS/LDFLAGS/LIBS/FFLAGSなどが必要な場合もあるかも
export CC=mpiicc
export CXX=mpiicpc # これは必要ないかも
export FC=mpiifort
export F77=mpiifort

# configure
./configure --with-scalapack=intel --enable-openmp=yes --prefix=${path/to/install}
```

`make.inc`の中を確認して，コンパイラの設定やライブラリのリンクが正しく行われているか確認する．

## make

あとはmakeするだけ．`-j`オプションなしでも30分程度で終わる．特定のコードだけコンパイルしたい場合，例えば`make pw`のように個別に指定することもできる．

```
make all
```

以上でコンパイルは完了．
