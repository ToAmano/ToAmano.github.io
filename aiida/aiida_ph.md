# aiida ph,q2r,matdyn (phonon calculation)

ph  :: フォノンのDFPT計算
q2r :: Dynamical Matrix → IFCsのフーリエ変換
matdyn :: IFCs → Dynamical Matrixのフーリエ変換，Dynamical Matrixの対角化

注意 !! dynmat.xはなさそう.
注意 !! ドキュメントがあまり充実していないので何かおかしいと思ったらgithubのソースコードを確認した方が良い．

Todo :: pwのinput構造を入力としてバンドまで計算するworkflowを作成したい．

## q2r

注意!! q2rを使う場合は最初のpw計算でibrav=0としておかないと，IFCファイルのparseに失敗してしまう．

q2r計算のインプットとアウトプットは以下のようになっている．

- input
  - parameters :: q2r.xのinputパラメータ用の辞書
  - parent_folder :: 元となるph.x計算のディレクトリ．
- output
  - force_constants :: q2r.xの出力のIFCファイルをparseしたもの

<details><summary>実行用のAiiDAコードの例</summary>

```python
from aiida.orm import Code, StructureData
from aiida.plugins import DataFactory
from aiida import orm
from aiida.plugins import CalculationFactory
from aiida.engine import launch
from aiida.orm import load_group

# ===========   code(modify here)  ===============
codename = 'qe-6.6-q2r'
code = Code.get_from_string(codename)

# codeから，対応するbuilderを取得
builder = code.get_builder()

# ======= parent PH calc (modify here) ===========
parent_ID= 902 # ibrav=0
# ==============================

# inputs
parameters = Dict({
    "INPUT":{"zasr":"simple"},
                })

# builder
builder.parameters=orm.Dict(dict=parameters)
builder.parent_folder=load_node(parent_ID).outputs.remote_folder

# additional setting (necessary)
builder.metadata.options.resources = {'num_machines': 4, 'tot_num_mpiprocs':128}
builder.metadata.options.withmpi = True
builder.metadata.options.queue_name = "i8cpu"
builder.metadata.options.max_wallclock_seconds = 1*30*60

# # additional setting (optional)
builder.metadata.label = "q2r sample calculation "
builder.metadata.description = "q2r calculation for phonon bands from {}".format(load_node(parent_ID).pk)

builder.metadata.options.custom_scheduler_commands = '''
#SBATCH --mail-type=all        #available type:BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=example@gmail.com
'''
builder.metadata.options.prepend_text = '''
# output calculation settings
echo
echo    START DATE       : `date`
echo   SLURM_JOBID       : ${SLURM_JOBID}
echo SLURM_SUBMIT_DIR    : ${SLURM_SUBMIT_DIR}
echo SLURM_CPUS_PER_TASK : ${SLURM_CPUS_PER_TASK}
echo SLURM_JOB_NUM_NODES : ${SLURM_JOB_NUM_NODES} # num of nodes allocated to the job
echo   SLURM_NTASKS      : ${SLURM_NTASKS}
'''

# job submission to daemon
job=launch.submit(builder)

# after submission
print('launched WorkChain<{}> '.format(job.pk))
print("Use `verdi process list` or `verdi process show {}` to check the progress".format(job.pk))

```

</details>



## matdyn

注意!! ドキュメントだと`parent_folder`を指定することになっているが，どうもこれだと追加でparametersにfilfcを設定する必要がありそう．だったら最初から`force_constants`を設定しておいた方が早いと思う.

matdyn計算のインプットとアウトプットは以下のようになっている．

- input
  - parameters :: matdyn.xのinputパラメータ用の辞書
  - parent_folder :: 元となるq2r.x計算のディレクトリ．
- output
  - bands ::

