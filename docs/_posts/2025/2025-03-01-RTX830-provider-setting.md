---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: RTX 830 IPv6 IPoE プロバイダ設定
layout: single
date:   2025-3-1 21:00:00 +0900
categories: item
tags:
 - network
header:
  teaser: 
description: LaTeXにおける便利なパッケージを簡単にまとめる記事
---

家の回線をフレッツ光クロスにしたので，その時のルーターの設定を書いておく．一次ソースとしてYAMAHAが出しているドキュメントが充実しているのでその通りにやればよいのだが，慣れてないとわかりにくい部分もあるので自分の記録を兼ねて．


## 前提

今回は以下の構成でネットワークの設定を行った．

- ONU：10G-EPON ONU（NTT貸与品）
- ルーター：YAMAHA RTX830
- プロバイダ：かもめインターネット V6プラスXプラン

RTX830は1Gbpsにしか対応していないので追々RTX1300あたりに置き換えることを想定しているが，YAMAHAのページを見る限り設定方法は同じようだ．プロバイダについてはいろいろな制約から選定するのに苦労したので，そのへんの話も追って記事に残そうと思う．プロバイダの違いで設定が違うことはない（細かい接続設定はどちらかというとプランによる）ので，その点は安心してよい．

## 事前準備

事前にフレッツ光クロスの工事が完了してONUが設置されており，プロバイダから開通の連絡が来るまで待つ必要がある．

## 工場出荷状態へのリセット

前の設定が残っていてRTX830にログインできなくなってしまったので工場出荷状態にリセットした．前の設定が色々残ってて心配という場合もこれをやっておけば一から設定できる．

手順は簡単で全面のmicroSD + USB + DOWNLOAD の3つのボタンを押しながら電源をONにするだけ．POWERランプが数分間点滅し，その後点灯に変わればリセット完了．

## LAN経由でのGUIアクセス

工場出荷状態での本機のIPアドレスは`192.168.100.1` になっている．ブラウザでこのIPにアクセスし，ログインのポップアップが出てきたらアクセス成功だ．ユーザー名，パスワードには何も入れずにログインできる．（設定はログイン後に任意のタイミングで変更可能）

{% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/01_login.jpg" alt="ログイン画面" caption="" %}

**Notice:** IPアクセス時，ブラウザキャッシュが残っていて既存のルーターに飛ばされるということがあったので，その場合はキャッシュを削除するか，シークレットブラウザからアクセスすれば良い．
{: .notice}

**Notice:** ブラウザがsafariの場合，ユーザー名に「anonymous」を設定してログインする．パスワードは同じくなしで大丈夫．
{: .notice}

## プロバイダ設定

プロバイダ設定時には，自分が申し込んでいるプロバイダの以下の情報が必要．

- プロバイダ
    - 接続種別：これは今回は IPv6 IPoE接続の想定．
    - IPv4 over IPv6トンネル：かもめインターネットの場合は「v6プラス」という名前．
    - 固定IPサービスを利用している場合はその情報

- ログインしたら，ファームウェアのバージョンを確認する．プロバイダによってはバージョンいくつ以上じゃないと使えない，というような制限があったりするのでそこをチェックする．特にRTX830は古いので．．． かもめインターネットの場合は．今回はバージョンアップ不要だった．
    
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/02_dashboard.jpg" alt="ダッシュボード画面でバージョンを確認" caption="" %}

- タブの「簡単設定」をクリックし，ついでプロバイダー接続をクリックする．「新規」ボタンで新規作成する．
    
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/03_provider_setting.jpg" alt="設定完了後にスクショしたので，設定一覧にすでに存在している．" caption="" %}
    
    設定完了後にスクショしたので，設定一覧にすでに存在している．
    
- インターフェースの選択は，WANを選択し，「次へ」を押す．
    
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/04_select_interface.jpg" alt="" caption="" %}

- 回線自動判別で回線の判別が行われる．「PPPoE接続が利用可能です．」と表示されたら「次へ」を押す．今回はIPoE接続なのだがなぜかこのように表示され，接続もうまくいったのであまり気にしなくて良さそうだ．
    
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/05_line_selection.jpg" alt="" caption="" %}

- 接続種別の選択でIPv6 IPoE接続を選択肢，「次へ」を押す．
    
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/06_select_ipv6.jpg" alt="" caption="" %}

- プロバイダー情報の設定では，設定名は自分にわかりやすい名前を（なんでもよい）つける．**光電話の契約有無は，契約していなくても「契約している」に設定する．**IPv4 over IP6トンネルの設定は使用する→v6プラスを選択する．光電話の契約有無によって接続方式がかわる（IPv6 IPoE(DHCP)か IPv6 IPoE(RA)）らしく，IPv6 IPoE(DHCP)でないと接続できなかった．今回の設定ではここに詰まって時間を溶かした．．．
    
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/07_select_provider.jpg" alt="" caption="" %}

- トンネル設定は動的IPか固定IPかを選択する．追加オプションで固定IPを申し込んでいなければ基本動的IPのはずだ．今後固定IPも申し込む予定なので，そちらの設定はその時に追記する．
    
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/08_select_dynamicip.jpg" alt="" caption="" %}

- DNSサーバーの設定：ここはプロバイダによりそうなところではある．かもめインターネットは自動接続を推奨しており，自動接続設定にした．（スクショを取りそびれた．）
- IPフィルター：推奨のフィルターあり設定にしておいた．問題があれば後で変えれば良い．
    
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/09_select_ipfilter.jpg" alt="" caption="" %}

- 最後まで接続が完了すると，接続状態のところが緑色となり，無事接続完了した．
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/10_finish_setting.jpg" alt="" caption="" %}

    設定の全体像は詳細設定>プロバイダ接続>確認から確認できる．
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/11_setting_overview.jpg" alt="" caption="" %}

これでネットワークに無事接続できた．[みんなのネット回線速度](https://minsoku.net/)で速度を測ったところ，深夜で下りが800Mbps弱，上りが100Mbps程度だった．ルーターやケーブルを更新すればもう少し早くなりそうなので，新しいおもちゃを手に入れたと思って色々試してみようと思う．

IPv4/IPv6の接続状況はこういう[サポートページ](http://kiriwake.isp-support.jp/)があってv6プラスを利用できているか確認できる．無事v6プラスで接続していることも確認できた．

{% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/12_check_ipv6.jpg" alt="" caption="" %}

## その他の設定

その他追加で簡単な設定等についていくつか箇条書きしておく．

- ルーターのIPアドレス変更
    
    初期設定の`192.168.100.1` が気に入らない場合，簡単設定>基本設定>LANアドレスから変更できる．
    
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/13_set_lanaddress.jpg" alt="" caption="" %}

- ユーザー追加
    
    管理者ユーザー以外を追加したい場合やパスワードを変更したい場合，管理>アクセス管理>ユーザーの設定から設定できる．
    {% include figure popup=true image_path="/assets/posts/2025-03-01-RTX830-provider-setting/14_add_users.jpg" alt="" caption="" %}


- TELNET接続
    
    デフォルトではTELNET接続が利用可能である．ターミナルからtelnetとIPアドレスでアクセスする．パスワードを要求されるのでパスワードをタイプしてEnterを押すと無事ログインできる．特定のユーザー名でログインしたい場合，パスワードをタイプせずにEnterを押すと`Username` を打てる．
    
    ```bash
    $telnet 192.168.100.1
    Trying 192.168.100.1...
    Connected to 192.168.100.1.
    Escape character is '^]'.
    
    Password:
    ```
    
    ログインに成功するとファームウェアバージョンが出力される．これでコンソールから細かい設定ができるようになる．WebGUIではできない設定も多いので（ここはOpnSenseを使ってた身からすると不満），次回以降の記事ではこちらも利用することになりそう．
    
    ```bash
    RTX830 Rev.15.02.22 (Mon Dec 20 18:20:29 2021)
    Copyright (c) 1994-2021 Yamaha Corporation. All Rights Reserved.
    To display the software copyright statement, use 'show copyright' command.
    ```
    

## TODO

ネットワーク設定周りは備忘録としてちゃんと残しておきたいので，以下の記事を準備．

- プロバイダ選定
- ローカルネットワークの構築（DNS，DHCP設定）
- 自宅サーバーへの外部からのアクセス
- VPN構築

## 参考文献

- ヤマハの公式資料
  - [documents for Yamaha network products](https://www.rtpro.yamaha.co.jp/RT/docs/#ipoe_46)
  - [v6プラス対応機能](https://www.rtpro.yamaha.co.jp/RT/docs/v6plus/index.html)
  - [2.1.4 TELNET による設定](https://www.rtpro.yamaha.co.jp/RT/manual/rt-common/howtouse/console_telnet.html)
  - [https://www.rtpro.yamaha.co.jp/RT/manual/rtx830/Users.pdf](https://www.rtpro.yamaha.co.jp/RT/manual/rtx830/Users.pdf)

- 今回利用したかもめインターネットの公式資料
  - [【VNEサービス】「v6プラス」対応機種 | 株式会社JPIX](https://www.jpix.ad.jp/service/?p=3565)
  - [【VNEサービス】「v6プラス」固定IPサービス 機器設定例 | 株式会社JPIX](https://www.jpix.ad.jp/service/?p=3458)

- その他ネット記事
  - [■RTX830を機械的な操作で初期化する方法](https://paradigmshift.x0.to/2020/09/27/568/)
  - 