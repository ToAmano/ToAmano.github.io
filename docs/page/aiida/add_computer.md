
# 外部コードを実行する

外部コードを利用する場合，`computer`と`code`という概念を理解する必要がある．`computer`は計算を実行するマシンのことであり，AiiDAのインストールされているマシン(localhost)のみならず，ssh接続できる他のマシンも指定できる．なので自分のデスクトップにAiiDAをインストールしてデータの解析はここで行い，実際の重い計算はスーパーコンピュータシステムで行うようなことが可能である．一方`code`はコンピュータ上で実際に実行するコードのことであり，例えばQuantum Espresso(QE)のようなパッケージのほか，自作のコードも指定できる．`code`は`computer`ごとに指定する必要があり，例えばQEを自分のパソコンでもスーパーコンピュータでも実行したい場合，QE@localhostとQE@supercomputerのようにそれぞれのコンピュータ用に設定する必要がある．

## コンピュータの追加:リモートマシンで実行する場合1

ローカル以外のコンピューターでも利用したい場合には`verdi computer`コマンドでコンピュータを追加する必要がある．試しにローカルマシンをコンピュータとして追加してみよう．

```bash
# コンピュータのセットアップ
$ verdi computer setup -L tutor -H localhost -T core.local -S core.direct -w `echo $PWD/work` -n
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

これでコードが設定できていることを`verdi compute list`コマンドで確認する．

## リモートコンピュータの追加:リモートマシンで実行する場合2

同じようにリモートコンピュータを追加してみる．今度は-Tオプションでsshを選択し，-Sでリモートマシンのジョブスケジューラを設定する．ここでは例としてslurmにしてある．-wは実際に計算を行うディレクトリで，リモートマシン上のディレクトリを指定するところなので注意．

```bash
# コンピュータのセットアップ
verdi computer setup -L sauron -H sauron -T core.ssh -S core.slurm -w "/home/.aiida_run" -n

# コンピュータの登録
verdi -p ta computer configure core.ssh sauron
Report: enter ? for help.
Report: enter ! to ignore the default and set no value.
User name [amano]: amano
Port number [22]: 22
Look for keys [Y/n]: y
SSH key file [/Users/amano/.ssh/id_sauron_imacnew]: /Users/amano/.ssh/id_rsa_sauron
Connection timeout in s [60]: 180
Allow ssh agent [Y/n]: y
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
Report: Configuring computer COM for user USER.
```

configureが終わったら`verdi computer test`コマンドでリモートマシンへの接続が成功しているかをチェックする．

```bash
$ verdi computer test sauron      
* Opening connection... [OK]
* Checking for spurious output... [OK]
* Getting number of jobs from scheduler... [OK]: 0 jobs found in the queue
* Determining remote user name... [OK]: amano
* Creating and deleting temporary file... [OK]
Success: all 5 tests succeeded
```

これが成功していればとりあえずはリモートマシンへのssh接続，ジョブスケジューラへの接続は成功している．


## [外部コードを実行する場合](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/howto/run_codes.html#how-to-run-codes)

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
remote_abs_path: "/home/amano/src/qe-7.0/bin/pw.x" # コマンドへのpath
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

## [実際にAiiDAにjobを投げる](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/howto/run_codes.html#how-to-run-codes)

```bash
verdi run submit.py
```

## [実際にAiiDAにjobを投げる:QE](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/topics/processes/usage.html#topics-processes-usage-launching)

<!-- https://eminamitani.github.io/website/2021/03/25/aiida_2/ -->

QEでjobを実行してみよう．QEの場合の公式tutorialは[ここ](https://aiida-tutorials.readthedocs.io/en/tutorial-qe-short/)から確認できる．

### step1: pseudoポテンシャルのDL

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

### step2: 計算条件， 結晶構造, K点, 擬ポテンシャルを指定した入力ファイルの作成

公式チュートリアルのようにインターラクティブにやることも可能だが，ここでは入力ファイルを作成する方法を試す．

```python
The DataFactory is a useful and robust tool for loading data types based on their entry point, e.g. 'array.kpoints' in this case. 
```

1. [ジョブスケジューラの計算リソースなど，QE以外の設定](https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/calculations/usage.html)
QEのinput以外の設定は`metadata`に設定する．メタデータとは、実行されたプロセスの実績グラフに入力として表示されるノードではないという意味で、入力とは異なる．むしろこれらは、プロセスの挙動をわずかに変更したり、その実行を表すプロセスノードに属性を設定することを可能にする入力である．以下のメタデータ入力は、すべてのプロセスクラスで利用可能．特にmpi並列数などの計算リソースの設定は，`metadata.options`に設定する．

```python
builder.metadata.options.resources = {'num_machines': 1}

options = {
    "resources": {
        "num_machines": 1,                 # run on 1 node
        "tot_num_mpiprocs": 1,             # use 1 process
        "num_mpiprocs_per_machine": 1,
    },
    "max_wallclock_seconds": 1 * 60 * 60,  # 1h walltime
    "max_memory_kb": 2000000,              # 2GB memory
    "queue_name": "molsim",                # slurm partition to use
    "withmpi": False,                      # we run in serial mode
}
```


### 計算を投げる

```bash
verdi run tutorial.py
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

# 特定のprocessについての結果をグラフ化する．
$ verdi node graph generate 125
```

計算終了後，stateが0になっていれば計算が成功していることを意味し，失敗していればそれ以外のstateになっているので原因を確認する．結果をより詳しく見る方法をいくつかリストアップする．

1. `verdi calcjob`コマンド

```bash
# コードのinputを取得
$ verdi calcjob inputcat 125
# コードのstdoutを取得
$ verdi calcjob outputcat 125
```

1. `verdi data`コマンド

```bash
verdi data core.dict show 13
```