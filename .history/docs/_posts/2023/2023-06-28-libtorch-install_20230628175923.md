---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: pytorchをC++から使う（libtorch）：環境設定
layout: single
date:   2023-6-28 21:00:00 +0900
description: 
---

pythonで機械学習を行うpytorchやtensorflowは，C++からも利用できる．今回はpytorchに的を絞ってC++で使うための環境構築を行う．pythonの場合はcondaで簡単にインストールできるが，C++版は少し大変だったのでその辺をメモしておきたい．今回の設定はm1 mac，intel mac，Linuxマシンで試していずれも同一手順で大丈夫だった．

## 公式ページからのインストール（失敗）

まずは公式の配布コードを試したが，私の場合はこれでは動かなかった．．． 何か間違っているのだと思うが試したことを書いておく． [公式のインストールガイド](https://pytorch.org/cppdocs/installing.html)ではまずこれを試せということだ．[公式ページ](https://pytorch.org/get-started/locally/)から，LanguageでC++/Javaを選択すると，コードのダウンロードが可能だ．追加のインストール作業は必要ない．`C++`からインクルードするヘッダファイルは`include`ディレクトリ以下に存在し，特に`torch/script.h`がメインになっているようだ．インストールガイドでは`torch/torch.h`となっているがこれは古く`torch/script.h`が正しいと思う（実際`torch/script.h`は存在しない）．また，`lib`ディレクトリがshared librariesを含んでいる．

```
libtorch/
  bin/
  include/
  lib/
  share/
```

以下でちゃんと動くかどうかのテストを実施して，これがちゃんと動くようならそれで問題ないと思う．新しくディレクトリを掘って，C++のコード（example.cpp）とCMakeLists.txtを用意する．別にcmakeは使わなくても良いが公式は推奨している．

```bash
.
├── example.cpp
├── CMakeLists.txt
```

公式でMWEとして提示されているのは以下のようなpytorchのtensorを表示するコードだ．

```C++:example.cpp
#include <torch/script.h>
#include <iostream>

int main() {
  torch::Tensor tensor = torch::rand({2, 3});
  std::cout << tensor << std::endl;
}
```

このコードをcmakeを使ってビルドする．C++17が必要なのでその点に注意が必要．

```cmake:CMakeLists.txt
cmake_minimum_required(VERSION 3.18 FATAL_ERROR)
project(example)

find_package(Torch REQUIRED)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} ${TORCH_CXX_FLAGS}")

add_executable(example-app example.cpp)
target_link_libraries(example "${TORCH_LIBRARIES}")
set_property(TARGET example PROPERTY CXX_STANDARD 17)
```

あとは通常通りcmakeでビルドする．コンパイル時にダウンロードしたlibtorchのディレクトリにpathを通す．パスはCMakeLists.txtで`list(APPEND CMAKE_PREFIX_PATH /absolute/path/to/libtorch )`として追加しても良い．

```bash
# ビルド用ディレクトリの作成．
mkdir build
cd build
cmake ..  -DCMAKE_PREFIX_PATH=/absolute/path/to/libtorch 
make
```

これでできた`example`ファイルを実行して以下のようにtensorが表示されれば成功だが，自分の場合はmakeで引っかかってしまいこの方法では成功しなかった．

```
./example-app
0.2063  0.6593  0.0866
0.0796  0.5841  0.1569
[ Variable[CPUFloatType]{2,3} ]
```

## libtorchのビルド

しょうがないのでlibtorchのビルドにトライすることにした．[githubのdocsページ](https://github.com/pytorch/pytorch/blob/main/docs/libtorch.rst)にCmakeを使ってlibtorchをビルドする方法が書いてあるのでこれに従った．ありがたいことにこれでうまく行った．

```
git clone -b main --recurse-submodule https://github.com/pytorch/pytorch.git
mkdir pytorch-build
cd pytorch-build
cmake -DBUILD_SHARED_LIBS:BOOL=ON -DCMAKE_BUILD_TYPE:STRING=Release -DPYTHON_EXECUTABLE:PATH=`which python3` -DCMAKE_INSTALL_PREFIX:PATH=../pytorch-install ../pytorch
cmake --build . --target install
```

この方法だと`pytorch-install`に`include`他のファイルがインストールされる．こちらの`torch/script.h`を用いて前述のexampleをコンパイルするとうまく行った．


## 参考文献

[M1 MacでPytorchのc++版、libtorchをインストールして実行する](https://qiita.com/cometscome_phys/items/96b94074fdaf1c2bfa04)
[LibTorch(PyTorch C++API)の使い方](https://tokumini.hatenablog.com/entry/2019/08/24/100000)
[PyTorch C++（LibTorch）環境構築](https://qiita.com/koba-jon/items/2b15865f5b4c0c9fbbf7)