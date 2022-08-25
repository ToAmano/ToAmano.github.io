# AiiDA

注意!! 

1. AiiDAはまだ勉強中なので記述が間違っている可能性あり
2. 公式のチュートリアルやドキュメントがかなり充実しているのでそちらをよくチェックすること

[公式のdoc](https://aiida.readthedocs.io/projects/aiida-core/en/latest/)

[公式のtutorials](https://aiida-tutorials.readthedocs.io/en/latest/)

## AiiDA とは？

[AiiDA](https://www.aiida.net/)はオープンソースのpythonパッケージで，複雑な計算のワークフローを自動化したり，散らばりがちな計算の入出力結果をまとめて管理してくれる．例えば第一原理計算でバンド計算をやろうと思うと

1. 結晶構造をどこかから持ってくる
2. 計算条件を設定，擬ポテンシャルの用意
3. 結晶構造の最適化計算
4. バンド計算

などなど，作業としてはそこそこ面倒くさい．より複雑な計算も多くあるし，計算条件が適切かどうか（K点メッシュ，エネルギーカットオフなど）の収束計算もやる必要がある． AiiDAを使うと`ワークフロー`という自動化の仕組みがあり，これらの一連の流れを自動で行なってくれるだけでなく，結果もデータベースに格納してくれるので，後からあの時の計算の条件どうだったっけ？ などとあちこちディレクトリを探し回る必要もない．

またssh接続可能なリモートマシン上でも計算を実行できるので，AiiDAを自分のデスクトップやラップトップに入れておいて，複数の計算機サーバーなどと連携しながらデータの解析はローカルで行うということが可能である．

## [AiiDA installation](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/intro/install_system.html)

AiiDAは3つの核となる要素からなる．

1. aiida-core: pythonパッケージとverdiコマンド
2. PostgreSQL: AiiDAがデータを保存するために利用する
3. RabbitMQ: AiiDAとの通信で使うメッセージブローカー

今回はこのうち2と3をシステムに，1をcondaの仮想環境にインストールする．これは公式ではsystem-wide installationと呼ばれている．

```bash
# postgreSQLとRabbitMQのinstall
brew install postgresql rabbitmq git python

# データベースの起動
brew services start postgresql
brew services start rabbitmq
```

注意!! rabbitmqのversionがv3.8.15以上の場合，少し設定をいじる必要がある．
https://www.rabbitmq.com/configure.html#config-location
を参考にrabbitmqのconfigファイルの場所を探す．macでhomebrewで入れた場合は

```bash
/opt/homebrew/etc/rabbitmq/
```

にある．デフォルトでは`rabbitmq-env.conf`ファイルしかなかったので同じディレクトリに`rabbitmq.conf`ファイルを作成し，

```bash:rabbitmq.conf
consumer_timeout = 36000000000 # 10,000 hours in milliseconds
```

と書き込む．この設定をやってからrabbimqを起動しよう．

ついでaiida-coreをcondaの仮想環境内にインストールする．2022/08現在，M1macではcondaを使ったinstallが失敗（circusパッケージが見つからないというエラーが出る）したのでpipを使ってインストールした．conda仮想環境内でpipを利用する際の常として，仮想環境内にインストールされたpythonに付属のpipを利用すること．この場合だと`/人による/anaconda3/envs/aiida/bin/pip`のpipをちゃんと使っているかを確かめよう．

```bash
# intel macの場合
conda create -yn aiida 
conda install -c conda-forge aiida-core
conda activate aiida

# M1 macの場合
conda create -yn aiida 
curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
python get-pip.py
pip install aiida-core
```

最後に`which verdi`として仮想環境下にverdiがインストールされているか確認し，`verdi --version`でインストールされているversionを確認しておこう．これでインストールは成功である．

## AiiDAのプロファイル設定

無事インストールが終わったらAiiDAのプロファイルを設定する．

```bash
$ verdi quicksetup                                   
/opt/homebrew/lib/python3.10/site-packages/aiida/manage/configuration/settings.py:59: UserWarning: Creating AiiDA configuration folder `/Users/amano/.aiida`.
  warnings.warn(f'Creating AiiDA configuration folder `{path}`.')
Report: enter ? for help.
Report: enter ! to ignore the default and set no value.
Profile name [quicksetup]: ta
Email Address (for sharing data) [()]: tragic44cg@icloud.com
First name [()]: Tomohito
Last name [()]: Amano
Institution [()]: u-tokyo
Success: created new profile `ta`.
Report: initialising the profile storage.
Report: initialising empty storage schema
Success: storage initialisation completed.
```

ついでverdi daemonを起動する．

```bash
verdi daemon start 2
```

最後にセットアップがうまく行っているかを確認する．

```bash
$ verdi status
 ✔ version:     AiiDA v2.0.3
 ✔ config:      /Users/amano/.aiida
 ✔ profile:     ta
 ✔ storage:     Storage for 'ta' [open] @ postgresql://aiida_qs_amano_a88f57638875427b9c74c9eb1a467894:***@localhost:5432/ta_amano_a88f57638875427b9c74c9eb1a467894 / file:///Users/amano/.aiida/repository/ta
Warning: RabbitMQ v3.10.7 is not supported and will cause unexpected problems!
Warning: It can cause long-running workflows to crash and jobs to be submitted multiple times.
Warning: See https://github.com/aiidateam/aiida-core/wiki/RabbitMQ-version-to-use for details.
 rabbitmq:    Incompatible RabbitMQ version detected! Connected to RabbitMQ v3.10.7 as amqp://guest:guest@127.0.0.1:5672?heartbeat=600
 ✔ daemon:      Daemon is running as PID 99029 since 2022-08-13 16:08:36
```

rabbitmqに関するwarningが出ているが上でconfファイルをいじっていれば問題ない．

## optional installation

必須ではないがあると便利なパッケージを同じ仮想環境内にインストールしておく．

```bash
# 計算結果のワークフローを可視化してくれる
conda install graphviz

# 言わずと知れた物質計算御用達のpythonパッケージ．
conda install ase

# aiida restapiを起動するのに必要だった
pip install flask_cors
pip install flask_restful

# バンド図を可視化する際に使う場合がある
brew install grace
```

## tutorials, usage

自分の勉強で利用したチュートリアルやusageをいくつかリストアップ．
[まずは基本的な使い方をチェック](basic_tutorial.md)
[QEなどpython以外のコードの実行とリモートPCへの接続(QEの例)](add_computer.md)
[バンド計算を例にworkflowを試す](workflow_tutorial.md)
[AiiDAにおけるK点の取り扱い](aiida_kpoints.md)
[AiiDA+quantum espresso フォノン計算](aiida_ph.md)




## 細かい設定あれこれ

<!--  [job schedulerの設定(これはちょっとおかしいかも)](setting_jobscheduler.md)
https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/calculations/usage.html
-->


## [既存の計算結果をAiiDAに追加](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/howto/plugin_codes.html#how-to-plugin-codes)