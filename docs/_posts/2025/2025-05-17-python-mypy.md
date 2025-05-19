---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: Python自作ライブラリ向けの，mypyによる静的型チェック
layout: single
date:   2025-5-17 21:00:00 +0900
categories: coding
tags:
 - python
header:
  teaser:
description: Python向けコードリンターであるmypyを自作パッケージで利用するための設定方法について解説．
---

Python用のコードリンターである`mypy`は，変数の型指定を厳格に行うためのlinterである．Pythonは本来動的型付け言語なのでコード自体は型付けなしでかけてしまうが，長期的なメンテナンスや複数人での開発を考えるとバグの温床になる．昔かいたコードをみて入力はどうするべきだっけとなるのはよくある話かと思う．．． そこで，静的型チェックを導入して擬似的に型指定を強制する方法が取られる．`mypy` はそのためのリンターである．

型指定を行ったPythonコードは，変数にコロンで変数を指定する．別途typingという型付け用のライブラリもあって柔軟な設定もできる．今回は型付け方法には深入りせず，これは既知のものとして話を進める．

```python
"""sample.py"""
from typing import List

def greet(name: str) -> str:
    """基本的な型指定"""
    return "Hello, " + name

def average(values: List[float]) -> float:
   """typingを用いた型指定"""
    return sum(values) / len(values)
```

## 1. `mypy`とは何か

