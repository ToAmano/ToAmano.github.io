---
layout: default
title:  "zsh 出力に色をつける"
date:   2022-09-04 10:03:40 +0900
categories: bash zsh
---

コマンド出力に色をつけると見やすい．一般的なコマンドには色をつけるための手法やパッケージが用意されているのでそれをみていく．

## ls >> gnu ls

`ls`コマンドはmacのデフォルトだとbsd系のlsが入っていて，これは通常のlinuxに入っているgnu lsとは異なる．gnu lsの方がカラー設定がしやすいのでこっちをインストールする．以下はhomebrewから入れる例だ．インストールした後，色付けをデフォルトで有効にするために`.zshrc`にエイリアスを設定している．

```bash
# install via homebrew
brew install ls

# set alias to zshrc. .zshrcに以下を追記
gls -F --color=auto
```

具体的な色の設定ファイルを`$dircolorsPATH`という変数で設定できる．設定ファイルは色々なカラーテーマに沿ったものがネット上で手に入る．自分はターミナルのカラーテーマをsolarizedにしているので，[対応したもの](https://github.com/seebi/dircolors-solarized.git)を利用している．

## cat >> [ccat](https://github.com/owenthereal/ccat)

ccatはcatコマンドを色付けしてくれる．以下の`grc`ではcatが対応していないので別途これを利用している．

```bash
# install via homebrew
brew install ccat

# ccatへのaliasをはる．.zshrcに以下を追記
if [[ -x `which ccat` ]]; then
  alias cat='ccat'
fi
```

## [grc/grcat](https://fhiyo.github.io/2017/11/14/colorize-terminal-output.html)

grc/grcatは各種のコマンドに色をつけてくれるパッケージ．対応しているコマンドは以下の通り．

```
  as,ant,blkid,cc,configure,curl,cvs,df,diff,dig,dnf,docker,docker-compose
  docker-machine,du,env,fdisk,findmnt,free,g++,gas,gcc,getfacl,getsebool,gmake,id,ifconfig,iostat,ip,iptables,iwconfig,journalctl,kubectl,last,ldap,lolcat,ld,ls,lsattr,lsblk,lsmod,lsof,lspci,make,mount,mtr,mvn,netstat,nmap,ntpdate,php,ping,ping6,proftpd,ps,sar,semanage,sensors,showmount,sockstat,ss,stat,sysctl,systemctl,tcpdump,traceroute,traceroute6,tune2fs,ulimit,uptime,vmstat,wdiff,whois
```

基本的にはこれを使っていれば問題ないような気がする．homebrewからダウンロードでき，`grc コマンド`の形で実行することで色付けできる．

```bash
# install via homebrew
brew install grc

# test. in this case for ls 
grc ls 
```

いちいち色付けするのが面倒臭いという場合は自動でaliasを貼ってくれるスクリプトが用意されているので，このファイルを`.zshrc`で読みこめば良い．

```bash
# .zshrcに以下を追記
"[[ -s "/opt/homebrew/etc/grc.zsh" ]] && source /opt/homebrew/etc/grc.zsh
```

## less >> source-highlight

source-highlightはlessを色付けしてくれるツールとして有名．これもhomebrewからインストールできる．再び`.zshrc`に追記する．

```bash
# install via homebrew
brew install source-highlight

# .zshrcに以下を追記
export LESS="-R"
export LESSOPEN="| /opt/homebrew/bin/src-hilite-lesspipe.sh  %s"
```


## 色付け以上の機能を持ったls >> [exa](https://github.com/ogham/exa)

gnu lsでは満足できない（？）場合は，`exa`コマンドを使うという手がある．これはlsの色付けに加えて追加の機能をいくつか持っていて便利．

```bash
# install via homebrew
brew install exa
```

いくつか便利な利用法をリストアップしておく．

```bash
# 下部ディレクトリをツリー表示してくれる
exa -T 

# 表示カスタマイズ（アイコンを表示する例）
exa --icon

# ファイルのgit状態
exa -l --git

# 色々モリモリで表示（これが便利なので特別にllにaliasを設定した．）
exa -abghHliS --git
```


<!-- 
diff >> colordiff
-->

<!--
https://fhiyo.github.io/2017/11/14/colorize-terminal-output.html
-->

