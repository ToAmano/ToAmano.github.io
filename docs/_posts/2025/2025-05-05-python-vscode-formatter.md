---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: 【vscode】 pythonフォーマッタとリンタ
layout: single
date:   2025-5-5 21:00:00 +0900
categories: coding
tags:
 - python
 - vscode
header:
  teaser:
description: VS Codeにて，Python用のフォーマッタとリンタを設定する方法について．特にblack, isort, flake8, pylintについて．
---

VS CodeでPython用のフォーマッタとリンタを設定する方法について．

## フォーマッタとは

フォーマッタ（Formatter）はコードの見た目を自動的に整えてくれるツールである．以下のような処理を行うことができる．

- インデントや空白の調整
- 改行位置の整備
- コードの並び替え（例：import文の順序）
- スタイルガイド（例：PEP8）に基づいた統一

言語ごとにガイドラインで決められたスタイルがある．今回扱うPythonならPEP8，C++なら
****[Google C++ Style Guide](https://google.github.io/styleguide/cppguide.html)など，言語ごとによく用いられるガイドが存在する．スタイルの統一を手作業で行うのは非現実的なので，基本的にこれらのガイドに従ってくれるフォーマッタを利用することで，コーディング中に自動でスタイルの統一を行うのが一般的だ．

また，コード中の**スタイル違反やバグの可能性がある構文**を静的に検出するツールであるリンタと呼ばれるものも存在し，コーディング中に明確にスタイル違反を認識できる．フォーマッタと合わせて利用することが多い．VS Codeにおけるリンターの使い方については，[こちらの記事](https://code.visualstudio.com/docs/python/linting)も参照のこと．

## PEP8とは

今回はPythonがテーマなのでPEP8について簡単に触れる．PEP8とは、Python Enhancement Proposal 8 の略であり，Pythonにおける公式な**コードスタイルガイドライン**である。以下のような観点からスタイルが定義されている：

- インデント
- 空白・空行の使い方
- 行の長さ
- インポート文の順序と分割方法
- 命名規則（関数名、クラス名、定数名など）

多くのPythonライブラリがこのスタイルに準拠しており，contributionする際や自分でライブラリを作成する際もとりあえずこのスタイルに従っておくのが良い．プロジェクトによっては要件として定められている場合もある．以下に代表的なガイドラインをいくつか挙げる．

- **インデントはスペース4つを使用する**
  - タブではなくスペースを使用する（エディタ設定推奨）
- **行の長さは最大79文字まで**
  - コメントなどは72文字以内が望ましいとされている
- **トップレベルの関数やクラス定義の前には2行の空行を入れる**
- **関数内のローカル関数やクラス定義の前には1行の空行を入れる**
- **演算子の前後にはスペースを入れる**
  - 例：`x = a + b` はOK、`x=a+b` は非推奨
- **不要な空白は避ける**
  - 例：関数の引数リストで `func( a, b )` は非推奨、`func(a, b)` が正しい
- **インポートはグループごとに分ける**
    1. 標準ライブラリ
    2. サードパーティライブラリ
    3. 自作モジュール
  - 各グループの間には1行の空行を挿入する
- **命名規則**
  - 変数，関数は小文字のスネークケース（`lower_case_with_underscores`）を用いる
  - クラス名にはキャメルケース（`CapWords` または `PascalCase`）を用いる
  - 定数にはすべて大文字のスネークケース（ALL_CAPS_WITH_UNDERSCORES）を用いる

## Pythonのフォーマッタとリンタ：black / isort / flake8/pylint8 の概要と使い方

Pythonでは、PEP8スタイルに準拠したコードを自動で整形・検査するために複数のフォーマッタやリンターが用意されている．ここでは代表的な3つのツール `black`、`isort`、`flake8` ，`pylint`の概要と使い方を紹介する．`black`と`isort`は同時に運用できる．`flake8`と`pylint`はどちらか一方自分の好みに合う方を利用し，私は合計3つ利用している．flake8よりもpylintの方が包括的なチェックを行うのでより細かいところまでチェックできる反面，検出されるものが多いと煩雑と感じる人もいるのでこの二つは好みやプロジェクトで使い分けると良い．

- フォーマッタ
    1. **isort**：インポートの整列
    2. **black**：コード全体の整形
- リンター
    1. **flake8**：構文やスタイルの違反チェック
    2. pylint：構文やスタイルの違反チェック

### black：コードフォーマッタ

`black` は Python コードを**自動的かつ強制的に整形**するツールである．

- **特徴**
  - PEP8に準拠した整形
  - 曖昧さのない出力
  - 設定不要で高速に利用可能

- **インストール**

    ```bash
    pip install black
    ```

- 基本的な使い方

    ```bash
    black your_script.py
    ```

- **VS Codeで使う場合**

    以下のマーケットプレイスからインストールできる．

    [](https://marketplace.visualstudio.com/items?itemName=ms-python.black-formatter)

    .vscode/settings.json に以下を追加する．1行目がblackを利用する指定，2行目は保存時に自動でフォーマッタを適用する設定．

    ```yaml
      "[python]": {
        "editor.defaultFormatter": "ms-python.black-formatter",
        "editor.formatOnType": true,
      },
    ```

### **isort：インポート文の整列ツール**

isort は Python スクリプト内の**import 文を自動でソート・整形**するためのツールである．標準ライブラリ・サードパーティ・ローカルモジュールを分類し、読みやすく一貫性のある並び順に自動で変換する．

- **特徴**
  - import 文を自動でグルーピング
  - black との統合も可能
  - プロジェクトごとの設定も可能（pyproject.toml）
- pip版のインストールと利用方法

    pip版で利用する場合は，pipからインストールする．

    ```bash
    pip install isort
    ```

    コマンドラインからフォーマッタを起動する．

    ```bash
    isort your_script.py
    ```

- VS Codeで使う場合

    isortもVS Codeの拡張機能として提供されるようになったため，pipからインストールして使う必要がなくなった．以下のマーケットプレイスからインストールできる．

    [](https://marketplace.visualstudio.com/items?itemName=ms-python.isort)

    .vscode/settings.json に以下の設定を追加する．

    ```yaml
     "isort.args":["--profile", "black"],
    ```

    さらに，blackと同時に利用する場合，以下のようにsetting.jsonに設定する．

    ```yaml
      "[python]": {
        "editor.defaultFormatter": "ms-python.black-formatter",
        "editor.formatOnSave": true,
        "editor.codeActionsOnSave": {
            "source.organizeImports": "explicit"
        },
      },
      "isort.args":["--profile", "black"],
    ```

### **flake8：コードの静的解析ツール**

flake8 はコード中の**スタイル違反やバグの可能性がある構文**を静的に検出するツールである。PEP8違反、未使用の変数、構文エラーなどを早期に発見できる。

- 特徴
  - PEP8違反の検出
  - 未使用の変数や定義の指摘
  - 拡張プラグインにより機能強化可能
- **pip版のインストールと利用**

    pip版で利用する場合は，pipからインストールする．

    ```bash
    pip install flake8
    ```

    コマンドラインからリンタを起動すると，スタイル違反を一覧形式で出力できる．

    ```bash
    flake8 your_script.py
    ```

- **VS Codeで使う方法**

    flake8もVS Codeの拡張機能として提供されるようになったため，pipからインストールして使う必要がなくなった．以下のマーケットプレイスからインストールできる．インストールしたらそのまま利用できる．

    [](https://marketplace.visualstudio.com/items?itemName=ms-python.flake8)

### pylint：詳細な静的解析を行うリンター

`pylint` は Python の静的解析ツールの中でも特に多機能であり、**PEP8 のスタイル違反だけでなく、未使用の変数、意味のない比較、関数やクラスの設計の問題点**まで検出できる。`flake8` よりもチェックが厳しく、開発初期やコード品質の向上を目的としたレビューに適している。

- **特徴**
  - 100点満点によるスコア評価（品質の定量化が可能）
  - コーディングスタイル、構文、リファクタリング、論理エラーを検出
  - 複雑な構造や設計のアンチパターンに対する警告も出す
  - 自動で設定ファイル（`.pylintrc`）を生成可能
- **pip版のインストールと利用**

    pip版で利用する場合は，pipからインストールする．

    ```bash
    pip install pylint
    ```

    コマンドラインから起動すると，違反の一覧が出力される．

    ```bash
    pylint your_script.py
    ```

- **VS Codeで使う方法**

    pylintもVS Codeの拡張機能として提供されるようになったため，pipからインストールして使う必要がなくなった．以下のマーケットプレイスからインストールできる．インストールしたらそのまま利用できる．

    [](https://marketplace.visualstudio.com/items?itemName=ms-python.pylint)

## その他

以下，そのほかの設定などを示す．

### notebookでもblackとisortを適用する

notebookでもフォーマッタを適用したい場合，setting.jsonに以下の項目を追加する．

```yaml
    "notebook.defaultFormatter": "ms-python.black-formatter",
    "notebook.formatOnCellExecution": true,
    "notebook.formatOnSave.enabled": true,
    "notebook.codeActionsOnSave": {
        "source.organizeImports": "explicit"
    },
```

### リンターのimport errorを解消する: ①外部ライブラリ

リンターを利用していると，以下のように外部のライブラリのimportが解決できずにエラー扱いになることがある．この場合は，利用しているPythonのインタープリターが自分の利用したい仮想環境になっていない可能性がある．例えば仮想環境Aにはaseが入っているがBには入っておらず，リンターが仮想環境BのPythonを利用しているとこのようなエラーが発生する．

{% include figure popup=true image_path="/assets/posts/2025-05-05-python-vscode-formatter/linter_error_externallib.png" alt="" caption="" %}

この場合は`cmd+Shft+P` からPythonと検索して「Python: インタープリターを選択」から所望の仮想環境を選択する．

{% include figure popup=true image_path="/assets/posts/2025-05-05-python-vscode-formatter/select_python_interpreter.png" alt="" caption="" %}

### リンターのimport errorを解消する: ①自作ライブラリ

次に，同様のエラーが自作ライブラリで出る場合，単純に自作ライブラリのパスがVS Codeにちゃんと渡っていないだけの場合が多いだろう．

{% include figure popup=true image_path="/assets/posts/2025-05-05-python-vscode-formatter/linter_error_internallib.png" alt="" caption="" %}

プロジェクトのルートディレクトリに`.vscode/settings.json` ファイルを配置すると，このsettings.jsonはこのプロジェクトでのみ参照される設定ファイルとなる．このファイルの中に以下のように追加のパスを設定する．（パスは自分の環境に合わせること）

```yaml
{
  "python.analysis.extraPaths": ["./" ]
}
```

## 参考

- [VS Code linting](https://code.visualstudio.com/docs/python/linting)
- [flake8の使い方とオプション - Qiita](https://qiita.com/raku_taro/items/93dacae018fb192d05b5)
- [VSCodeでblackとflake8の設定をしてみた DevelopersIO](https://dev.classmethod.jp/articles/vscode_black_flake8/)
- [VSCodeで自作モジュールのimportエラーを解消してみた](https://dev.classmethod.jp/articles/vscode_python_import_error/)
- [VSCode拡張機能のBlack Formatterとisortを用いたPythonのコードフォーマット](https://nujust.hatenablog.com/entry/2022/07/24/114715)
