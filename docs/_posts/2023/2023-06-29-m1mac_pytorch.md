---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: m1 macのpytorchでGPUを利用する
layout: single
date:   2023-6-29 21:00:00 +0900
categories: 
 - code
tags:
 - python
 - pytorch
 - ML
description: pytorchはバージョン2.0でApple siliconのGPUに対応したので環境構築を試みる．
---

pytorchはバージョン2.0でApple siliconのGPUに対応した．macのOSがMacOS 12.3以上である必要がある．今回は実際にGPUでの学習を試す．

## 仮想環境の作成（option）

念のため仮想環境を作成する．以前別のmacマシンでpythonのバージョンが3.11だとエラーが出たようなこともあったので慎重を期すことにしている．公式的には3.8以上だったら良いらしい．

```bash
conda create -n pytorch 
conda activate pytorch
```

## pytorchのインストール

[公式ページ](https://pytorch.org/get-started/locally/)にインストールコマンドがのっているのでそれを用いる．torchvisionは画像処理系，torchaudioは音声処理系のライブラリで，使わないなら入れなくても大丈夫だ．

```bash
# conda の場合
conda install pytorch::pytorch torchvision torchaudio -c pytorch
# pipの場合
pip3 install torch torchvision torchaudio
```

## pytorch自体の動作確認

インストール後，ためしにpytorchのtensorがうまく動いているかを確認する．

```python
import torch
x = torch.rand(10,10)
print(x)
```

## GPUが使えるようになったかの確認

インストール後，以下のようなコマンドを試してTrueがかえって来ればM1のGPUが使える状態になっている．

```python
import torch
torch.backends.mps.is_available()
>>> True
```


## Apple Silicon GPUを使う方法

pytorchではコード中で`torch.device`でGPUを使うかCPUを使うか指定する必要があったが，新しく`mps`（Metal Perfomance Shaders）というオプションができて，これを指定すればM1のGPUを使ってくれる．

```python
# cpuを使う場合
device = torch.device('cpu')
# CUDAを使う場合
device = torch.device('cuda:0')
# M1 GPUを使う場合
device = torch.device('mps')
```

## その他

自分で作成したネットワークを利用しようとしたところ，`num_worker=0`でないと動かないという問題が発生しており，まだ解決していない．解決したらここに追記しようとおもう．


## 参考文献

[PyTorchをM1 MacBook のGPU(MPS)で動かす．実行時間の検証もしたよ](https://zenn.dev/hidetoshi/articles/20220731_pytorch-m1-macbook-gpu)