matdynではバンド図用の計算（特定のK点に沿った計算）か，DOS用の計算（K点サンプリング計算）のどちらかを実行することができる．DOS用の計算は今まで通りにK点を指定してやれば良いが，バンド図用の計算の場合，Kpathを取得してやる必要がある．AiiDAではこのための方法が実装されている（[詳しくはこちら](aiida_kpoints.md）. いずれにしてもq2rの計算結果の力定数に加えて，結晶構造をpw計算から引っ張ってくる必要があるのでq2rよりも少し複雑である．

<details><summary>バンド用の計算コード</summary>

```python
###########################################################################
# GaAs bulk ph calculation

from aiida.orm import Code, StructureData
from aiida.plugins import DataFactory
from aiida import orm
from aiida.plugins import CalculationFactory
from aiida.engine import launch
from aiida.orm import load_group
import aiida.tools.data.array.kpoints.seekpath

# ===========   code  ===============
codename = 'qe-6.6-matdyn'
code = Code.get_from_string(codename)

# codeから，対応するbuilderを取得
builder = code.get_builder()

# ======= parent q2r calc ===========
parent_ID= 1008
# ===============================

# ======= parent qw calc ===========
pw_ID= 937
# ===============================

# inputs for band
parameters = Dict({
    "INPUT":{"asr":"simple",
             "dos": False,
             },
             })

# builder
builder.parameters=orm.Dict(dict=parameters)
builder.force_constants=load_node(parent_ID).outputs.force_constants 

# 構造を取得して対応するk点を取得
struc=load_node(pw_ID).inputs.structure
kpath_explicit=aiida.tools.data.array.kpoints.seekpath.get_explicit_kpoints_path(struc,{})
print(" ----------------- ")
print(" get explicit k-path ")
print(kpath_explicit["parameters"]["point_coords"])
print("")
print(kpath_explicit["parameters"]["path"])
print("")
builder.kpoints=kpath_explicit["explicit_kpoints"]

# additional setting (necessary)
builder.metadata.options.resources = {'num_machines': 4, 'tot_num_mpiprocs':128}
builder.metadata.options.withmpi = True
builder.metadata.options.queue_name = "i8cpu"
builder.metadata.options.max_wallclock_seconds = 1*30*60

# additional setting 1 (optional)
builder.metadata.label = "matdyn sample"
builder.metadata.description = "matdyn calculation from {}".format(load_node(parent_ID).pk)

builder.metadata.options.custom_scheduler_commands = '''
#SBATCH --mail-type=all        #available type:BEGIN, END, FAIL, REQUEUE, ALL
#SBATCH --mail-user=example@gmail.com
'''
builder.metadata.options.prepend_text = '''
# output calculation settings
echo
echo    START DATE       : `date`
echo   SLURM_JOBID       : ${SLURM_JOBID}
echo SLURM_SUBMIT_DIR    : ${SLURM_SUBMIT_DIR}
echo SLURM_CPUS_PER_TASK : ${SLURM_CPUS_PER_TASK}
echo SLURM_JOB_NUM_NODES : ${SLURM_JOB_NUM_NODES} # num of nodes allocated to the job
echo   SLURM_NTASKS      : ${SLURM_NTASKS}
'''

#builder.metadata.dry_run = True
#builder.metadata.store_provenance = False

# job submission to daemon
job=launch.submit(builder)

# after submission
print('launched WorkChain<{}> for structure {}'.format(job.pk, load_node(pw_ID).inputs.structure.get_formula()))
print("Use `verdi process list` or `verdi process show {}` to check the progress".format(job.pk))
```

</details>



## [バンドの可視化（BandsData）](https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/data_types.html?highlight=band%20structure%20#bandsdata)

Aiidaにはバンド図専用のデータタイプが用意されており，バンド図の可視化を始め色々な操作ができるようになっている．例えば簡単にバンドを描きたい場合は`verdi data`コマンドを使って一発でファイルを生成できる．

```bash
# 描画用のpythonファイルを生成(mpl_pdfなどで直接pdf化も可能)
verdi data core.bands export 1026 --format mpl_singlefile > make_plot.py
```

とは言え，実際には例えば実験データと一緒にプロットしたい，プロットの色を変えたいなど細かいカスタマイズをしたくなる．このような場合はpythonでnodeをロードした後いじっていくことになる．
