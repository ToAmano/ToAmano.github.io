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

これはもしかするとだが，v6.7では最適化が-O2だったのがv.6.8では-O3に変わっている？

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

configureの実行が成功すると，最後に

```
--------------------------------------------------------------------
ESPRESSO can take advantage of several optimized numerical libraries
(essl, fftw, mkl...).  This configure script attempts to find them,
but may fail if they have been installed in non-standard locations.
If a required library is not found, the local copy will be compiled.

The following libraries have been found:
  BLAS_LIBS=  -lmkl_intel_lp64  -lmkl_intel_thread -lmkl_core
  LAPACK_LIBS=
  SCALAPACK_LIBS=-lmkl_scalapack_lp64 -lmkl_blacs_intelmpi_lp64
  FFT_LIBS=



Please check if this is what you expect.

If any libraries are missing, you may specify a list of directories
to search and retry, as follows:
  ./configure LIBDIRS="list of directories, separated by spaces"

Parallel environment detected successfully.\
Configured for compilation of parallel executables.

For more info, read the ESPRESSO User's Guide (Doc/users-guide.tex).
--------------------------------------------------------------------
```

のように表示されて，BLAS/LAPACKのリンクが正常に行われているか出力される．さらに，`make.inc`の中を確認して，コンパイラの設定やライブラリのリンクが正しく行われているか確認する．

## make

あとはmakeするだけ．`-j`オプションなしでも30分程度で終わる．特定のコードだけコンパイルしたい場合，例えば`make pw`のように個別に指定することもできる．

```
make all
```

以上でコンパイルは完了．
