# AiiDA

## AiiDA とは？

## [AiiDA installation](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/intro/install_system.html)

AiiDAは3つの核となる要素からなる．

1. aiida-core: pythonパッケージとverdiコマンド
2. PostgreSQL: AiiDAがデータを保存するために利用する
3. RabbitMQ: AiiDAとの通信で使うメッセージブローカー

今回はこのうち2と3をシステムに，1をcondaの仮想環境にインストールする．これは公式ではsystem-wide installationと呼ばれている．

```bash
# postgreSQLとRabbitMQのinstall
brew install postgresql rabbitmq git python
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

ついでaiida-coreをcondaの仮想環境内にインストールする．2022/08現在，M1macではcondaを使ったinstallが失敗（circusパッケージが見つからないというエラーが出る）のでpipを使ってインストールした．conda仮想環境内でpipを利用する際の常として，仮想環境内にインストールされたpythonに付属のpipを利用すること．この場合だと`/人による/anaconda3/envs/aiida/bin/pip`のpipをちゃんと使っているかを確かめよう．

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
 ✔ version:     AiiDA v2.0.3
 ✔ config:      /Users/amano/.aiida
 ✔ profile:     ta
 ✔ storage:     Storage for 'ta' [open] @ postgresql://aiida_qs_amano_a88f57638875427b9c74c9eb1a467894:***@localhost:5432/ta_amano_a88f57638875427b9c74c9eb1a467894 / file:///Users/amano/.aiida/repository/ta
Warning: RabbitMQ v3.10.7 is not supported and will cause unexpected problems!
Warning: It can cause long-running workflows to crash and jobs to be submitted multiple times.
Warning: See https://github.com/aiidateam/aiida-core/wiki/RabbitMQ-version-to-use for details.
 ⏺ rabbitmq:    Incompatible RabbitMQ version detected! Connected to RabbitMQ v3.10.7 as amqp://guest:guest@127.0.0.1:5672?heartbeat=600
 ✔ daemon:      Daemon is running as PID 99029 since 2022-08-13 16:08:36
```

rabbitmqに関するwarningが出ているが上でconfファイルをいじっていれば問題ない．


## optional installation

次のtutorialで使うので追加でパッケージをインストールしておく．

```bash
conda install graphviz
```

## [AiiDA Basic tutorial](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/intro/tutorial.html#tutorial-basic)

AiiDAはpython上で動くが，python上の簡単な計算のみならず，他の言語で書かれた外部コードの実行や，計算機サーバー上での計算にも対応している．


### python上での簡単な計算の場合

pythonでの簡単な計算でAiiDAのワークフローを体験する．ここではjupyter notebookを利用する．
最初におまじないを書く．

```python
from aiida import load_profile, engine, orm, plugins
from aiida.storage.sqlite_temp import SqliteTempBackend

%load_ext aiida

profile = load_profile(
    SqliteTempBackend.create_profile(
        'myprofile',
        sandbox_path='_sandbox',
        options={
            'warnings.development_version': False,
            'runner.poll.interval': 1
        },
        debug=False
    ),
    allow_switch=True
)
profile
```

AiiDAでは，計算のインプットや計算の手順，計算結果が全てnodeと呼ばれる量で扱われ，このnodeたちがdirected acyclic graph上に表され，保存される．


今回は掛け算をする単純なプログラムを使ってみる．

```python
from aiida import engine

@engine.calcfunction
def multiply(x, y):
    return x * y
```

### コンピュータの追加:リモートマシンで実行する場合1

ローカル以外のコンピューターでも利用したい場合には`verdi computer`コマンドでコンピュータを追加する必要がある．試しにローカルマシンをコンピュータとして追加してみよう．

```bash
# コンピュータのセットアップ
$ verdi computer setup -L tutor -H localhost -T core.local -S core.direct -w `echo $PWD/work` -n

# セットアップにyamlファイルを利用することもできる．
$ verdi computer setup --config ohtaka.yaml -n
$ verdi -p ta computer configure core.ssh ohtaka

# セットアップしたコンピュータを利用可能なように設定
$ verdi computer configure core.local tutor --safe-interval 1 -n
```

