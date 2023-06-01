

# awk

## ファイルの結合
https://deep.tacoskingdom.com/blog/80


#  
https://masa-cbl.hatenadiary.jp/entry/20121202/1354456802


## その他便利なコマンド

- ファイル数のカウント（find）
  ```
  # current directory以下
  find . -type f | wc -l
  # current directoryのみ（sub directory含まず）
  find . -type f -depth 1 | wc -l
  ```

- リンク切れシンボリックリンクの一括削除（find）
  ```
  find . -xtype l | xargs rm
  ```

- ファイル容量のチェック（du）
  ```
  # current directoryのみ
  du -h --max-depth=1 
  ```

- 
