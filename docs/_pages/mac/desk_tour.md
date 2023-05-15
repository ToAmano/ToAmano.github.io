---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: デスクツアー
layout: home
description: デスクのセッティング
---


## デスクで使用している機材一覧

将来の更新や機材が壊れた時の参考に利用しているものをリスト化していく．


### PC

据え置き2台とラップトップ1台を利用．

<dl>
  <dt><strong>imac 2019（3.6 GHz 8コアIntel Core i9+Radeon Pro Vega 48 8 GB）</strong></dt>
  <dd>imac2014から2020年に買い替えた．メインマシン．cpuはそこそこ高性能で，大規模な並列化が必要ないシミュレーションならこのマシンでも回せる．一方でGPUの性能は値段の割にあまり褒められたものではないと思うが，私自身は映像編集などはあまりやらないので問題ない．外部ディスプレイへの出力に限って言えば，2枚（5K+4K）つないでも動作にはあまり問題ない．ただひとつ気になるのは本体が結構熱くなることで，GPUもCPUも常に60度以上あって困っている．</dd>
  <dt><strong>自作マシン（intel xeon）</strong></dt>
  <dd>Linux fedra，主にファイルサーバーや計算機サーバーの勉強用．</dd>
  <dt><strong>macbook pro 14インチ 2021（Apple M1 Max 10コアCPU/32コアGPU，64GB unified memory）</strong></dt>
  <dd>外出用のノートPC．4Kモニター+WQHDモニターに繋いでも全然発熱しないのでM1 maxチップの省電力性はすごいなと．あと，結構普通のシミュレーションを回してもintel機と遜色ない早さなのもお気に入りポイント．</dd>
</dl>


### ディスプレイまわり

27インチ3枚の3ディスプレイ構成で，配置は右にimac，中央がstudio display，左がEizo．imacのディスプレイは写真を見るには綺麗だがダークモードが増えた今となっては反射がきついのが難点．nano-texture glass仕様のstudio displayは本当に反射が少なくて綺麗だが，入力が1つだけだったりwindows/Linuxでは使いにくかったりする．扱いやすさではEizoが一番だが，4Kと5Kの違いは並べてみると分かってしまう．どれも一長一短という感じがしている．もしimacを使っていなければEizo3枚で揃えるのが良いのではないかと思う．

<dl>
  <dt>apple studio display nano-texture glass</dt>
  <dd>メインディスプレイ．インターフェースは最悪で，特に入力が1系統しかないためPCの切り替えなどができないというとんでもない仕様になっている．ただ5K+nano-textureの画質は素晴らしいので泣く泣く購入した．．． nano-textureは反射がかなり少ないので，ダークモードでターミナルやIDEをいじるのには最適．逆に白背景のブラウジングとかがメインならわざわざnano-textureでなくて良いかも．</dd>
  <dt>Eizo EV2740X</dt>
  <dd>画面の綺麗さと反射の少なさはstudio displayが上回っている印象だがポートの豊富さが強み．先代からディスプレイが変わっていて，おそらくLGの27UQ850やDELLのU2723Qと同じものを使っている．</dd>
</dl>

全てのディスプレイはエルゴトロンのLX（モニターアーム）で設置．デスクが広くなるので使えるならモニターアーム推奨．特にimacを買う人はVESA仕様にしておいた方が良いと思う．私はVESA仕様にできるのを知らずにスタンド仕様で買って後で後悔した．反省を活かしてstudio displayはVESA仕様で購入した．

ディスプレイの接続に関してはimacもstudio displayもあまりポートが多くないのでちょっと困る．

- imac：thunderbolt3ポートが2つとUSB-Aが4つ．
- studio display：入力用のthunderbolt3が1つのみ，USB-Cポートが追加で3つついている
- Eizo EV2740X：

imac用にthunderbolt3のドッキングステーション（CalDigitのTS3）も使いたいので，imac-TS3-studio displayで一つ，imac-EV2740Xで一つとしてimacのthunderbolt3を使い切っている．ここら辺のインターフェースはappleにはもうちょっとなんとかして欲しい．．．


### その他小物

- キーボードとマウス
  - HHKB professional HYBRID：購入当時複数台接続先を切り替えられる静電式のものがこれしかなかった記憶．ものは普通に良い．
  - Logitech G604：MX master2がぶっ壊れたのでこちらを購入．MX masterより使いやすい印象だがソフトウェア（GHUB）がかなり不安定．小技（？）だがbluetoothレシーバーをTS3の前面ポートにつけると余計な配線がなくなって良い．
- USBドックなど
  - caldigit TS3：メインのドック．ディスプレイやSSDへの接続など．付属ケーブルが短すぎるのが難点．あと結構熱を持つのでファンで冷却すると動作が安定する気がする．
  - Anker USB 3.0 高速4ポートハブ：imacのUSB-Aポートが少ないので渋々購入．
  - Sony MRW-G2：CFexpress TypeA/SDカードリーダー
  - Sony MRW-G1/T1 ：CFexpress TypeB/XQDカードリーダー
