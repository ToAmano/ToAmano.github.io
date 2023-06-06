---
layout: single
title:  "誤ってgitに登録してしまった巨大ファイル（100M以上）を削除する"
date:   2023-6-6 21:00:00 +0900
categories: git
---



---

gitレポジトリに誤って100M以上の大きなファイルを登録してしまい，削除するのに四苦八苦したので対策を．

状況としてはgit 

まず，そのファイルが本当に必要ならばgit LFS（large file strage）を使うことで問題は


gitでリポジトリが大きくなってきた場合に，レポジトリ内の特定のディレクトリだけを別のレポジトリに分割したくなったので試してみた．この時にちゃんとgitの履歴を残したいので，単純にファイルだけコピーするのではなくて，ちゃんとgitの機能を使ってやりたい．

似たようなことを実現する手法はいくつかあって，たとえば`sparsecheckout`を使ってリモートレポジトリの一部のみをローカルに持ってくる方法もある．これは自分が管理していないレポジトリを扱う場合に便利そうだ．今回は自身で管理しているレポジトリを完全に別のレポジトリに分割したかったので，`git filter-branch`コマンドをつかって条件に合致したファイルやディレクトリだけを抽出した．`git filter-branch`は巨大ファイルなどの変なファイルを誤ってgitに登録してしまった場合にも使えて便利だということを最近知った．

手順としては，まず対象のレポジトリをcloneしておいて，cloneしたレポジトリ内で`git filter-branch`で分割したいディレクトリだけを残す．最後にこれをgithub上の新しいレポジトリに登録すれば完了である．


## 具体的手順

状況としてリモートレポジトリAの中にディレクトリaからcがある以下のような場合を考える．

```
https://github.com/hogehoge/repositoryA
├── README.md
├── directory_a
├── directory_b
├── directory_c
```

このうち，`directory_a`のみを残した新しいレポジトリBを作成する場合を考える．ブランチとしてはdevelopブランチを想定しているが，違う場合は`git filter-branch`のブランチ名のところを変えれば問題ない．

下準備として，githubの上で新しい空レポジトリ"repositoryB"を作成しておく．

```bash
# repositoryAのclone
git clone repositoryA
cd repositoryA

# 目的のブランチがある場合はcheckoutする
git checkout -b "local_branch" "origin/remote_branch"

# directory_a以外のファイルと履歴を削除（2つ目の変数でbranchを指定）
git filter-branch --prune-empty --subdirectory-filter "./directory_a" "develop"

# リモートリポジトリを変更（変数でrepositoryBのurlを指定）
# !! 注意 !! これをやらずにpushしちゃうと元のレポジトリAが変更されてしまう．
git remote set-url origin "git@github.com:/github.com/hogehoge/repositoryB"

# githubのrepositoryBにpush
git push origin develop
```

これでgithub上で新しく`directory_a`のみを保持した`repositoryB`の作成に成功した．途中の`filter-branch`のオプションについてだが

- --subdirectory-filter <directory>
           指定したディレクトリのgit履歴だけを抽出する．最終的には選んだsubdirectoryがルートディレクトリになる．
- --prune-empty
           空のコミットをなかったことにするもの．
           
という意味で，filterのオプションは他にも色々あるので目的によって使い分けるのが良い．


## その他

この方法の問題点として，ブランチが複数ある場合にちょっと面倒臭いという点が挙げられる．`filter-branch`でまとめて複数のブランチに処理をするのはできないのか？

また，もしも元となるレポジトリで分割したレポジトリへの依存関係などを明確に扱いたい場合は，`git submodule`を使う方法があるらしい．まだそこまでは必要ないかなと考えているがそのうち必要になったらまた簡単な記事をかきたい．


