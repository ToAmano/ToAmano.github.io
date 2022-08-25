# pymatgen

<!-- https://ma.issp.u-tokyo.ac.jp/app-post/1128 -->


## 結晶構造からK-patjを得る．

```python
from pymatgen.io.vasp.inputs import Kpoints
from pymatgen.core import Structure
from pymatgen.symmetry.bandstructure import HighSymmKpath

struct = Structure.from_file("POSCAR")
kpath = HighSymmKpath(struct)
kpts = Kpoints.automatic_linemode(divisions=40,ibz=kpath)
kpts.write_file("KPOINTS_nsc")
```

この結果、AFLOWLIB規格に基づくk点ラインパス情報を持つファイルKPOINTS_nscが生成される．

## 電子のバンド図を作成する．

```python
from pymatgen.io.vasp.outputs import Vasprun
from pymatgen.electronic_structure.plotter import BSPlotter

vaspout = Vasprun("./vasprun.xml")
bandstr = vaspout.get_band_structure(line_mode=True)
plt = BSPlotter(bandstr).get_plot(ylim=[-12,10])
plt.savefig("band.pdf")
```