`mypy` はPython 3系で導入された[型ヒント（type hints）](https://docs.python.org/ja/3/library/typing.html)を基盤として，**コードの実行前に型の整合性を検査**する．コード中に型の不一致があればそれを検出する．

### `mypy`のメリット

- **バグの早期発見**：実行前に型の不一致を発見できる
- **可読性と保守性の向上**：引数や戻り値の意図が明確になり、他者がコードを理解しやすくなる
- **補完精度の向上**：IDEやLSPとの連携で、補完やリファクタリングがより安全になる

## 2. `mypy`の基本的な使い方

インストールはpipまたはcondaからできる．

```bash
pip install mypy
conda install mypy
```

**型チェック対象のサンプルコード**

```python
# sample.py
def greet(name: str) -> str:
    return "Hello, " + name

greet(42)  # 実行時はエラーにならないが、型的には入力をstr型にするべきで不正
greet("Taro") # こちらは型的にも正しい
```

**型チェックの実行**

```bash
$mypy sample.py
sample.py:5: error: Argument 1 to "greet" has incompatible type "int"; expected "str"
Found 1 error in 1 file (checked 1 source file)
```

このように，型ヒントに基づき実行前に型の不整合を検出できる．プロジェクトでは，github actionや，pre-commitでmypyによるチェックを強制することで，型指定がおかしいコードがコミット/マージされるのを防ぐような使い方をする．

また，numpyなどの外部ライブラリから利用している部分についても，**その外部ライブラリに型指定があれば（大抵の有名どころはある）**出力に反映される．一部のライブラリは別途型指定用のライブラリをインストールする必要がある．一例として`pandas` では，[`pandas-stubs`](https://pypi.org/project/pandas-stubs/) をインストールするとmypyが動作する．

```bash
pip install pandas-stubs
```

以下のようなpandasを利用したサンプルコードを準備する．

```bash
import pandas as pd

decimals = pd.DataFrame({'TSLA': 2, 'AMZN': 1})
prices = pd.DataFrame(data={'date': ['2021-08-13', '2021-08-07', '2021-08-21'],
                            'TSLA': [720.13, 716.22, 731.22], 'AMZN': [3316.50, 3200.50, 3100.23]})
rounded_prices = prices.round(decimals=decimals)
```

このコードはdecimalsの指定をpd.DataFrameでやっているところがおかしく，本来はSeriesを利用するべきである．pandas-stubs導入後にmypyを実行すると，以下のようにちゃんと警告が出る．

```bash
$mypy round.py
round.py:6: error: Argument "decimals" to "round" of "DataFrame" has incompatible type "DataFrame"; expected "Union[int, Dict[Any, Any], Series[Any]]"  [arg-type]
Found 1 error in 1 file (checked 1 source file)
```

## **3. 自作ライブラリにmypyを導入する方法**

自作ライブラリに対して`mypy`による型チェックを有効にするには、型付きパッケージのマークのための空ファイル（`py.typed`），およびプロジェクトの設定ファイル（`setup.py`など）に追加の設定が必要である。

### **3.1 ディレクトリ構成例**

```yaml
myproject/
├── mylib/
│   ├── __init__.py
│   ├── core.py
│   └── py.typed
├── tests/
│   └── test_core.py
└── setup.py
```

<aside>
🚫

> py.typed は空ファイルでよい。これを含めることで、mypy は当該パッケージを型情報付きとして認識する。
>
</aside>

### **3.2 py.typedファイル**

ライブラリが型指定に対応していることを示すため，`mylib/` 直下に`py.typed`という空ファイルを用意する．特にファイルの中に何か書く必要はない．

### 3.3 プロジェクトファイルの設定

mypyの設定は，プロジェクトルートに配置されている設定ファイルで実施する．詳細は[ドキュメント](https://mypy.readthedocs.io/en/stable/config_file.html)を参照してほしい．Pythonのプロジェクトファイルである`pyproject.toml`，`setup.cfg`，`setup.py`に設定するか，mypy専用の設定ファイル`mypy.ini`に設定する．ここではこれらの複数のパターンを紹介する．

- `mypy.init`による構成

    以下のようなtoml形式のファイルを準備する．

    ```yaml
    # mypy.ini
    [mypy]
    python_version = 3.10
    strict = True
    ignore_missing_imports = True
    
    [mypy-tests.*]
    disallow_untyped_defs = False
    ```

  - strict = True: より厳密なチェックを有効化
  - ignore_missing_imports = True: 外部ライブラリの型が未定義でも無視する（必要に応じて）

- `setup.cfg`による構成

    `setup.cfg`内に以下のような追加設定を入れる．ただしもうドキュメンテーションに細かい設定方法が書いてないのと，手元だとstrictのようなオプションは指定しても効いてなさそうなので，素直に`pyproject.toml`に移行した方が良いかもしれない．（要検証）

    ```python
    [options.package_data]
    mlwc = py.typed
    
    [tool.mypy]
    mypy_path = src
    ```

- `pyproject.toml`による構成

    pyprojectの場合，セクション名を`tool.mypy` とする．パッケージごとに追加の細かい設定をする場合は`tool.mypy.overrides` で追加設定を記述する．

    ```python
    # mypy global options:
    
    [tool.mypy]
    python_version = "3.10"
    warn_return_any = true
    warn_unused_configs = true
    exclude = [
        '^file1\.py$',  # TOML literal string (single-quotes, no escaping necessary)
        "^file2\\.py$",  # TOML basic string (double-quotes, backslash and other characters need escaping)
    ]
    
    # mypy per-module options:
    
    [[tool.mypy.overrides]]
    module = "mycode.foo.*"
    disallow_untyped_defs = true
    
    [[tool.mypy.overrides]]
    module = "mycode.bar"
    warn_return_any = false
    
    [[tool.mypy.overrides]]
    module = [
        "somelibrary",
        "some_other_library"
    ]
    ignore_missing_imports = true
    ```

- setup.pyによる構成

    近年はもう非推奨になっているsetup.pyだが，これでも一応mypyの設定は可能．

    ```python
    # setup.py
    from setuptools import setup
    
    setup(
       package_data={"package_a": ["py.typed"]},
        ...
        options={
            'mypy': {
                'python_version': '3.10',
                'strict': 'True',
                'ignore_missing_imports': 'True',
            }
       
    ```

### **3.4 チェックの実行**

チェックは今まで通りmypyコマンドで実行する．

```bash
mypy mylib/
```

## まとめ

今回は，mypyの紹介とともに，自身の自作ライブラリにmypyを反映させるために必要だった設定をまとめた．

- mypy はPythonの型ヒントに基づいて静的型チェックを行うツールである．
- 自作ライブラリでは`py.typed`を含めることで型付きライブラリとして`mypy`に認識させる必要がある．
- 自作ライブラリでは，設定ファイルに設定を追加する必要がある．

他のフォーマッタ，リンターと合わせたCI/CD向けの設定等についてはまた追って記事にしようと思う．