```python
# setup
%verdi computer setup -L tutor -H localhost -T core.local -S core.direct -w {profile.repository_path / 'work'} -n

# 登録してこのコンピュータに計算を投げられるようにする．
%verdi computer configure core.local tutor --safe-interval 0 -n
```

各種のオプションは以下

- label (-L): tutor (わかりやすいようなラベル)
- hostname (-H): localhost (ローカルマシンの場合はこれで良い．リモートの場合はssh接続先のhostname)
- transport (-T): local 
- scheduler (-S): direct (job schedullerなしの場合)
- work-dir (-w): The work subdirectory of the current directory
- n: non-interactive （追加の設定なしで済ませるため）

登録が完了したかどうかのチェックも`verdi computer`コマンドで可能だ．また，実際にこのコンピュータ用のワーキングディレクトリが作成されていることも確認しよう．

```bash
# configureしたコンピュータの一覧表示
$ verdi computer list
Report: List of configured computers
* tutor

# 特定のコンピュータの細かい設定表示
$ verdi computer show tutor
---------------------------  -----------------------------------------------
Label                        tutor
PK                           1
UUID                         b13064e6-bc8b-4abf-aeed-2254f31adeb2
Description
Hostname                     localhost
Transport type               core.local
Scheduler type               core.direct
Work directory               /Users/amano/works/research/aiida_tutorial/work
Shebang                      #!/bin/bash
Mpirun command               mpirun -np {tot_num_mpiprocs}
Default #procs/machine
Default memory (kB)/machine
Prepend text
Append text
---------------------------  -----------------------------------------------
```

これでコードが設定できていることを`verdi compute list`コマンドで指定する．


### リモートコンピュータの追加:リモートマシンで実行する場合2

同じようにリモートコンピュータを追加してみる．今度は-Tオプションでsshを選択し，-Sでリモートマシンのジョブスケジューラを設定する．ここでは例としてslurmにしてある．-wではリモートマシン上のディレクトリを指定するので注意．

```bash
# コンピュータのセットアップ
verdi computer setup -L sauron -H sauron -T core.ssh -S core.slurm -w `echo $PWD/sauron` -n

# コンピュータの登録
verdi -p ta computer configure core.ssh sauron
Report: enter ? for help.
Report: enter ! to ignore the default and set no value.
User name [amano]: amano
Port number [22]: 22
Look for keys [Y/n]: y
SSH key file [/Users/amano/.ssh/id_sauron_imacnew]: /Users/amano/.ssh/id_rsa_sauron
Connection timeout in s [60]: 180
Allow ssh agent [Y/n]: Y #重要
SSH proxy jump []:
SSH proxy command []:
Compress file transfers [Y/n]: y
GSS auth [False]:
GSS kex [False]:
GSS deleg_creds [False]:
GSS host [sauron]:
Load system host keys [Y/n]:
Key policy (RejectPolicy, WarningPolicy, AutoAddPolicy) [RejectPolicy]:
Use login shell when executing command [Y/n]: y
Connection cooldown time (s) [30.0]:
Report: Configuring computer sauron for user tragic44cg@icloud.com.

```

configureが終わったら`verdi computer test`コマンドでリモートマシンへの接続が成功しているかをチェックする．

```bash
verdi computer test sauron           22:21:05 
Report: Testing computer<sauron> for user<tragic44cg@icloud.com>...
* Opening connection... [OK]
* Checking for spurious output... [OK]
* Getting number of jobs from scheduler... [OK]: 0 jobs found in the queue
* Determining remote user name... [OK]: amano
* Creating and deleting temporary file... [OK]
Success: all 5 tests succeeded
```




### [外部コードを実行する場合](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/howto/run_codes.html#how-to-run-codes)

コンピュータの設定が完了したら，そのコンピュータ上で動かすコードを登録できる．これには`verdi code`コマンドを利用する．aiidaにプリインストールされているコードならば以下のようにすれば良い．

```bash
# tutorにcore.arithmetic.add(元々ある和を取るプログラム)を追加する例
$ verdi code setup -L add --on-computer --computer=tutor -P core.arithmetic.add --remote-abs-path=/bin/bash -n

# 追加されたことを確認
$ verdi code list
```

