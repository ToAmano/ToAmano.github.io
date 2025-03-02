---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: Pythonのlogging 
layout: single
date:   2025-2-23 21:00:00 +0900
categories: coding
tags:
 - python
header:
  teaser:
description: 自作のpythonライブラリでどのようにロギングすれば良いか勉強したのでそのまとめ．
---

自作のpythonライブラリでどのようにロギングすれば良いか勉強したのでそのまとめ．

## Python におけるロギング

Python でのプログラム開発において、デバッグやエラーハンドリングのために **`print()`** を使うのはよくあることである．小規模なコードならそれで良いが，コードが大きく，本格的になってくるに従って，より詳細なデバッグが必要になってくる．Pythonには標準で`logging` パッケージが提供されており，以下のような柔軟なログ管理が可能．

- ログの出力先の制御：stdoutだけでなく，指定したファイルにエラーを吐かせる
- ログレベルの制御：デバッグ用のログや，通常利用用のログなど，緊急度や利用法に応じて複数のログレベルを設定して制御する．
- 複数ログの利用：ログは細かく設定でき，例えばファイルごとに異なるログレベルを設定できる．

loggingの公式マニュアルはどうもわかりにくく，本記事では自作パッケージにロギングを入れるにあたって調べたことをまとめる．

[logging — Logging facility for Python](https://docs.python.org/3/library/logging.html)

## loggingパッケージの基本的な利用法

loggingを導入する場合，最初に試したいのは以下のようなコードだ．少し長いが，これをpythonファイルの冒頭に入れておいて，`print()` の代わりに`loggger.info()` を利用すれば良い．

`getLogger` 関数がログを設定する大元の関数で引数としてこのログの名前を取る．名前は自分にわかりやすいように自由に設定できるが，慣習上ファイル名にすることが多く`__name__` によってファイル名を入れる例がよく見られる．その後の`setLevel` メソッドでログの出力レベルを設定している．詳細は後で述べるとして，一旦ここは`INFO` にしておく．

```python
# おまじない
from logging import getLogger, StreamHandler, INFO
logger = getLogger(__name__)
handler = StreamHandler()
handler.setLevel(INFO)
logger.setLevel(INFO)
logger.addHandler(handler)
# 以下は実際にログを吐かせるときの文法
logger.debug('message')
logger.info('message')
logger.warning('message')
logger.error('message')
logger.critical('message')
```

 **Notice:** 別の書き方として，getLoggerを使わずに直接loggingライブラリの関数を使う方法もあるが，これは後述のようにあまりよくないので今回の記事では使わない．

```python
import logging
logging.debug('message')
logging.info('message')
logging.warning('message')
logging.error('message')
logging.critical('message')
```
 {: .notice}

## ログレベル

先にログレベルについて説明する．`logging` には、以下の 5 つのログレベルが用意されている．数値が小さいほどより細かい情報で，逆に数値が大きいほど致命的な問題に相当する．従って，数値が大きいものは常に表示したいが，数値が小さいものを表示するかは時と場合による，という振り分けになる．例えば開発者向けの細かいメッセージはDEBUGに設定し，ユーザーにも見てほしいライブラリのエラーはERRORに設定する．

| レベル | 数値 | 説明 |
| --- | --- | --- |
| DEBUG | 10 | デバッグ情報．詳細なメッセージはここに登録する． |
| INFO | 20 | 一般的な情報はここに登録する． |
| WARNING | 30 | 警告 |
| ERROR | 40 | エラー |
| CRITICAL | 50 | 重大なエラー |

ロギングの全てのメッセージはこのいずれかのレベルで書き出す．

```python
logger.debug('message') # debugレベルのメッセージ
logger.info('message')  # infoレベルのメッセージ
```

例えば`setLevel(DEBUG)` とすれば，DEBUG以上の**全てのログ**を出力する．これは名前の通り開発時のバグ取り時に有効で，通常出力すると煩わしいが，デバッグ時には役立つ情報は`logger.debug` で設定しておき，実行時にこれらを出力するかどうかは`setLevel` で制御する．こうした細かい出力制御はprint文では不可能で，loggingを採用する大きなメリットの一つである．

動作をイメージしやすいように以下の例を考える．`setLevel` で都度レベルを変更した時に，ログが実際どのように出力されるかをみる．

```python
# おまじない
from logging import getLogger, StreamHandler, INFO, CRITICAL, DEBUG
logger = getLogger(__name__)
handler = StreamHandler()
handler.setLevel(INFO) # INFOレベルに設定
logger.setLevel(INFO)
logger.addHandler(handler)
# 1回目のテスト
logger.debug('message') # 出力されない
logger.info('message') # 出力される
logger.warning('message')  # 出力される
logger.error('message')  # 出力される
logger.critical('message')  # 出力される
# 2回目のテスト（CRITICALレベルに設定）
handler.setLevel(CRITICAL) # INFOレベルに設定
logger.setLevel(CRITICAL)
logger.debug('message') # 出力されない
logger.info('message') # 出力されない
logger.warning('message')  # 出力されない
logger.error('message')  # 出力されない
logger.critical('message')  # 出力される
```

小さいコードならば，この辺までわかっていれば一旦print文の代わりにloggingを利用できるだろう．

## ロガーとハンドラ

ここからはもう少し込み入った話で，実際にライブラリを開発するにあたって必要になる（場合がある）事柄である．まず，loggingの基礎となる二つの概念，ロガー（Logger）とハンドラ（Handler）を導入する．

### ロガー

ロガーはログを生成するための基礎となるオブジェクトである．デフォルトでは先ほどのサンプルコードのように`logging.getLogger()`を使って取得する．ロガーのログレベルは`setLevel` メソッドで設定する．このレベルより高いレベルのログのみが記録される．

```python
from logging import getLogger, DEBUG
logger = getLogger("my_logger")
logger.setLevel(DEBUG)
```

### ハンドラ

ロガーを設定するだけではログは出力されない．例えば以下のコードを実行しても何も出力されないようになっている．

```python
from logging import getLogger, DEBUG
logger = getLogger("my_logger")
logger.setLevel(DEBUG)
logger.info("hello world.") # これはハンドラがないため出力されない
```

出力を可能にするのがハンドラで，一つのハンドラが一つの出力先（stdout, ファイル，etc…）を制御する．ハンドラをロガーに紐づけることで，初めてログが出力される．このような仕組みになっている理由は，一つのロガーから複数の出力先にログを出力できるようにするためだ．例えばstdoutにはINFOレベルで出して，ファイルにはDEBUGレベルで出して，というような細かい制御ができる．ハンドラは出力先に応じていくつか呼び出す関数用意されている．ここでは3つ紹介する．

```python
from logging import StreamHandler, FileHandler, SMTPHandler
stream_handler = StreamHandler() # stdoutへ
file_handler   = FileHandler("app.log") # app.logファイルへへ
mail_handler  = SMTPHandler(
    mailhost=("smtp.example.com", 587),
    fromaddr="noreply@example.com",
    toaddrs=["admin@example.com"],
    subject="Error Log",
    credentials=("username", "password"),
    secure=()) # メールを送信
```

ハンドラに対しても`setLevel` でログレベルを設定する．ロガーとハンドラのログレベルは別になっているのが紛らわしいポイントだが，ロガーのレベルはそもそも記録するログを設定するもので，ハンドラのレベルは実際に出力するかどうかを決めるものという違いがある．

```python
from logging import StreamHandler, INFO
stream_handler = StreamHandler() # stdoutへ
stream_handler.setLevel(INFO) # INFO以上をstdoutへ出力
```

ハンドラを定義したら，ロガーに対して`addHandler` メソッドでハンドラを紐づける．

```python
from logging import StreamHandler, INFO
logger = getLogger("my_logger")
logger.setLevel(DEBUG)
stream_handler = StreamHandler() # stdoutへ
stream_handler.setLevel(INFO) # INFO以上をstdoutへ出力
logger.addHandler(stream_handler) # ロガーにハンドラを追加
logger.info("hello world.") # 追加後初めてログが出る！
```

また，ハンドラの出力形式は，フォーマッター（formatter）でお好みのものに変更できる．Formatter関数でフォーマッタを作成するときに引数として希望する形式を入れる．あとはハンドラに`setFormatter` メソッドで設定する．

```python
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)
```

形式には各種の変数を利用でき，お好みのものを入れられる．

| 変数 | 概要 | 出力例 |
| --- | --- | --- |
| `%(asctime)s` | Timestamp of the log event | `2025-02-28 15:30:12,345` |
| `%(levelname)s` | Logging level name | `DEBUG`, `INFO`, `WARNING`, `ERROR`, `CRITICAL` |
| `%(name)s` | Logger name | `my_logger` |
| `%(message)s` | Log message content | `Process started successfully` |
| `%(filename)s` | Filename where the log was generated | `script.py` |
| `%(lineno)d` | Line number where the log was created | `42` |
| `%(funcName)s` | Function name where the log was generated | `process_data` |
| `%(threadName)s` | Thread name of the log event | `MainThread` |
| `%(process)d` | Process ID of the logging event | `12345` |

また，時間の形式は`datafmt` 変数で指定できる．

```python
formatter = logging.Formatter(
    "[%(asctime)s] %(levelname)s - %(message)s",
    datefmt="%Y/%m/%d %H:%M:%S"
)
```

```bash
[2025/02/28 15:30:12] INFO - ログ
```

### ロガーとハンドラの設定例

このsectionの最後に設定例のコードをいくつか示す．以下のコードでは，ログをstdoutとファイルの二つに出力する．まず以下はベタ書きで設定する例である．フォーマッタはstdoutもファイルも同一にしているが，もちろん異なるフォーマッタも設定できる．

```python
# おまじない
from logging import getLogger, StreamHandler, FileHandler, INFO
logger = getLogger(__name__)
logger.setLevel(INFO)
# formatter
formatter = logging.Formatter(
				 			'%(asctime)s - %(name)s - %(levelname)s - %(message)s',
							datefmt='%Y-%m-%d %I:%M:%S)
# stream handler
stream_handler = StreamHandler()
stream_handler.setLevel(INFO)
stream_handler.setFormatter(formatter)
logger.addHandler(stream_handler)
# file handler
file_handler = FileHandler("test.log")
file_handler.setLevel(INFO)
file_handler.setFormatter(formatter)
logger.addHandler(file_handler)
```

通常のライブラリでは，ログの設定を関数化して各ファイルで使い回す構成がよく見られるのでそれも一例として示す．以下の例では，引数としてロガーの名前，ログファイルとログレベルをとる．ログファイルが指定されなければstdoutへのハンドラのみ設定し，ログファイル名が指定されればそこにもログを吐く．

また，設定時の注意として，ハンドラが重複することを防ぐため，`if not logger.hasHandlers()` で条件分岐させてハンドラがない場合にのみ設定するようにすることが多い．notebookで実行している時に意図せずハンドラが増えてしまうことを防げる．

```python
def setup_main_logger(logger_name: str, log_file: str = None, level: int = logging.INFO):
    logger = logging.getLogger(logger_name)
    logger.setLevel(level)

    # Prevent the logger from adding duplicate handlers if it has already been initialized
    if not logger.hasHandlers():
        # Console handler
        console_handler = logging.StreamHandler()
        console_handler.setLevel(level)
        console_formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s',datefmt='%Y-%m-%d %I:%M:%S %p')
        console_handler.setFormatter(console_formatter)
        logger.addHandler(console_handler)
        # Optional file handler
        if log_file:
            file_handler = logging.FileHandler(log_file)
            file_handler.setLevel(level)
            file_formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s',datefmt='%Y-%m-%d %I:%M:%S %p')
            file_handler.setFormatter(file_formatter)
            logger.addHandler(file_handler)
    return logger
```

## 親ロガーと子ロガー

ライブラリを作ってファイルが増えてきて，ファイルごとに`getLogger` で新しいロガーを作ると，どんどんロガーの数が増える．これらのロガーは基本独立でお互いに無関係だが，階層構造を持たせることもでき，親ロガーと子ロガーを設定できる．親子関係はロガーの名前から自動的に判定される．具体的には親ロガーの名前にピリオドで文字列を追加すると子ロガーと判定される．例えば`A` というロガーと`A.B` というロガーがあれば，後者は前者の子ロガーである．

```python
parent_logger = logging.getLogger("parent") # 親ロガー
child_logger = logging.getLogger("parent.child") #子ロガー
```

親ロガーで設定したハンドラやフォーマッタは子ロガーにも自動的に適用される．従って，小ロガーで別途レベルやハンドラを設定する必要はない．以下の例では`child_logger` は `parent_logger` の設定を継承し、INFO レベル以上のログを記録する．

```python
from logging import getLogger, StreamHandler, Formatter, INFO

# 親ロガー
parent_logger = getLogger("parent")
parent_logger.setLevel(INFO)
console_handler  = StreamHandler()
console_handler.setLevel(INFO)
parent_logger.addHandler(console_handler)
console_handler.setFormatter(Formatter("[%(name)s] %(levelname)s: %(message)s"))

# 子ロガー
child_logger = getLogger("parent.child")
parent_logger.info("親ロガーのログです")
child_logger.info("子ロガーのログです") # 子ロガーで明示的にハンドラを指定しなくてもstdoutに出る．

```

```bash
[parent] INFO: 親ロガーのログです
[parent.child] INFO: 子ロガーのログです
```

もちろん，小ロガーでも明示的に設定すればそちらに従う．

この親子ロガーの関係はライブラリのファイル中の階層構造を反映させることができれば非常に便利である．

## コマンドライン実行とNotebook実行

今回やりたかったことを最後に紹介して終わる．アプリケーションを開発しており，使い方として以下の二つを想定する．

- コマンドラインからコマンドとして実行する場合．大規模計算のためスパコンクラスタで実行する想定で，ファイルにログを残したい．
- ライブラリファイルとして，notebookから呼び出す場合．ただし，冗長なのでファイルにログは吐きたくなく，stdoutだけあれば良い．

この場合，`FileHandler`と`StreamHandler`の二つのハンドラが必要で，かつ実行形態によって切り替えないといけない．

最初にコマンドライン実行時にファイルログを残す方から考えよう．実行したディレクトリに`stdout.log` という名前でログを保存したい．簡単のために呼び出すmain.pyとライブラリファイルmylib.pyを考えよう．

```bash
$tree 
.
├── main.py
└── mylib.py
```

```python
import mylib

if __name__ == '__main__':
	mylib.test(10)	
```

```python
def test(x:int):
	return x*x
```

やってみて分かったのだが，`mylib.py`でハンドラを設定するには実行時ディレクトリを取得しないといけないが，それが意外とできそうでできない．一番簡単にこれを回避する方法は，`main.py` でも`mylib.py` でも同名のロガーを利用する方法である．こうして`main.py` の方でハンドラを指定すれば`mylib.py` で追加の設定は不要になる．このように，`getLogger` で同じ名前でロガーが呼び出されると，最初に呼び出したものが参照される．

```python
import mylib
# おまじない
from logging import getLogger, StreamHandler, INFO
logger = getLogger("main")
handler = StreamHandler()
handler.setLevel(INFO)
logger.setLevel(INFO)
logger.addHandler(handler)

if __name__ == '__main__':
	logger.info('log from main.py')
	mylib.test(10)
```

```python

from logging import getLogger, StreamHandler, INFO
logger = getLogger("main")

def test(x:int):
	logger.info('log from mylib.py')
	return x*x
```

ただしこの方法ではライブラリファイルが増えてきたときにどのファイルからのログか分かりにくすぎる．そこで`mylib.py` の方は`main.py` の小ロガーとし，`main.py` のハンドラ設定を継承することにした．このために名前を`main.` の後にサフィックスを足したものとした．この形ならばライブラリファイルが増えてきても子ロガーの名前を色々変えて修正できる．

```python
import mylib
# おまじない
from logging import getLogger, StreamHandler, INFO
logger = getLogger("main")
handler = StreamHandler()
handler.setLevel(INFO)
logger.setLevel(INFO)
logger.addHandler(handler)

if __name__ == '__main__':
	logger.info('log from main.py')
	mylib.test(10)
```

```python
from logging import getLogger, StreamHandler, INFO
logger = getLogger("main"+__name__)

def test(x:int):
	logger.info('log from mylib.py')
	return x*x
```

次にnotebookから呼び出すことを考えよう．今のままだと，`main.py` から呼ばれなければ`mylib.py` には親ロガーが存在しないことになりログが出てこない．そこで`sys.argv` をチェックして指定のコマンドラインから実行しているかを確認し，それに応じて小ロガーを返すか新たにライブラリロガーを定義するかを変更する．これを実現するため，`main.py` から呼ぶロガーを設定する関数(setup_main_logger)と，ライブラリから呼ぶロガーを設定する関数(setup_library_logger)を別のものとして定義することにした．`setup_library_logger`では，`command_list` に呼び出しのコマンドライン関数を色々指定することで，ここのコマンドラインから呼び出された場合は小ロガーとして設定し，それ以外なら通常通りロガーを設定する．

```python

def setup_main_logger(logger_name: str, log_file: str = None, level: int = logging.INFO):
    logger = logging.getLogger(logger_name)
    logger.setLevel(level)

    # Prevent the logger from adding duplicate handlers if it has already been initialized
    if not logger.hasHandlers():
        # Console handler
        console_handler = logging.StreamHandler()
        console_handler.setLevel(level)
        console_formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s',datefmt='%Y-%m-%d %I:%M:%S %p')
        console_handler.setFormatter(console_formatter)
        logger.addHandler(console_handler)
        # Optional file handler
        if log_file:
            file_handler = logging.FileHandler(log_file)
            file_handler.setLevel(level)
            file_formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s',datefmt='%Y-%m-%d %I:%M:%S %p')
            file_handler.setFormatter(file_formatter)
            logger.addHandler(file_handler)
    return logger

def setup_library_logger(logger_name: str, log_file: str = None, level: int = logging.INFO):
    IF_COMMANDLINE = False
    command_list:list[str] = ["main.py","main2.py"]
    for command in command_list:
        if command in sys.argv:
            IF_COMMANDLINE = True  # if execute from command line (CPtrain.py CPextract.py, etc...)
    if IF_COMMANDLINE:  # if execute from command line (CPtrain.py CPextract.py, etc...)
        # we do not make handler as it is already made in the root logger
        logger = logging.getLogger(logger_name)
        logger.setLevel(level)
        logger.propagate = True
        return logger
    else: # if execute not from the command line
        return setup_main_logger(logger_name, log_file, level)
```

## まとめ

Pythonの`logging`パッケージを活用して適切なロギングを実装できる．

- `Logger` でログを作成
- `Handler` で出力先を設定
- `Formatter` でログのフォーマットを統一

適切なロギングを導入することでプログラムのデバッグや運用がよりスムーズになるので，printはやめるべき．

## 参考文献

- 公式ドキュメント
  - [Logging HOWTO](https://docs.python.org/3/howto/logging.html)
    

- webの記事
  -  [Python のロギングを完全に理解する - Qiita](https://qiita.com/smats-rd/items/c5f4345aca3a452041c7)
