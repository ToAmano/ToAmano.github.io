---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: Apple Silicon機へのGPU対応PyTorch/TensorFlowのインストール
layout: single
date:   2025-2-8 21:00:00 +0900
categories: coding
tags:
 - pytorch
 - apple
 - python
header:
  teaser: 
description: Apple Silocon機でPytorchおよびTensorFlowをGPU対応させてインストールする方法について．コマンド一行で終わるが備忘録．
---

Apple Silocon機でPytorchおよびTensorFlowをGPU対応させてインストールする方法について．TensorFlowは追加のプラグインをインストールする必要があり，一方PyTorchはその必要はない．

## PyTorchインストール

通常通りPyTorchをインストールする．torchvisionとtorchaudioは使う場合は入れる．Pythonは3.9以降であれば良い．

```bash
pip install torch torchvision torchaudio
```

Pytorchバックエンドの名前は`mps` になる．以下のコードでGPU対応できているか確認できる．

```python
import torch

if torch.backends.mps.is_available():
    device = torch.device("mps")
    print("MPS device is available and being used.")
```

## TensorFlowインストール

TensorFlowの場合，通常の`tensorflow` パッケージに加えて`tensorflow-metal` プラグインが必要．

```bash
pip install tensorflow
pip install tensorflow-metal
```

以下のコードでGPU対応できているか確認できる．

```python
import tensorflow as tf
print(tf.config.list_physical_devices('GPU'))
```

## まとめ

2025年現在ではpytorchもtensorflowも非常に簡単に設定できる．

## 参考

[Tensorflow Plugin - Metal - Apple Developer](https://developer.apple.com/metal/tensorflow-plugin/)

[Start Locally](https://pytorch.org/get-started/locally/)