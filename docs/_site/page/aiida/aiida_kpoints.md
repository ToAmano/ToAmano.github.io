# K点


https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/data_types.html?highlight=KpointsData#kpointsdata

## K点の自動サンプリング

## [K点のパス](https://aiida.readthedocs.io/projects/aiida-core/en/latest/reference/apidoc/aiida.tools.data.array.kpoints.html#aiida.tools.data.array.kpoints.main.get_kpoints_path)

AiiDAは結晶構造を入力すると自動でK点を計算してくれるmethodを持つ．`aiida.tools.data.array.kpoints.main.get_kpoints_path() `と`aiida.tools.data.array.kpoints.main.get_explicit_kpoints_path()`という二つの手法を利用することができる．

These methods are also conveniently exported directly as, e.g., aiida.tools.get_kpoints_path.

これらの二つの手法の入力は同じだが出力が異なる．違いは前者が特殊K点を辞書方式で返すのに対して((e.g. {'GAMMA': [0. ,0. ,0. ], 'X': [0.5, 0., 0.], 'L': [0.5, 0.5, 0.5]}, and then a list of tuples of endpoints of each segment, e.g. [('GAMMA', 'X'), ('X', 'L'), ('L', 'GAMMA')] for the  path.)，後者はpathに沿ったK点のリストを返す（[[0., 0., 0.], [0.05, 0., 0.], [0.1, 0., 0.], ...].）

入力としてはまずStructureData形式の結晶構造，そしてK点を取得する方法（これはデフォルトの`seekpath`のままで特に問題ないと思う．），最後に追加のパラメータである．追加のパラメータはseekpathのものと同様なので，細かく設定したい場合はseekpathのdocumentationを参照するべし．

実際に使ってみる．`get_kpoints_path() `はhuman readableなK点のリストを返すので人間の目にわかりやすい．`get_explicit_kpoints_path()`の方はKpointsData形式で返ってくるので出力をそのままbuilderに渡すことができる．もちろんどのようなpathを取っているか目で確認することも可能．

```python:get_explicit_kpoints_path.py
# 計算条件は構造だけを最適化構造から取得
first_calculation = orm.load_node(707)
structure=first_calculation.outputs.output_structure

# get KpointData
import aiida.tools.data.array.kpoints.seekpath 
test2=aiida.tools.data.array.kpoints.seekpath.get_explicit_kpoints_path(structure,{})
test2["explicit_kpoints"]

# どのようなpathを取っているか確認
print(test2["parameters"]["point_coords"])
print(test2["parameters"]["path"])
```


```python
# extract data in human readable form
test3=aiida.tools.data.array.kpoints.seekpath.get_kpoints_path(structure,{})["parameters"]
test3.dict.path
test3.dict.point_coords
```


参考
https://aiida.readthedocs.io/projects/aiida-core/en/latest/reference/apidoc/aiida.tools.data.array.kpoints.html?highlight=kpoints.seekpath#module-aiida.tools.data.array.kpoints.seekpath

https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/data_types.html?highlight=KpointsData#kpointsdata