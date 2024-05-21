---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: LinuxサーバーにおけるIPアドレスの確認方法
layout: single
date:   2024-5-5 21:00:00 +0900
header:
  teaser: 
description: Linuxサーバーで問題発生時に重要なIPアドレスの確認方法について
---

サーバーを管理していてネットワーク周りの問題が発生した場合には初期的なチェックとしてIPアドレスの確認を行うことがある．今回はIPの確認に使えるコマンドをいくつかピックアップした．


## 基本的情報

マシンのIPアドレスは，基本的にインターフェースごとに割り当てられる．通常はLANポートやwifi
に加えて，BMC用のアドレスや自分自身を表すLO (loop back)アドレスがある．

## 環境

今回はLinux想定で，LinuxならばあまりOSは問わないはず．

```bash
$ uname a
Linux **** 5.19.15-201.fc36.x86_64 #1 SMP PREEMPT_DYNAMIC Thu Oct 13 18:58:38 UTC 2022 x86_64 x86_64 x86_64 GNU/Linux
```


## ip

`ip`はおそらくIPの確認で最もよく用いるコマンドで，`arp`や`ifconfig`より新しいものである. これら二つのコマンドで実行できることは大体`ip`でもできる. `ip a`でIPまわりの情報を一覧表示できる．例えば以下の例では，1がループバック，2と3がLANポートを表し，LANポートのうち`eno1`のみIPアドレス`10.0.5.251/24`が設定されている．`eno`はEtherNetのOnboardという意味．

```bash
# addressを表すaでインターフェースの情報を表示
$ ip a
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host
       valid_lft forever preferred_lft forever
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether ac:1f:6b:c5:9d:be brd ff:ff:ff:ff:ff:ff
    altname enp25s0f0
    inet 10.0.5.251/24 brd 10.0.5.255 scope global dynamic noprefixroute eno1
       valid_lft 6737sec preferred_lft 6737sec
    inet6 fe80::ae1f:6bff:fec5:9dbe/64 scope link noprefixroute
       valid_lft forever preferred_lft forever
3: eno2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN group default qlen 1000
    link/ether ac:1f:6b:c5:9d:bf brd ff:ff:ff:ff:ff:ff
    altname enp25s0f1
```

表示内容は若干ことなるが，`ifconfig`でもほぼ同様の内容を得られる．上の例で用いたマシンでの`ifconfig`の出力は以下のようになる．

```bash
eno1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 10.0.5.251  netmask 255.255.255.0  broadcast 10.0.5.255
        inet6 fe80::ae1f:6bff:fec5:9dbe  prefixlen 64  scopeid 0x20<link>
        ether ac:1f:6b:c5:9d:be  txqueuelen 1000  (Ethernet)
        RX packets 13023730233  bytes 18999547709803 (17.2 TiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 3215766696  bytes 1789407610057 (1.6 TiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eno2: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether ac:1f:6b:c5:9d:bf  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 286435  bytes 257584247 (245.6 MiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 286435  bytes 257584247 (245.6 MiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```

`ip`コマンドは他にもIP表示に使えるオプションがいくつかあるのでここで合わせて紹介する．

```bash
# カーネルのルートエントリを全て表示する．
$ ip route
default via 10.0.5.1 dev eno1 proto dhcp src 10.0.5.251 metric 100
10.0.5.0/24 dev eno1 proto kernel scope link src 10.0.5.251 metric 100

# 全てのネットワークインターフェースの状態表示．
$ ip link
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN mode DEFAULT group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
2: eno1: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP mode DEFAULT group default qlen 1000
    link/ether ac:1f:6b:c5:9d:be brd ff:ff:ff:ff:ff:ff
    altname enp25s0f0
3: eno2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state DOWN mode DEFAULT group default qlen 1000
    link/ether ac:1f:6b:c5:9d:bf brd ff:ff:ff:ff:ff:ff
    altname enp25s0f1
```


## nmcli

ネットワークデバイスの設定をするのに欠かせない`nmcli`コマンドでもIPアドレスを表示できる．

```bash
# ネットワークデバイスの情報を表示
$ nmcli device show
GENERAL.DEVICE:                         eno1
GENERAL.TYPE:                           ethernet
GENERAL.HWADDR:                         AC:1F:6B:C5:9D:BE
GENERAL.MTU:                            1500
GENERAL.STATE:                          100 (connected)
GENERAL.CONNECTION:                     eno1
GENERAL.CON-PATH:                       /org/freedesktop/NetworkManager/ActiveConnection/1
WIRED-PROPERTIES.CARRIER:               on
IP4.ADDRESS[1]:                         10.0.5.251/24
IP4.GATEWAY:                            10.0.5.1
IP4.ROUTE[1]:                           dst = 10.0.5.0/24, nh = 0.0.0.0, mt = 100
IP4.ROUTE[2]:                           dst = 0.0.0.0/0, nh = 10.0.5.1, mt = 100
IP4.DNS[1]:                             10.0.1.1
IP4.DOMAIN[1]:                          arda
IP6.ADDRESS[1]:                         fe80::ae1f:6bff:fec5:9dbe/64
IP6.GATEWAY:                            --
IP6.ROUTE[1]:                           dst = fe80::/64, nh = ::, mt = 1024

GENERAL.DEVICE:                         eno2
GENERAL.TYPE:                           ethernet
GENERAL.HWADDR:                         AC:1F:6B:C5:9D:BF
GENERAL.MTU:                            1500
GENERAL.STATE:                          20 (unavailable)
GENERAL.CONNECTION:                     --
GENERAL.CON-PATH:                       --
WIRED-PROPERTIES.CARRIER:               off
IP4.GATEWAY:                            --
IP6.GATEWAY:                            --

GENERAL.DEVICE:                         lo
GENERAL.TYPE:                           loopback
GENERAL.HWADDR:                         00:00:00:00:00:00
GENERAL.MTU:                            65536
GENERAL.STATE:                          10 (unmanaged)
GENERAL.CONNECTION:                     --
GENERAL.CON-PATH:                       --
IP4.ADDRESS[1]:                         127.0.0.1/8
IP4.GATEWAY:                            --
IP6.ADDRESS[1]:                         ::1/128
IP6.GATEWAY:                            --
IP6.ROUTE[1]:                           dst = ::1/128, nh = ::, mt = 256
```



## hostname

`hostname`コマンドは自身のホスト名を確認できるコマンドだが，`-I`オプションでIPアドレスを確認できる．`ip`で事足りるので通常あまり使うことはないと思う．

```bash
$ hostname -I
```

{% comment %}

https://blog.future.ad.jp/linux-ipアドレスの確認方法をまとめてみた
https://tech.mktime.com/entry/211


{% endcomment %}