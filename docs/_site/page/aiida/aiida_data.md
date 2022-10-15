# データ(ノード）処理

## ノードの種類

- calcjobnode :: 計算の実行に対応するノード．
  verdi processやverdi calcjobコマンドで確認できる．

## ノード

- ノードを削除する．

    ```bash
    verdi node delete <id>
    ```

- ノードのグループ化
  ノードはそのままだと特に構造がなく，人間の目には分かりにくい．特に計算結果が増えてくると大変．
  
  ノードをグループにまとめることができる．

```bash
$ verdi group create a_group
Success: Group created with PK = 8 and name 'a_group'

$ verdi group relabel a_group my_group
Success: Label changed to my_group

$ verdi group add-nodes -G my_group 380 1273
Do you really want to add 2 nodes to Group<my_group>? [y/N]: y
```


- グループの階層化
  
```bash
verdi group path ls -l
```