---
layout: single
permalink: /github/
title:  "git/githubの使い方"
date:   2022-09-04 10:03:40 +0900
categories: git 
tags:
- github 
---


## installation (option)

gitコマンドはMacの初期状態でも入っている．

```bash
$ which git 
/usr/bin/git
```

一応git自体をhomebrew経由でインストールし直す．

```bash
$ brew install git
$ which git # m1macの場合以下のようになれば成功．
/opt/homebrew/bin/git
```
<!-- https://dev.classmethod.jp/articles/vscode-git-graph-extension/ -->

gitコマンドには含まれていないコマンドをいくつかインストールする．

```bash
$ brew install git-gui #gitkなど
$ brew install hub     #
```


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




## github (リモート)との連携


```bash
# 接続の確認
$ ssh -T git@github.com
```

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

## gitでコミット済のファイルを消去後に復活させる
https://dbcls.rois.ac.jp/~yayamamo/fsyl/2014/06/git%E3%81%A7%E3%82%B3%E3%83%9F%E3%83%83%E3%83%88%E6%B8%88%E3%81%AE%E3%83%95%E3%82%A1%E3%82%A4%E3%83%AB%E3%82%92%E6%B6%88%E5%8E%BB%E5%BE%8C%E3%81%AB%E5%BE%A9%E6%B4%BB%E3%81%95%E3%81%9B%E3%82%8B/
```bash
git rev-list -n 1 HEAD --
```

## リモートのブランチAをローカルブランチBにpullする場合．
<!-- https://qiita.com/hinatades/items/d47dec72a87c5fed50f7 -->
```bash
git pull origin A:B
```
## ローカルブランチをリモートブランチAにpushする場合
```
git push origin A
```


## タグの使い方

```bash
# タグを打つ
git tag -a <tag-name> -m "comment"

# タグを消す
$ git tag -d <tag-name>

# タグをリモートへ送る
git push origin --tags
```

## リリースの使い方

タグを打ったコミットに対してリリースを作成できる．
https://semver.org/


## コミットメッセージ

<!-- https://qiita.com/itosho/items/9565c6ad2ffc24c09364 -->

## githubでの一人開発について
<!-- https://qiita.com/braveryk7/items/5208263cd06a8878f0c2-->
一人開発でもissueとpull-requestを活用することで進捗履歴を残すことができる．
1. issueを立てる．Labelを作成して割り当てておくとよい．
2. issueに対応するbranchをローカルに作成．branch名はissueの名前に対応しておくと良くて，例えば`features/hoge`のようにする．作業をしてpushまで行う．
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


## [A successful Git branching model](https://nvie.com/posts/a-successful-git-branching-model/)
<!-- https://qiita.com/homhom44/items/9f13c646fa2619ae63d0 -->
1. master
   公開用（リモートにも存在）
2. release
   リリース直前の細かい作業
3. hotfix
   公開後の急を要するbugfix
4. develop
   開発用（リモートにも存在）
5. feature
   開発用，1つ1つの機能はこちらで実装


## vscodeとの連携

1. ブランチをグラフで確認できる拡張機能`git graph`
1. コミット履歴を
1. 追加のさまざまなgit操作を可能にする`GitLens`

<!-- https://qiita.com/y-tsutsu/items/2ba96b16b220fb5913be -->


## 複数のgithubアカウントを使い分けたいとき
<!-- https://zenn.dev/taichifukumoto/articles/how-to-use-multiple-github-accounts
 -->

## github-pagesの使い方

[こちら](github_pages.md)

---
## latex文書の運用について

<!--
https://zenn.dev/ganariya/articles/platex-github-action
https://zenn.dev/serima/articles/4dac7baf0b9377b0b58b
https://zenn.dev/t4t5u0/articles/latexoperation

https://peterroelants.github.io/posts/adding-tags-to-github-pages/
-->

## その他

- commitメッセージのテンプレート
  
  適当なテンプレートファイル`commit_template`を作った上で
  
  ```
  git config --global commit.template /path/to/commit_template
  ```
  
  とする．`--global`は全てのレポジトリに一括で適用するので，個別のレポジトリに対してやりたければそのレポジトリのディレクトリで`--global`オプションなしで実行する．
