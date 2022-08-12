
# git/githubの使い方

## install(option)
gitコマンドはMacの初期状態でも入っている．
```bash
$ which git 
/usr/bin/git
```
追加で色々使いたいのでhomebrew経由でインストールし直す．
```bash
$ brew install git
$ brew install git-gui #gitkなど
```
<!-- https://dev.classmethod.jp/articles/vscode-git-graph-extension/ -->




## 初期設定(.gitconfigファイルの設定)

1. ユーザ設定
git config --global user.name "ユーザ名"
git config --global user.email "アドレス"



1. gitの出力をカラーリング(option)
```bash
 git config --global color.ui auto
```

1. 



## ローカルでのバージョン管理

バージョン管理したいディレクトリに移動する．
```bash
cd git_test
```

```bash
 git init
```
を実行すると，`.git`というディレクトリが生成されてバージョン管理が始まる．

実際にファイルを管理するためには
 a，git add ファイル名　でインデックス
 b，git commit -m "コミットメッセージ" でコミット
のに段階を踏む．

gtでは，ワークツリー（仕事しているディレクトリ）から直接リポジトリに状態を記録（これをコミットという）するのではなく，その間に設けられているインデックスの設定された状態を記録するようになっている．そのため，コミットでファイルの状態を記録するには，まずインデックスにファイルを登録する必要がある．




## github(リモート)との連携


## mergeの中止
mergeに成功した場合
```bash
# HEAD の移動履歴を表示して戻したいHEADの番号を知る
$ git reflog 
# 参照、作業ツリー、インデクスを強制的に戻す
$ git reset --hard HEAD@{1}
```
mergeに失敗した場合
```bash
git merge --abort
```

## ローカルのリモートブランチ（）を最新化
```git
git fetch
```

## リモートのブランチ一覧
```bash
#ローカルのブランチ一覧
git branch
#リモートのブランチ一覧
git branch -r
```

## リモートのブランチAをローカルブランチBにpullする場合．
<!-- https://qiita.com/hinatades/items/d47dec72a87c5fed50f7 -->
```bash
git pull origin A:B
```

## githubでの一人開発について
<!-- https://qiita.com/braveryk7/items/5208263cd06a8878f0c2-->
一人開発でもissueとpull-requestを活用することで進捗履歴を残すことができる．
1. issueを立てる．Labelを作成して割り当てておくとよい．
2. issueに対応するbranchを作成．branch名はissueの名前に対応しておくと良くて，例えば`features/hoge`のようにする．作業をしてpushまで行う．
3. pushしたブランチに合わせてpull-requestを作る．
4. mergeして，github上のbranchを削除．
5. ローカルにmergeして，ローカルのbranchを削除．
```bash
//GitHubのdevelopブランチをローカルのorigin/developに反映
$ git fetch origin develop

//origin/developをdevelopに反映
$ git merge origin/develop

//issue専用ブランチを削除
$ git branch -d issue
```
6. github上でissueを閉じる．


## vscodeとの連携

1. ブランチをグラフで確認できる拡張機能`git graph`
1. コミット履歴を