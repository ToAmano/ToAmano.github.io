---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title:  pre-commit/github actionでコミット/PR時にコードチェックを行う
layout: single
date:   2025-5-24 21:00:00 +0900
categories: coding
tags:
 - git
 - python
 - CICD
header:
  teaser:
description: Gitのpre-commitフックはコミット前に自動でコードの整形やチェックを行うことでコードの品質を保つための強力なツールである．本記事ではpre-commitフックの概要と主にPythonプロジェクトでの具体的な利用方法，GitHub Actionsとの連携方法を解説する．
---


Gitのpre-commitフックはコミット前に自動でコードの整形やチェックを行うことでコードの品質を保つための強力なツールである．本記事ではpre-commitフックの概要と主にPythonプロジェクトでの具体的な利用方法，GitHub Actionsとの連携方法を解説する．

公式のドキュメントとして，以下の二つに目を通されたい．

- [pre-commit](https://pre-commit.com/)
- [pre-commit hooks](https://pre-commit.com/hooks.html)

## pre-commitとは？

Gitのpre-commitはその名の通り，コミットが実行される前に特定のスクリプトを自動で実行する仕組みのこと．これによりコードの整形や静的解析，テストの実行などを自動化してコードの品質を向上できる．特にフォーマットやリンターは作業中どれだけ気をつけていても適用が漏れることがあるので，こうしたツールで自動適用するに越したことはない．

一方で，毎コミット時に実施されるのであまり重い操作を入れると作業効率が落ちる点には注意が必要で，重いテストなどは入れない方が良いだろう．

pre-commit自体はローカルで動作するコマンドであり，各開発者が個別に導入する必要があるが，GitHub actionsでpre-commitを実行するワークフローを導入すればレポジトリにプッシュされた時に自動で動作するようにできるため，この組み合わせも重要だ．

## pre-commitのローカル環境への導入・実行方法

### **インストール**

Python環境がある場合は`pip` から導入できる．

```bash
pip install pre-commit
```

### **設定ファイルの作成**

プロジェクトのルートディレクトリに `.pre-commit-config.yml` ファイルを作成する．このファイルの中に利用するフックを全て定義する．一例として，末尾の空白を削除する trailing-whitespace フックとファイルの末尾に改行を追加する end-of-file-fixer フックを使用する例を示す．

```bash
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v3.2.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
```

基本的にフックはGitHubのレポジトリに登録されていて,`repo`でそのURLを指定する．`rev` はタグやリリースの番号やブランチ名を指定する．基本的にバージョンの新しいものを使うのがよく，各レポジトリで最新バージョンを確認しよう．

また，手動でファイルを用意しなくてもpre-commitコマンドにはサンプルのconfigファイルを用意するオプションがあり，以下のようにすれば良い．

```bash
pre-commit sample-config > .pre-commit-config.yaml
```

revのバージョンが最新でない場合，場合によっては`autoupdate` オプションで自動で設定ファイルを書き換えられる可能性がある（ダメな場合もあるので都度確認が必要）．

```bash
pre-commit autoupdate
```

より詳細な設定ファイルについては後述するとして，一旦先へ進む．

### **フックのインストール**

以下のコマンドでフックをインストールしてコミット時に自動で実行されるようにする．

```bash
pre-commit install
```

このコマンドはyamlファイルに登録されているリポジトリからコードをダウンロード，インストールする．これにより `.git/hooks/pre-commit` にスクリプトが配置されてコミット時に定義されたフックが実行される．installに失敗する場合は，レポジトリのバージョンが古い可能性があるため`rev` を見直そう．

一回インストールしたものを消したい場合は

```bash
pre-commit uninstall
```

とすれば良い．

### フックの実行

あとはコミットすれば勝手にこのフックが実行される．コミット時以外にフックを実行したい場合は，`run` コマンドを実行する．以下の例ではレポジトリの全てのファイルについてチェックを実行するが，特定ファイルだけに絞りたい場合は`--files` オプションでテストしたいファイルを指定しよう．

```bash
pre-commit run --all-files
```

もしも成功すれば以下のようにそれぞれのフックに対して`Passed` の表示が出る．この場合はそのままコミットして問題ない．

```bash
Trim Trailing Whitespace.................................................Passed
Fix End of Files.........................................................Passed
Check Yaml...............................................................Passed
Check JSON...............................................................Passed
Check for added large files..............................................Passed
Check Toml...............................................................Passed
isort....................................................................Passed
black....................................................................Passed
mypy.....................................................................Passed
flake8...................................................................Passed
pylint...................................................................Passed
```

一方でチェックに引っかかる項目がある場合はエラーとして検出され，この状態でコミットすることはできなくなる．以下はmypyでエラーが出ている様子を示した一例だ．

```bash
Trim Trailing Whitespace.................................................Passed
Fix End of Files.........................................................Passed
Check Yaml...............................................................Passed
Check JSON...............................................................Passed
Check for added large files..............................................Passed
Check Toml...........................................(no files to check)Skipped
isort....................................................................Passed
black....................................................................Passed
mypy.....................................................................Failed
- hook id: mypy
- exit code: 1

src/backend/explanation.py:13: error: Incompatible return value type (got "Any | None", expected "str")  [return-value]
src/app.py:95: error: Name "word" already defined on line 44  [no-redef]
src/app.py:100: error: Name "word_status_key" already defined on line 47  [no-redef]
src/data/generate_explanation/make_explanation.py:167: error: Need type annotation for "fully_processed_words" (hint: "fully_processed_words: set[<type>] = ...")  [var-annotated]
src/data/generate_explanation/make_explanation.py:168: error: Need type annotation for "word_explanation_dict" (hint: "word_explanation_dict: dict[<type>, <type>] = ...")  [var-annotated]
src/data/generate_explanation/make_explanation.py:200: error: Incompatible return value type (got "str", expected "list[str]")  [return-value]
src/data/generate_explanation/make_explanation.py:206: error: "dict[Any, Any]" has no attribute "iterrows"  [attr-defined]
src/backend/core/db_core.py:25: error: Incompatible return value type (got "Any | None", expected "str")  [return-value]
Found 8 errors in 4 files (checked 16 source files)

```

## Pythonプロジェクトでのpre-commitフレームワークの活用

Pythonプロジェクトではblackやisortなどのフォーマッタや，flake8やmypyなどのリンターと組み合わせて使われることが多く，コードの整形や静的解析を自動化するのに一役買っている．

### **Pythonプロジェクト用設定ファイルの例**

以下によく利用するフォーマッタ，リンターを利用した`.pre-commit-config.yml` の例を示す．バージョンについては執筆時点（2025/5）のものなので，場合によって古い可能性がある．各ツールに対して，`args` で追加のオプションを指定している．例えばデフォルトの`isort` では`black`と競合する部分があるため，オプションで`—profile black` を指定している，という具合だ．flake8やpylintは全てを厳密に守ろうとするととても大変なので一部例外を入れるようなことを（個人開発なら）やっても良いと思う．

```yaml
# See https://pre-commit.com for more information
# See https://pre-commit.com/hooks.html for more hooks
repos:
-   repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v3.2.0
    hooks:
    -   id: trailing-whitespace
    -   id: end-of-file-fixer
    -   id: check-yaml
    -   id: check-json
    -   id: check-added-large-files
    - id: check-toml
- repo: https://github.com/pycqa/isort
  rev: 6.0.1
  hooks:
    - id: isort
      args: ["--profile", "black"]
- repo: https://github.com/psf/black
  rev: 25.1.0
  hooks:
  - id: black
    language_version: python3
- repo: https://github.com/pre-commit/mirrors-mypy
  rev: v1.15.0
  hooks:
    - id: mypy
      args: [--ignore-missing-imports, --strict]
- repo: https://github.com/PyCQA/flake8
  rev: "7.2.0"
  hooks:
  - id: flake8
    # max-line-length setting is the same as black
    # commit cannot be done when cyclomatic complexity is more than 10.
    args: [--max-line-length, "150", --ignore=E402,--ignore=E800, --max-complexity, "10", --max-expression-complexity=7, --max-cognitive-complexity=7]
    additional_dependencies: [flake8-bugbear, flake8-builtins, flake8-eradicate, pep8-naming, flake8-expression-complexity, flake8-cognitive-complexity]
- repo: https://github.com/pylint-dev/pylint
  rev: v3.3.7
  hooks:
    - id: pylint
      name: pylint
      entry: pylint
      language: python
      types: [python]
      additional_dependencies: [pandas,streamlit,langchain,dotenv,langchain_google_genai]
      args: [--max-line-length,"150","--init-hook", "import sys; sys.path.insert(0, 'src')"]
```

## GitHub Actionsとの連携

pre-commitフレームワークはGitHub Actionsと連携してCI/CDパイプラインに組み込める．これにより，リモートリポジトリへのPR時にもコードの整形や静的解析を自動で実行できる．複数人開発や複数マシンでの開発では都度都度ローカルにpre-commit環境を整備するのを忘れてしまう場合もあるため，CI/CDで管理しておくと安心できる．

### **GitHub Actionsの設定例**

設定ファイルは例えば`.github/workflows/pre-commit.yml` として，以下のようにする．やっていることは単純で，pipでコマンドをインストールして`pre-commit run` を実行するだけ．ただし，mypyのようなリンターを利用する場合，型定義のための追加パッケージもここでインストールしないといけない場合がある．

```bash
name: pre-commit

on:
  pull_request:
    branches:
      - main # 保護対象ブランチ名に応じて変更
      - develop
jobs:
  pre-commit:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: "3.11"

      - name: Install dependencies
        run: |
          python -m pip install --upgrade pip
          pip install pre-commit
          pre-commit install

      - name: Run pre-commit
        run: pre-commit run --all-files
```
## まとめ

pre-commitを利用したフォーマッタやリンターの適用はコードの品質を保つために非常に重要だ．さらにGitHub Actionsとの連携によりCI/CDパイプラインにも組み込める．

## おまけ（よく使うpre-commitコマンド）

```bash
# インストール
pip install pre-commit
# テンプレート生成
pre-commit sample-config > .pre-commit-config.yaml
# hookのアップデート
pre-commit autoupdate
# 設定のインストール
pre-commit install
# 設定のアンインストール
pre-commit uninstall
# フックの実行
pre-commit run --all-files

```

## References

- [pre-commitでコミット時にコードの整形やチェックを行う](https://zenn.dev/yiskw713/articles/3c3b4022f3e3f22d276d)
- [pre-commit と GitHub Actions で実行する flake8 と black の設定を共有する方法 - Qiita](https://qiita.com/curry_on_a_rice/items/9c7a96324d76761d98c6)
- [【Git hooks】pre-commitフック導入](https://zenn.dev/sun_asterisk/articles/97d2b4be675c06)