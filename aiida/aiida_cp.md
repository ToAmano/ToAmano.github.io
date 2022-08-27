# AiiDA cp.x



## [Trajectory](https://aiida.readthedocs.io/projects/aiida-core/en/latest/reference/apidoc/aiida.orm.nodes.data.array.html?highlight=TrajectoryData#aiida.orm.nodes.data.array.trajectory.TrajectoryData)

pw.xの結晶構造緩和計算でもそうだったが，AiiDAではシミュレーション中に原子が動く様子を[TrajectoryData](https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/data_types.html?highlight=TrajectoryData#trajectorydata)として取得できる．これによって，コマンドラインから簡単な可視化ができると同時に，pythonコード中でより細かくデータを解析したい場合にも便利である．


- コマンドラインから構造を手っ取り早く可視化する．
  
    ```bash
    verdi data core.trajectory show <pk>
    ```

- xyzファイルからTrajectoryDataにインポート

    ```python
    from aiida.orm.nodes.data.array.trajectory import TrajectoryData
    t= TrajectoryData()
    # get sites and number of timesteps
    t.set_array('steps', arange(ntimesteps))
    t.set_array('symbols', array([site.kind for site in s.sites]))
    t.importfile('some-calc/AIIDA-PROJECT-pos-1.xyz', 'xyz_pos')
    ```

- 原子座標などの情報を抽出
  
    ```python
    # 原子座標
    t.get_positions()
    # 時間データ
    t.get_times()

    # 
    t.get_step_data(index)
    # ある時間ステップの構造をStructureDataとして取得(常にPBC=true)
    t.get_step_structure(index)
    # 
    t.get_structure(converter="ase")
    ```


## cp-wf 計算

AiiDAはcalculationとしてcpしか受け付けないようになっており，cp-wf計算はそのままではエラーで実行してくれないことになっている．しかし，このエラーはインプットファイルを作成するときにNAMELISTを自動生成するルーチンがうまく動かないというだけのことであり，その部分を回避すれば普通にジョブ投入は成功する．この点は[公式でも言及](https://aiida-quantumespresso.readthedocs.io/en/latest/user_guide/calculation_plugins/pw.html#pw-advanced-features)されており，自動生成されるNAMELISTを上書きしたいときはsettingsタグを使うようにと指摘されている．例えばcp-wf計算をしたい場合は，calculation=cp-wfとした上で，ビルダーにsettingsタグを追加する．

```python
 settings_dict = {
     'namelists': ['CONTROL', 'SYSTEM', 'ELECTRONS', 'IONS', 'CELL', 'WANNIER' ],
 }
 builder.settings = orm.Dict(settings_dict)
```

これで通常のcp-wf計算が実行できる．ただし現状では，おそらくwfcファイルをちゃんと扱ってくれないくれないのでここは手でやる必要がある．