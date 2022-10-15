# QEのバンド計算(workflow)


どのようなworkflowがインストールされているかは`verdi plugin`コマンドで確認できる．

```bash
$ verdi plugin list aiida.workflows
* quantumespresso.matdyn.base
* quantumespresso.pdos
* quantumespresso.ph.base
* quantumespresso.pw.bands
* quantumespresso.pw.base
* quantumespresso.pw.relax
* quantumespresso.q2r.base
```

今回はこの中から`quantumespresso.pw.bands`を試す．これは以下の4つの計算を自動で行なってくれるワークフローである．

1. vc-relaxによる結晶構造緩和
2. Refine the symmetry of the relaxed structure, and find a standardized cell using SeeK-path.
3. scf計算
4. nscf計算でSeeK-pathの定めたパスに沿ってバンド計算


## QE以外の計算条件(metadata.options)の設定

metadata.optionsはそれぞれの計算に対して指定する必要がある．しかし全ての計算にいちいち設定を書いているのは面倒くさいので，それを解決するために`override`というオプションがある．
<!-- https://groups.google.com/g/aiidausers/c/QywalYIOK-M?pli=1 -->

https://aiida-tutorials.readthedocs.io/en/tutorial-2021-intro/sections/running_processes/workflows.html


```bash
$ verdi process list
verdi process list                                    5:38:38 
  PK  Created    Process label     Process State    Process status
----  ---------  ----------------  ---------------  ----------------------------------
 169  21s ago    PwBandsWorkChain  ⏵ Waiting        Waiting for child processes: 171
 171  20s ago    PwRelaxWorkChain  ⏵ Waiting        Waiting for child processes: 174
 174  19s ago    PwBaseWorkChain   ⏵ Waiting        Waiting for child processes: 179
 179  18s ago    PwCalculation     ⏵ Waiting        Waiting for transport task: upload

Total results: 4
```

https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/howto/run_workflows.html