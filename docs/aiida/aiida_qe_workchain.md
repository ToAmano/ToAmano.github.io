# QEでのworkchainについて

参考文献
[公式のworkchain](https://aiida-quantumespresso.readthedocs.io/en/latest/devel_guide/workchains.html)

## base workchainの動かし方

まずは基本となるbase workchainの動かし方についてみていく．とりあえず動かすためのコードを見てみよう．

```python
# -*- coding: utf-8 -*-
###########################################################################
# Si bulk phonon calculation
###########################################################################
from aiida.orm import Code, StructureData
from aiida.plugins import DataFactory
from aiida import orm
from aiida.plugins import CalculationFactory
from aiida.engine import launch
from aiida.orm import load_group
from ase.io import read # 構造を読み込む用
from aiida_quantumespresso.common.types import ElectronicType
import ase.io
from aiida.engine import submit


# * workflowをロード
PwBaseWorkChain = WorkflowFactory('quantumespresso.pw.base')
print("available protocols", PwBaseWorkChain.get_available_protocols())

# * codeの指定
codename = 'qe-7.0-pw@mypc'
code = Code.get_from_string(codename)

# * input structure
filename="../GaAs_mp-2534_conventional_standard.cif"
ase_structure=ase.io.read(filename, format="cif")
# // ase_structure=ase.io.read(filename, format="espresso-in")
structure = StructureData(ase=ase_structure)

# * kpoint
# The DataFactory is a useful and robust tool for loading data types based on their entry point, e.g. 'array.kpoints' in this case.
KpointsData = DataFactory('array.kpoints')
kpoints = KpointsData()
kpoints.set_kpoints_mesh([12, 12, 12])
# parameters  146   Dict

# * 全ての計算に共通の条件はoverrideを利用可能
# https://groups.google.com/g/aiidausers/c/QywalYIOK-M?pli=1
base_overrides = {
    'pw': {
        'metadata': {
            'options': {
                'resources': {
                    'num_machines': 1,
                    #'num_mpiprocs_per_machine': ,
                    #'num_cores_per_mpiproc': 24,
                    "tot_num_mpiprocs": 24,
                },
                'max_wallclock_seconds': 1*60*60,
                'withmpi': True,
                "queue_name": "quename", # que name
            }
        }
    }
}

overrides = base_overrides

# * builderの設定
builder = PwBaseWorkChain.get_builder_from_protocol(\
    code=code, \
    structure=structure, \
    kpoints=kpoints, \
    electronic_type=ElectronicType.INSULATOR, \
    protocol="precise",
    overrides=overrides
    )

# additiona builder setting
# https://aiida-tutorials.readthedocs.io/en/latest/pages/2019_MARVEL_Psik_MaX/sections/calculations.html
builder.metadata.label = "PW workflow test"
builder.metadata.description = "AiiDA workflow with Quantum ESPRESSO on Si"

# submisstion
workchain_node = submit(builder)

# after submission
print('launched WorkChain<{}> for structure {}'.format(workchain_node.pk, structure.get_formula()))
print("Use `verdi process list` or `verdi process show {}` to check the progress".format(workchain_node.pk))
```

初めに基本となるworkflowを`WorkflowFactory('quantumespresso.pw.base')`でロードしている．利用可能なworkflowの一覧はbashで

```bash
verdi plugin workflow list
```

から確認できる．このworkflowへインプットを渡すのに`get_builder_from_protocol()`関数を利用しているが，これはaiida-qeに実装されている関数でbuilderへ渡す入力（特に&SYSTEMなどのパラメータ）を半分自動で作成してくれるものだ．


## workflowの作り方