- アクティブスピーカー：Tannoy Reveal 402：3ディスプレイ環境だと設置場所に難儀するが，音はstudio displayやimacより良いので使い続けている．
- DAC/ヘッドホンアンプ：ADI-2 DAC FS/Phonitor X（完全に趣味）
- Pioneer：apple純正のは音飛びが酷かったのだが，こちらに変えてから快適に．
- マイク：Blue Yeti nano：正直そこまで良い音とは思わないがこれ以上の値段も出したくない，というジレンマ．
- デスク時計：キングジム LT10：気に入っているプログラムアラームだが生産完了に，アプリもいつまで使えることだか．．． スマート系の商品はこれが怖いので本当は長く商品を出しているところのものを買った方が良いだろう．
- サンワ USB type-C スタンド 400-HUB088GMN：スマホ/タブレットスタンド
- SSDケース：logitech LHR-4BNHUC：USB type-C対応でSSD4台まで．付属のケーブルが短すぎるので追加でケーブルを買った意外は満足．
- デスクライト
  - BenQ screen bar plus：ディスプレイの上部に設置するというアイデアは素晴らしい．ただ光量は少し少ない気がする．あとケーブルが短すぎ．新しいのはリモコン部が無線になっているらしいのでそちらの方が良さそう．あと，マルチディスプレイ環境で使う場合は普通に隣のディスプレイに光が映り込むので注意が必要．
  - Philips Hue ライトバー：Hueシリーズは高いけどアプリでの調光に秀でていておすすめ．
  - switchbot ceiling light pro：デスクとは関係ないが部屋のライトにswitchbotを導入して調光可能にした．12畳用を購入したがかなり明るくてよい．値段が結構安いので耐久性がどうかは心配．
- ケーブル類
  ケーブル類はディスプレイなど性能が必要なものと，充電用などそこまで性能が要らないものに分けて買い揃えると無駄な出費がなくて済む．耐久性はかなり大事でナイロンケーブルやシリコンケーブルで揃えた方が後々困らないと思う．
  - Belkin thunderbolt 4 1m
  - Anker 高耐久ナイロン USB-C & USB-C 0.9m：USB2だが3本1200円で破格の耐久性なので充電用によい
  - Anker PowerLine III Flow USB-C & USB-C ケーブル 1.8m：シリコンケーブルで取り回しと耐久性が良い
  - Anker PowerLine+ USB-C & USB-A 3.0 ケーブル 1.8m：PowerLine+はナイロン製で耐久性が高くて良い．
  - Anker PowerLine USB-C & USB-A 3.0ケーブル ： 3本セットで安かったけど硬すぎて使いにくい．
  - Anker PowerLine II Dura ライトニング USB ケーブル 0.9m：ライトニング側がダメになった．
  - Anker PowerLine+ II ライトニングUSBケーブル 0.9m：編み込みケーブルで頑丈．
  - FiiO FIO-LD-TC1 [USB Type-C to USB Type-B データ伝送ケーブル 0.5m]
  - エレコム USB3-CMB05NBK [USB3.1ケーブル Gen2 C-microBタイプ 認証品 3A出力 0.5m ブラック]
- 充電器など
  - Anker PowerPort III 2-Port 100W：apple純正の96W充電器より小さい上に2portついている優れもの．2台買ってしまった．
  - Anker PowerPort I PD - 1 PD & 4 PowerIQ
  - Anker 60W 7+3ポート USBハブ PowerIQ搭載：ポート数が多いのはよかったが2年くらいで壊れてしまった．

- 電源タップ
  - エレコム ECT-0720BK：タワー型の電源タップだけど，あまり使いやすくはなかった．
  - サンワサプライ TAP-SP307 [雷ガードタップ 3P 8個口プラグ 2.5m]
  - エレコム T-E5C-2610WH [個別スイッチ付 省エネタップ 横挿しタイプ 6個口 1m ホワイト]
  - エレコム T-Y3CA-2720WH [OAタップ/2P/7個口/マグネット/抜け止め/スイッチ/2m]
  - ヤザワ YZBKS662B [個別スイッチ付節電タップ 6個口 2m 黒]
  
- オーム電機 PC-SC01-K [ノートパソコンクーラー 2ファン 角度調整6段階 静音25dB ]
- プラス WP-110N DGY：普通のペンスタンド
- エレコム マウスパッドhigh，リストレスト30cm：両方ともゲルのパッド．ここら辺はどういうものがよいか人によって好みが別れそう．耐久性に関して，先代も多分同じマウスパッドを使っていて10年目で壊れたので再購入したくらいの持ち具合．

- タブレット
  - ipad pro ：出先で使うにはちょっと大きくて，ほぼ家でサブモニターとして使うだけになってしまった．勿体無い．．．
  - ipad mini 6世代 ：読書とか論文読んだりとかに最適なサイズ感．6世代からapple pensil2に対応したので購入．




https://dirac6582.github.io/