[Quantum espressoなどの外部コードを実行する場合](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/howto/plugins_install.html#how-to-plugins-install)，対応するAiiDAプラグインが必要なので，これをpipでインストールしておく．プラグインのリストは[ここ](https://aiidateam.github.io/aiida-registry)から確認できる．

```bash
# DFT計算で擬ポテンシャルを扱う場合(option)
pip install aiida-pseudo

# quantum espressoを利用する場合
pip install aiida-quantumespresso

# VASPを利用する場合 
pip install aiida-vasp

# インストール後，daemonを再スタートする．
$ verdi daemon restart --reset

# pluginが認識されていることを確認するには
# まずlistでカテゴリを表示
$ verdi plugin list

# ついでそのカテゴリ内のプラグインを表示(一例)
$ verdi plugin list aiida.calculations
```

yamlファイルで登録する場合．

```yaml:qe_7.0.yaml
---
label: "qe-7.0-pw"
description: "quantum_espresso v7.0 pw.x"
input_plugin: "quantumespresso.pw" #これが必要!!
on_computer: true 
remote_abs_path: "/home/amano/src/qe-7.0/bin/pw.x"
computer: "sauron"
prepend_text: " "
append_text: " "
```

追加する際のコマンドは以下のようになる．

```bash
# 追加
$ verdi code setup --config qe_7.0.yaml -n
Success: Code<3> qe-7.0-pw@sauron created

# 追加されたことを確認
$ verdi code list 

$ verdi code show qe-7.0-pw
```

### [AiiDAにjobを投入する](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/howto/run_codes.html#how-to-run-codes)

AiiDAにjobを投げるのにはいくつかのやり方がある．一つは`verdi shell`でインターラクティブにやる方法だが，ここでは入力ファイルを作成してjob投入するやり方をとる．この方法でも`verdi run`コマンドを利用する方法と，pythonコードとして実行する方法がある．いずれの場合も入力ファイルはpythonで書く必要があり，pythonコードとして実行する場合は追加でprofileやdaemonの情報が取得されるようにしてやる必要がある．

```bash
# verdiコマンドの場合
verdi run submit.py

# pythonコードの場合，submit.pyの先頭に
# #!/usr/bin/env python
# from aiida import load_profile
# load_profile()
# を書く必要がある．
python submit.py
```

### [実際にAiiDAにjobを投げる例](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/topics/processes/usage.html#topics-processes-usage-launching)

<!-- https://eminamitani.github.io/website/2021/03/25/aiida_2/ -->

QEでjobを実行してみよう．QEの場合の公式tutorialは[ここ](https://aiida-tutorials.readthedocs.io/en/tutorial-qe-short/)から確認できる．

#### step1: pseudoポテンシャルのDL

QEで使えるssspライブラリをインストールする．

```bash
# ライブラリのinstall
$ aiida-pseudo install sssp           
Report: downloading patch versions information...  [OK]
Report: downloading selected pseudopotentials archive...  [OK]
Report: downloading selected pseudopotentials metadata...  [OK]
Report: unpacking archive and parsing pseudos...  [OK]
Success: installed `SSSP/1.1/PBE/efficiency` containing 85 pseudopotentials.

# 正しくインストールしていることを確認
$ aiida-pseudo list
Label                    Type string         Count
-----------------------  ------------------  -------
SSSP/1.1/PBE/efficiency  pseudo.family.sssp  85
```

#### step2: 計算の設定ファイル(.py)の作成

```python
# -*- coding: utf-8 -*-
######################################################
# Si bulk phonon calculation
######################################################
from aiida.orm import Code, StructureData
from aiida.plugins import DataFactory
from aiida import orm
from aiida.plugins import CalculationFactory
from aiida.engine import launch
from aiida.orm import load_group
from ase.io import read # 構造を読み込む用

# code
# codename = 'qe-7.0-pw@sauron'
codename = 'qe-6.6-pw@ohtaka'
code = Code.get_from_string(codename)

# codeから，対応するbuilderを取得
builder = code.get_builder()


# control & system etc...
parameters = {
    'CONTROL': {
        'calculation': 'scf',
        'wf_collect': True,
    },
    'SYSTEM': {
        'ecutwfc': 80.,
        'ecutrho': 320.,
        'nbnd': 12,
    }
}

#structureはとりあえず手元のqeファイルから読みこむ
si=read("Si.scf.in",format="espresso-in")
s = StructureData(ase=si)

#kpoint
# The DataFactory is a useful and robust tool for loading data types based on their entry point, e.g. 'array.kpoints' in this case.
KpointsData = DataFactory('array.kpoints')
kpoints = KpointsData()
kpoints.set_kpoints_mesh([12, 12, 12])

#pseudo
family = load_group('SSSP/1.1/PBE/efficiency')


inputs = {
    'code': code,
    'structure': s,
    'pseudos': family.get_pseudos(structure=s),
    'kpoints': kpoints,
    'parameters': orm.Dict(dict=parameters),
    'metadata': {
        "description": " test qe calculation",
        'options': {
        'resources':  {'num_machines': 1,'tot_num_mpiprocs':24},
        'max_wallclock_seconds': 1*30*60, # h/m/s
        'withmpi': True,
        "queue_name": "i8cpu", # que name
#        "queue_name": "sky6126", # que name
        },
    }
}

# job submission
job=launch.submit(CalculationFactory('quantumespresso.pw'), **inputs)

# after submission
print('launched WorkChain<{}> for structure {}'.format(job.pk, s.get_formula()))
print("Use `verdi process list` or `verdi process show {}` to check the progress".format(job.pk))

# 計算完了後に自動でstdoutを取得できたらいいんだけどなぁ．
# verdi calcjob outputcat 125
```

- k点の設定

```python
The DataFactory is a useful and robust tool for loading data types based on their entry point, e.g. 'array.kpoints' in this case. 
```

### 計算プロセス， 結果の確認

`verdi process`コマンドによって結果を確認する方法がある．

```bash
# 走っているプロセスの一覧を表示
$ verdi process list 
  PK  Created    Process label             Process State    Process status
----  ---------  ------------------------  ---------------  ----------------
 125  12m ago    PwCalculation   running

# 特定のprocessについてのより詳しい情報を表示
$ verdi process show 125
Property     Value
-----------  ------------------------------------
type         PwCalculation
state        Finished [0]
pk           125
uuid         e82e1df9-2b41-4132-85b7-806e42d90560
label
description
ctime        2022-08-14 01:06:39.927911+09:00
mtime        2022-08-14 01:13:43.289752+09:00
computer     [3] sauron

Inputs      PK    Type
----------  ----  -------------
pseudos
    Si      36    UpfData
code        121   Code
kpoints     123   KpointsData
parameters  124   Dict
structure   122   StructureData

Outputs              PK  Type
-----------------  ----  --------------
output_band         128  BandsData
output_parameters   130  Dict
output_trajectory   129  TrajectoryData
remote_folder       126  RemoteData
retrieved           127  FolderData

```

計算終了後，stateが0になっていれば計算が成功していることを意味し，失敗していればそれ以外のstateになっているので原因を確認する．結果をより詳しく見る方法をいくつかリストアップする．

1. `verdi calcjob`コマンド

```bash
# コードのinputを取得
$ verdi calcjob inputcat 125
# インプットファイルの一覧
$ verdi calcjob inputls 125 -c

# コードのstdoutを取得
$ verdi calcjob outputcat 125

# Shows the parser results of the calculation
$ verdi calcjob res 125
```



1. `verdi data`コマンド

```bash

```


1. `verdi node graph generate` コマンド

   ノードの関連を可視化してくれるコマンド．
    ```bash
    # とりあえず実行
    verdi node graph generate 1026

    # pkを表示する場合. 
    verdi node graph generate 1026 --identifier pk
    ```


## 擬ポテンシャルのインストール(色々なライブラリ)

QEで使う擬ポテンシャルを色々インストールする．

```bash
# SSSPはefficiencyとprecision, PBEとPBEsol
$ aiida-pseudo install sssp -p efficiency -x PBE
$ aiida-pseudo install sssp -p precision -x PBE
$ aiida-pseudo install sssp -p efficiency -x PBEsol
$ aiida-pseudo install sssp -p precision -x PBEsol
# pseudo-dojo
$ aiida-pseudo install pseudo_dojo

# インストールされたことの確認
$ aiida-pseudo list
```

