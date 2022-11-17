---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: PythonTop
layout: single
description: The top-page of Python.
permalink: /python/
---


## anacondaのinstall

[公式ページ](https://www.anaconda.com/products/distribution)からgraphical installerまたはcommand line installerをダウンロードできる．
<!-- https://repo.anaconda.com/archive/Anaconda3-2022.05-MacOSX-arm64.sh -->

```bash
# コマンドラインインストーラの場合はダウンロード後，以下を実行．
bash /path/to/Anaconda3-2022.05-MacOSX-arm64.sh
```

PATHの設定が自動的に.zshrcに書き込まれているので必要に応じて書き直すべし．

<!--export PATH=~/anaconda3/bin:$PATH -->

## 仮想環境の構築

pythonを使う場合，プロジェクトごとに仮想環境を作成し，そこにプロジェクトごとにpythonと必要なパッケージをインストールしていくのが主流．例えばプロジェクトごとに違うバージョンのpythonが使いたい時にも，仮想環境をコマンド一つで切り替えれられるのでとても便利．


## 計算科学で使えるパッケージ

0. [seekpath](https://seekpath.readthedocs.io/en/latest/maindoc.html)

    Kpathを探したい場合．パッケージ自体を使うことも可能だが，以下に示す他のパッケージでもエンジンとして利用されておりそちらを使う方が便利だと思う．

1. [pymatgen](pymatgen.md)


2. [ase](ase.md)



## matplotlibによる作図

<!-- https://qiita.com/TomokIshii/items/3a26ee4453f535a69e9e -->

## その他

自作モジュールのパッケージ化．CLIも含めることができる．
<!-- https://gist.github.com/3panda/7508508a89bd1ea1990217142eaf3c9c  -->
<!-- https://qtatsu.hatenablog.com/entry/2021/01/03/171032 -->

## クラス

- 継承
<!-- https://code-graffiti.com/class-inheritance-in-python/ -->

<!-- https://atmarkit.itmedia.co.jp/ait/articles/2001/28/news013.html　-->
- メソッドのオーバーライド

- superによる親クラスのメソッドの利用
<!-- https://djangobrothers.com/blogs/python_class_inheritance/ -->


## コードの書き方

可読性の良いコードを書くために．．．


### docstring（関数やクラスのドキュメント）

<!-- https://qiita.com/simonritchie/items/49e0813508cad4876b5a -->

### コーディングスタイル

<!-- https://peps.python.org/pep-0008/#imports -->

<!-- https://mako-note.com/ja/python-underscore/#:~:text=1%E3%81%A4%E4%BB%98%E4%B8%8E-,%E3%82%AF%E3%83%A9%E3%82%B9%E5%86%85%E3%81%AE%E5%A4%89%E6%95%B0%E3%82%84%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E3%81%AE%E5%85%88%E9%A0%AD%E3%81%AB%E3%82%A2%E3%83%B3%E3%83%80%E3%83%BC,%E5%A4%89%E6%95%B0%E3%83%BB%E3%83%A1%E3%82%BD%E3%83%83%E3%83%89%E3%81%A8%E3%81%84%E3%81%86%E3%81%93%E3%81%A8%E3%81%A7%E3%81%99%E3%80%82 -->

- _（アンダースコア）を関数の前につけた場合
    この場合，システム的な制約を受ける．関数が含まれるモジュールからワイルドカードでインポートする場合にアンダースコアで始まる関数は読み込まれない．

- _（アンダースコア）をクラス内のメソッドの前につけた場合
    そのメソッドはクラスの中だけで利用するという慣例がある．わかりやすさのためにつけておくのが吉．

- __（アンダースコア2つ）をクラスの変数やメソッドの前につけた場合
    ネームマングリング(Name Mangling)が適用される．アンダースコア一つと違ってクラス外からのアクセスができなくなる．

## 自作モジュールに関して

<!-- https://qiita.com/kzkadc/items/e4fc7bc9c003de1eb6d0 -->


自作モジュールをjupyter環境でリロードするには

```python
%load_ext autoreload
%autoreload 2 
```

の2行を書いてこの行を再評価する．

- サブコマンド
  
  https://qiita.com/oohira/items/308bbd33a77200a35a3d
  https://gist.github.com/jirihnidek/3f5d36636198e852280f619847d22d9e



<!-- https://sandmark.hateblo.jp/entry/2017/10/22/180000 -->


## コーディング全般

<!--
読みやすいコードのために
https://future-architect.github.io/articles/20190610/
https://qiita.com/icoxfog417/items/f737d6c84b733f649461
https://engineering.linecorp.com/ja/blog/code-readability-vol3/
https://qiita.com/qython/items/1f7416bbb29f48a153bb
-->

- 驚き最小原則
- Separation of concerns
- Single-responsibility principle

読みやすいコードのために気を付けるべきこと．

- 1: 中身が推測できる関数名（getXXX,）
- 2: 型や可視性が推測できる変数名（リストならxxxListなど）
