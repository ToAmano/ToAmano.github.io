---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: 【vscode】 rstファイルのプレビュー
layout: single
date:   2025-5-10 21:00:00 +0900
categories: coding
tags:
 - python
 - vscode
 - sphinx
 - rst
header:
  teaser:
description: rst形式のファイルをVS Code上でPreviewする方法について．この記事では，sphinxで構成したrstファイルを，VS CodeでリアルタイムにPreviewする方法を解説する．

---


rst形式のファイルをVS Code上でPreviewする方法について．この記事では，sphinxで構成したrstファイルを，VS CodeでリアルタイムにPreviewする方法を解説する．最終的には以下のような状態を目指す．

{% include figure popup=true image_path="/assets/posts/2025-05-10-vscode-preview-rst/vscode-rst-preview.png" alt="" caption="" %}

## 拡張機能の紹介

今回利用する拡張機能は以下の3つ．プレビューだけならEsbonioだけインストールすれば良いが，残りの二つもrstを書くときに有用なので合わせてインストールすることをお勧めする．マーケットプレイスおよびドキュメンテーションへのリンクは以下の通り．

- [Esbonio](https://marketplace.visualstudio.com/items?itemName=swyddfa.esbonio) [[marketplace](https://marketplace.visualstudio.com/items?itemName=swyddfa.esbonio)] [[hp](https://docs.esbon.io/en/latest/)]
- [reStructuredText](https://marketplace.visualstudio.com/items?itemName=lextudio.restructuredtext) [[marketplace](https://marketplace.visualstudio.com/items?itemName=lextudio.restructuredtext)] [[hp](https://docs.lextudio.com/restructuredtext/)]
- [reStructuredText Syntax Highlighting](https://marketplace.visualstudio.com/items?itemName=trond-snekvik.simple-rst) [[marketplace](https://marketplace.visualstudio.com/items?itemName=trond-snekvik.simple-rst)] [hp]

### Esbonio

EsbonioはSphinxをバックエンドとして利用し，RST文書のリアルタイムプレビューやコード補完を提供する拡張機能である．主な機能としてSphinxに基づくプレビューの表示やコード補完がある．プレビューは裏側でPythonおよびSphinxを利用してEsbonioがファイルをビルドして表示する仕組みになっており，利用時はこの二つが入っていることが前提となる．

### reStructuredText

reStructuredText拡張はRST文書の構文チェックやナビゲーション補助を提供する総合的なツールである．主な特徴として，コードスニペットやリンター機能がある．

### reStructuredText Syntax Highlighting

reStructuredText Syntax Highlightingは、構文ハイライトを提供する拡張機能である．基本的にはVS Codeにデフォルトで採用されているが，market placeから導入すると最新版が入るので一応入れておく．

## プレビューする手順

上で述べた3つの拡張機能をインストールすれば，追加でsettings.jsonへの設定は不要だ．プレビュー時にはrstファイルを開いて，以下の手順を実行する．

1. Python: Select Interpreterから所望の環境を選択する．

    `cmd+Shift+P`からPythonと検索し，Select InterpreterからPython環境を選択する．

    {% include figure popup=true image_path="/assets/posts/2025-05-10-vscode-preview-rst/select_python_interpreter.png" alt="" caption="" %}

2. rst文書で右上のプレビューマークを押す．

    右上のプレビューのボタンを押すと，左右にペインが分かれて右側に文書プレビューが表示される．

    {% include figure popup=true image_path="/assets/posts/2025-05-10-vscode-preview-rst/vscode-rst-preview-button.png" alt="" caption="" %}

## まとめ

rst文書のプレビュー方法を紹介した．rst形式はmarkdown形式とは異なるものの構造化文書を書くときの有力な選択肢であり，特にSphinxを用いたコードのドキュメント生成は多くのOSSで採用されている．プレビューを用いて効率的にドキュメンテーションを行う一助としたい．
