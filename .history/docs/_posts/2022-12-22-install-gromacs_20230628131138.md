---
layout: single
title:  "速度を気にしない場合のgromacsの簡単なインストール手順"
date:   2022-12-21 09:00:00 +0900
categories: bash
tags:
 - linux
 - bash
---

## gromacs

古典分子動力学の計算ソフトであるgromacsをインストールする．intelは利用せずに通常のgccとown buildのFFTを利用する場合について記述する．ちなみにmacの場合はhomebrewでインストールが可能になっているのでこれを利用するのも手ではある．m1機でもintel機でもインストールできる．

```bash
brew install gromacs
```

ただし，これだとmpi版は入らないため利用する場合は別途インストールする必要がある．

## ソースのダウンロード

ソースコードは[公式ページ](https://www.gromacs.org/Downloads)からダウンロードできる．2023/6現在の最新版は2023.1だが，これが入らなければ一つ前の2022.4なども試してみると良い．私の場合はとあるマシンに2023.1は入らなかったが2022.4はインストールできたという場合があった．

## 事前準備

インストールに最低限必要なものはcmakeとC/C++コンパイラーだ．今回は前述の通りgccコンパイラを利用する．別途fftwやmklを用意してリンクすることも可能だが，その手続きについてはまた別の記事に譲り，今回はgccコンパイラだけ使ってビルドする．

## インストール

ダウンロードしたソースを解凍し，ビルド用のディレクトリ（今回はbuild）を作成する．

```bash
tar xfz gromacs-2022.4.tar.gz
cd gromacs-2022.4
mkdir build # 新しくディレクトリを作成（公式推奨）
cd build
```

cmakeの時のオプションはいくつかあるが，ここでは最低限必要なもののみをピックアップする．

- `-DGMX_BUILD_OWN_FFTW=ON`：fftも一緒に作成する．
- `-DGMX_MPI=ON`：mpi版をビルドするときに利用．
- `-DCMAKE_C_COMPILER`：Cコンパイラの指定．`CC`環境変数でも良い．
- `-DCMAKE_CXX_COMPILER`：C++コンパイラの指定．`CXX`環境変数でも良い．
- `-DCMAKE_INSTALL_PREFIX`：インストール場所の指定．sudo権限がない場合は適当に変更しよう．
- `-DGMX_OPENMP`：openMPの利用．デフォルトでオンになっているので通常は省いて大丈夫．

まずは非mpi版をインストールする．openMPはデフォルトでオンになっているので追加のオプションは必要ない．

``` bash
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DCMAKE_INSTALL_PREFIX=bin/
make
make check 
make install
```

インストールは数十分程度．FFTを入れないならもっと早いと思う．インストール後にオプションで環境設定ができるコードが`bin/GMXRC`にあり，走らせておくと良い．

```bash
source bin/GMXRC
```

非mpi版のインストールが成功したら次にmpi版のインストールを実行する．上と同じbuildディレクトリからcmakeを実行する．mpiをオンにするとインストールされるコードが`gmx_mpi`のように`_mpi`がつき，通常版と区別されるという仕組みになっている．

``` bash
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DCMAKE_INSTALL_PREFIX=bin/ -DGMX_MPI=ON
make
make check 
make install
```

以上でインストールは終了だ．

## 参考文献

[公式のインストールガイド](https://manual.gromacs.org/current/install-guide/index.html)
[Gromacs 2022をmacOS / Linux上にインストール](https://qiita.com/Ag_smith/items/2432375399e7d7868138)
[Gromacs 2021.4 Intel20](https://ccportal.ims.ac.jp/node/3027)
[archlinux GROMACS](https://wiki.archlinux.jp/index.php/GROMACS)
