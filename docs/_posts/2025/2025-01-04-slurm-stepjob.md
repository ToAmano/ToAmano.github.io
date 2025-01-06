---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: slurmにおけるstep jobの実行方法
layout: single
date:   2025-1-4 21:00:00 +0900
header:
  teaser:
description: SlurmのステップジョブはジョブAの完了をトリガーにジョブBを実行する方法で，sbatch -d singletonオプションを使用して実現する．これにより依存関係を持つジョブを効率的に管理できる． 
---

SlurmのステップジョブはジョブAの完了をトリガーにジョブBを実行する方法で，sbatch -d singletonオプションを使用して実現する．これにより依存関係を持つジョブを効率的に管理できる．

## slurmにおけるstep job

そもそもジョブスケジューラーにおける逐次実行（ステップジョブ）とは，一つのジョブが終わったのをトリガーに他のジョブを実行することをさす．例えばjobAとjobBを投入した時，通常はjobAもBもシステムに空きがあれば勝手に実行されてしまうが，ステップジョブの場合には両者を同時に投入していてもjobBはjobAが終わった後に実行するように指示する．こうするとjobBではjobAの結果を利用できる．これを人の手でやる場合はjobAが終わったのを確認してからjobBを投入する必要があるが，ジョブの数が増えてきたりするとステップジョブで全てのジョブを同時に投入できる方が良い．ステップジョブはさまざまな場面で活用できる．1週間かかる計算をジョブの制限時間が1日のシステムで実行する場合は，元のジョブを7個に分割してステップ実行する．他にも，多段階からなる計算で計算ごとにノード数を変更したい場合にもステップジョブが活用できる．

ジョブスケジューラーごとにステップジョブの方法は色々だが，今日はslurmにおけるステップジョブについて．結論からいうと，sbatchコマンドの`-d singleton`オプションを利用する．このオプションは，ユーザー名とジョブ名が同一の複数のジョブを逐次実行する．手順としては以下のようになる．

- ジョブ名が同一の複数のジョブスクリプトを用意する．ここではjob1.sh, job2.sh, job3.shの3つとする．
- 最初のジョブは通常通り`sbatch job1.sh`として投入する．
- 二つ目以降のジョブは`-d singleton`オプションをつけて投入する．
    - `sbatch -d singleton job2.sh`
    - `sbatch -d singleton job3.sh`

## サンプル

---

ここでは以下のようなスクリプトで記述されるjobAとjobBを考える．jobAでファイルを作成し，jobBでそれを読み込んで出力する単純なもの．パーティション名は各自の環境のものに変更する．大事なのは前述の通り，`job-name` を同じにすること．ここでは`JOBNAME` で固定した．

```bash
#!/bin/bash
#SBATCH --job-name="JOBNAME" # ここを同じにする
#SBATCH --no-requeue
#SBATCH --get-user-env
#SBATCH -o JobOutput_%x_%j.out # Name of stdout output file (%j expands to jobId)
#SBATCH --partition=HOGE
#SBATCH -N 1

sleep 40
cat <<- EOF > ./test_singleton.txt
 This is the sample document for singleton example.
EOF
```

```bash
#!/bin/bash
#SBATCH --job-name="JOBNAME" # ここを同じにする
#SBATCH --no-requeue
#SBATCH --get-user-env
#SBATCH -o JobOutput_%x_%j.out # Name of stdout output file (%j expands to jobId)
#SBATCH --partition=HOGE
#SBATCH -N 1

sleep 40
cat test_singleton.txt
```

投入時にはjobBの方に`-d singleton` オプションをつける．

```bash
sbatch jobA.sh
sbatch -d singleton jobB.sh
```

`squeue` 上ではステップジョブになったジョブには(Dependency)の表示がされる．ここでは，jobidがxxxxxx7 のものがjobAに対応し，xxxxxx8 のものがjobBに対応している．

```bash
$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
           xxxxxx8     i8cpu  JOBNAME  xxxxxxx PD       0:00      1 (Dependency)
           xxxxxx7     i8cpu  JOBNAME  xxxxxxx PD       0:00      1 c15u11n[2-2]
```

さらに詳細な情報は`scontrol show jobid` で確認できるが，jobBの詳細を見てみるとこちらでも`singleton` によってジョブの投入待ちになっていることがわかる．

```bash
$ scontrol show job <jobid>
 JobState=PENDING Reason=Dependency Dependency=singleton(unfulfilled)
```

## まとめ

---

slurmにおいてステップジョブを実行するオプション`-d singleton` の紹介をした．job-nameを同一にすることにだけ注意すれば簡単に実行できるので是非試されたい．

## 参考

---

[Slurmで簡単なステップ実行（逐次実行） - Qiita](https://qiita.com/pochman/items/923ca294a844cefbf1a7)

[Slurm Workload Manager - sbatch](https://slurm.schedmd.com/sbatch.html)
