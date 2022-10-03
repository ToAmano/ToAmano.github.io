---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: 自宅サーバーへのssh接続を行う
layout: single
description: The top-page of my personal website.
---

## 今日やること

サーバーのマシンにいちいちディスプレイやキーボードをつないで操作するのは面倒臭いので，まずは他のマシン（例えば自分のラップトップとか）からサーバーの操作ができるようにする必要がある．基本的にはssh接続して使うことになるが，そのために`ssh`をサーバーのマシンにインストールする必要がある．これが必須の設定だ．

また，これはオプションだが，何かと便利かもしれないのでリモートデスクトップの設定も行う．ssh接続する時のIPアドレスを固定できると不用意にIPアドレスが変わって困ることがないのでこれもやりたい．

- サーバーのマシンにssh接続できるようにする
- サーバーのマシンのリモートデスクトップを設定する
- サーバーのマシンのIPアドレスを固定する
- 公開鍵形式でサーバーにssh接続する

以上の設定ができればひとまずサーバーへの（ローカル環境での）接続を安定して行えるので一安心．

## サーバーのマシンにssh接続する

この段階まではディスプレイ，キーボード，マウスが必須．

### sshサーバーのインストール

まずは`openssh-server`をインストールする．

```bash
# パッケージマネージャを最新版にアップグレード
$ sudo apt update
# openssh-serverをインストール
$ sudo apt install openssh-server
# sshが動作しているか確認
$ sudo systemctl status ssh
```

基本的にはインストールすると自動で実行されるが，もし実行されていない場合は以下のように起動する．

```bash
# マシンの起動時に自動でsshを起動するようにする(やっとくと便利)
$ sudo systemctl enable ssh
# sshを起動する
$ sudo systemctl start ssh
```

### Firewallの解除

Firewallの設定はサーバー管理をやっているとよく泣かされる部分でもある．本当はちゃんと設定した方がよいのだが，とりあえずということでssh接続を許可する．

```bash
# firewallの状態を確認
$ sudo ufw status
inactive ← 基本的にはこんな感じで起動していないはず
# 起動していればfirewall(ufw)を許可
$ sudo ufw allow ssh
```

### マシンのipアドレスの確認

ssh接続する時にはマシンのローカルIPがわかってないといけない．これはipコマンドから確認できる．

```bash
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eno2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether 10:e7:c6:33:6b:4a brd ff:ff:ff:ff:ff:ff
    altname enp1s0
3: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 10:e7:c6:33:6b:49 brd ff:ff:ff:ff:ff:ff
    altname enp0s31f6
    inet 192.168.1.54/24 brd 192.168.1.255 scope global dynamic noprefixroute eno1
       valid_lft 9133sec preferred_lft 9133sec
    inet6 2400:4050:d442:1100:9ef4:26c0:a63f:
```

Loはloopbackネットワーク，eth0は有線LAN，wlan0は無線LANを表している．今回はeth0の有線LANの設定を利用する．

### 実際にmacからssh接続

```bash
(client)$ ssh user@192.168.1.54
```

## macからリモートデスクトップで接続

### ubuntuの設定

「設定」→「共有」→「画面共有」を変更．passwordを要求するにチェック．ネットワークのところをOnにする．

暗号化を解除．

```bash
gsettings set org.gnome.Vino require-encryption false
```

デフォルトではポート番号`5900`番で接続できる．念の為念の為ポートが開いているか確認する．

```bash
sudo lsof -i:5900
```

### Macから接続する

Finderで`cmd+k`を開いて，ipアドレスとポート番号を入れる．

```bash
vnc://192.168.1.54:5900
```

これでokをおすと接続できる．現状接続はできたが操作ができない状態．．．そのうち対応しよう．．．

## IPアドレスを固定する．

本当はルーターの機能でIPを固定する方が良いのかもしれない（？）が，とりあえずということでサーバーマシンからIPを固定する[^1]．調べてみても色々なやりかたがあるようでよくわからなかったので[公式ドキュメント](https://ubuntu.com/server/docs/network-configuration)をみてみると，Static IP Address Assignmentという項目のところで説明があった．

まず，`netplan`をインストールする．

```bash
sudo apt install netplan-dev
```

さらに，`/etc/netplan/99_config.yaml`ファイルを作成し，以下のような内容にする．この設定だと`eth0`に設定しているが，さらに他の線もつなぎたい場合はeth1以降のポートもつなぐ．

```bash
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: false
      dhcp6: false
      addresses: [192.168.1.54/24] ← ここに指定したいアドレスを入れる
      gateway4: 192.168.1.1 ← ルーターのアドレス
      nameservers:
        addresses: [192.168.1.1, 8.8.8.8, 8.8.4.4] 
```

設定したファイルを適用するには以下のようにする．IPアドレスを変える場合，リモートで操作していたら接続は切れるので要注意！

```bash
sudo netplan apply
```

## 公開鍵形式でサーバーにログインする

いちいちログイン時にパスワードを入れるのが面倒臭い（のと，セキュリティの問題もある）ので，公開鍵形式でログインするようにする．作業は全てローカルで行う．

```bash
$ cd ~/.ssh
$ ssh-keygen ←たとえばid_rsa_homeという名前で保存する．
$ ssh-copy-id -i ~/.ssh/id_rsa_home user@192.168.1.54
$ ssh -i ~/.ssh/id_rsa_home user@192.168.1.54 ← 接続できるかの確認
```
いちいち鍵ファイルの指定をするのが面倒臭いので`.ssh/config`ファイルに設定をする．

```bash
# home server
Host hoge
    Hostname 192.168.1.54
    IdentityFIle ~/.ssh/id_rsa_home
    User fuga
```

Hostのところはお好きな名前にする．せっかくなので自分の気にいる名前をサーバーにつけると良い．



## 参考文献
https://codechacha.com/ja/ubuntu-install-openssh/
https://qiita.com/forestsignal/items/e0876ffb19daec88aeba
https://qiita.com/routerman/items/4d19b3084fa58723830c
https://qiita.com/zen3/items/757f96cbe522a9ad397d
https://linuxfan.info/ubuntu-2004-server-static-ip-address

[^1]: そのうちルーターやスイッチも買い替えたいのでその時の移行を楽にするため．