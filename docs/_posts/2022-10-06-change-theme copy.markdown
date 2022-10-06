---
layout: post
title:  "管理者権限のないLinuxマシンにzshをインストールする"
date:   2022-10-06 21:00:00 +0900
categories: linux
tags:
 - linux
 - zsh
 - installation
---

## 管理者権限のある場合のシェルのインストール，変更方法

まず管理者権限がある場合のシェルのインストールは`apt`や`dnf`で普通にできる．管理者権限がない場合はマニュアルインストールするしかない．

シェルの変更方法だが，これは以下のコマンドを使えば容易に実行できる．

```shell-session
## 現在利用しているシェルの種類を表示
$ echo ${SHELL}
/bin/bash

## 利用できるシェルの一覧表示
$ cat /etc/shells
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/dash
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh

## シェルをzshに変更
$ chsh -s /bin/zsh
```

しかし，root権限がないばあい，`chsh`コマンドは実行できないので，`.bash_profile`に`zsh`と書いて強制的に`zsh`を起動させるしかない．したがって普通のサーバーだとLDAPなどでユーザーが自分の使うシェルを変更できるようになっている．しかし最近利用しているサーバーはこの機能がなく，自分で一からやる羽目になった．


## `zsh`のマニュアルインストール

zshを入れようとしたら

```bash
configure: error: "No terminal handling library was found on your system.
This is probably a library called 'curses' or 'ncurses'.  You may
need to install a package called 'curses-devel' or 'ncurses-devel' on your
system."
```

というエラーでconfigureが実行できなかった．出力にあるように`ncurses`をインストールすることで解決できた．`ncurses`は端末に依存しない形式でテキストユーザインタフェース (TUI) を作成するためのAPIを提供するライブラリ（by wikipedia）とのこと．[このページ](https://ftp.gnu.org/pub/gnu/ncurses/)から適当なバージョンを持ってくる．自分は`v5.7`でためして成功した．

適当なディレクトリにダウンロードしたら解凍して`cd ncurses-5.7`で中に入り，configureを実行する．`prefix`でインストール場所を指定しないと，デフォルトで`/usr/local`にインストールしようとするので注意が必要．また，`without-cxx-binding`オプションがないとエラーで落ちてしまった．これはc++に関するファイルを作成しないようにするもので，zshを使う限りにおいてはこのオプションをつけても問題なさそう．詳しいオプションについては`INSTALL`というファイルにかなり詳細に乗っているのでエラーが出たらまずはこのファイルをチェックするとよい．

```bash
./configure \
--prefix=$HOME/.local/ncurses \
--without-cxx-binding \
--with-shared \
--enable-widec
```

configureが成功して以下のように出力された．

```bash
** Configuration summary for NCURSES 5.7 20081102:

     extended funcs: yes
     xterm terminfo: xterm-new

      bin directory: ~/.local/ncurses/bin
      lib directory: ~/.local/ncurses/lib
  include directory: ~/.local/ncurses/include/ncursesw
      man directory: ~/.local/ncurses/man
 terminfo directory: ~/.local/ncurses/share/terminfo

** Include-directory is not in a standard location
```

最後にmake installを実行する．

```bash
$ make
$ make install
```

これで`ncurses`のインストールは完了したので，次に`zsh`のインストールを行う．今回は`v5.6.2`をダウンロードしてきた．ディレクトリに入って以下のconfigureコマンドを実行する．オプションについては[先駆者のページ](https://qiita.com/zettaittenani/items/5c3c8541766e676965ec)を参考にした．大切なのは`enable-cflags`などのところで，ここで`ncurses`をインストールした時にできたディレクトリを指定する．

```bash
./configure \
--prefix=$HOME/.local/zsh \
--enable-cflags="-I $HOME/.local/ncurses/include" \
--enable-cppflags="-I $HOME/.local/ncurses/include" \
--enable-ldflags="-L $HOME/.local/ncurses/lib" \
--enable-multibyte \
--enable-locale \
--with-tcsetpgrp
```

無事にconfigureが通ったら

```bash
$ make
$ make install
```

でインストールする．`zsh`は`${HOME}/.local/zsh/bin/zsh`にインストールされているので，`.bash_profile`に

```bash
${HOME}/.local/zsh/bin/zsh
```

と記述すれば，ログイン時に自動で`zsh`が起動するようにできる．

