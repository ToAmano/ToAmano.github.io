---
layout: single
title:  "CPMD installation with intel compiler"
date:   2022-11-02 10:03:40 +0900
categories: intel
tags:
 - CPMD
---


## 日付：2022/11/02


CPMDをインテル oneapi環境にインストールする．oneapiの2020.4バージョンをmoduleからロードした．コンパイラのバージョンは以下の通り．

<!--
 1) intel_compiler/2020.4.304   2) intel_mpi/2020.4.304   3) intel_mkl/2020.4.304
-->

```bash
$ mpiifort --version
ifort (IFORT) 19.1.3.304 20200925
Copyright (C) 1985-2020 Intel Corporation.  All rights reserved.
```

## configureを実行してMakefileを作成する．

CPMDはさまざまな環境にあわせてMakefileをつくるためのconfigure.shというスクリプトを用意している．`./configure.sh`を実行したところ，`LINUX-X86_64-INTEL-MPI-FFTW`と`LINUX-X86_64-INTEL-IMPI-FFTW`という環境用の設定を見つけたのでこれらを試してみることにした[^1]．さらに，環境別に複数のcpmdを作成するため，./bin以下にディレクトリを掘って対応する．


```bash
# 環境についてさらに詳しい情報を見る
./configure.sh -i LINUX-X86_64-INTEL-MPI-FFTW

```


```bash
# ./bin/cpmd_intel以下にMakefileを作成する
./configure.sh -SRC=$PWD -DEST=./bin/cpmd_intel LINUX-X86_64-INTEL-MPI-FFTW
```

作成されたMakefileで，compilerの指定をgnuからintel系に変更した．`-cpp`オプションをつけないとコンパイルに失敗する．（この点についてはLINUX-X86_64-INTEL-IMPI-FFTWの方の情報をconfigure.shで見ると記載されている．）

```
# compilerをgnuからintelに変更
# FC = mpif90
# LD = mpif90

FC = mpiifort -cpp
LD = mpiifort -cpp

# FC = mpif90 -I.

FC = mpiifort -I. -cpp 
```


## LINUX-X86_64-INTEL-IMPI-FFTW

もう一つ，`LINUX-X86_64-INTEL-IMPI-FFTW`の方も試したが，こちらは

```
ld: cannot find -lfftw3_mpi
```

という単純なエラーで止まってしまった．探してみたところインストールしようとした環境にはこのライブラリがない．というわけで，このライブラリをリンクしないようにして試してみた．

```
# LFLAGS = -static-intel -mkl=sequential -axMIC-AVX512 -lfftw3_mpi
LFLAGS = -static-intel -mkl=sequential -axMIC-AVX512 
```

するとすんなりコンパイルに成功してしまった．．．というわけで，少なくとも自分の環境ではどちらの設定ファイルを使ってもコンパイルできることがわかった．


[^1]: 両者の違いはインテルコンパイラを使う（IMPI）かgnuコンパイラを使う（MPI）かの違いかなと思う．一応前者は
```
 Configuration to build a parallel cpmd executable for a
 Xeon Phi x86_64 machine using INTEL Fortran compiler
 version 16/17 or later, intelMPI and MKL.
 WARNING: (1) Intel Fortran Compilers up to version 13.1.0.146
          are affected by a bug compilation in the Jacobi
          rotation (GMAX -> Infinity) if optimization levels
          higher than -O1 are used.
          (2) If the option -cpp is not included, intel places a
          nasty and undesired line in the .f90 routines starting
          with '/* Copyright(C) 1991-2012 ... etc.' with TAB
          and other characters that make the code not compilable.
```

とあるので，intel Xeon Phi系のマシンを想定しているようだ．しかし結局のところ後者もコンパイラをgnuからintelにかえたところすんなりコンパイルに成功してしまったので，細かい違いはあまり気にしなくてもよいのかも．
