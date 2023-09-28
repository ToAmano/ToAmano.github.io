---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: デスクのセッティング
layout: single
date:   2023-6-12 21:00:00 +0900
description: 最近トリプルディスプレイの環境になったので，デスクのセッティングを試行錯誤した記録．
gallery:
  - image_path: https://lh3.googleusercontent.com/pw/AIL4fc8LCkY3_1bDVjBNxZEccJEwVb7pAtuXRTFUHDvCOqg3G9WS_uXOzadjFc9_zBBLjumjy1pqptW4Y6Lo7KLKVxG1geziQoqyGViLmHalDX05xShHmFQ
    alt: "placeholder image 1"
    title: "Image 1 title caption"
  - image_path: https://lh3.googleusercontent.com/pw/AIL4fc-BB79l9yBJD6GwOzW0F4k-mE1jRF4FBdpeX-oSndQ0Ic_RgLYqlQ1MFMeEQDgoFTrykIENYrGzj33UdmD_NZi3bhbR8K1HCSj2XFNV98tHObxGhX8
    alt: "placeholder image 2"
    title: "Image 2 title caption"
---

最近Eizoから新しくでたディスプレイEV 2740Xを購入し，自宅のデスクがトリプルディスプレイ環境になった．こうなると自宅の方が作業が捗るということで，世間と逆行して引きこもり傾向が強まっている．この流れで最近デスク環境の整備を行ったので，一旦今までのところをまとめておくことにした．モニターが三枚あるとスペースがかなりカツカツになるので色々と試行錯誤が必要だったのでその辺を記録しておきたい．

{% include figure image_path="https://lh3.googleusercontent.com/pw/AJFCJaXgkl50-MTL7FfiR5CZHnAxZJJbl78sbiRiO4a16II02BHm4sQ4PcAfS8ZsKsJfvSvXHGwc8vv5P9cjH2sukbe9fTu5CBtjb9cTQEypM86jZdtU14A" alt="this is a placeholder image" caption="" %}


## パソコン

親の影響で昔からmac osを使っていて，メインは基本的にimacをずっと使っている．windowsを使いたいタイミングもあるのでbootcampでwindows領域を確保している．一方でそれだけだと不便なので別にLinux機をサブPC兼ファイルサーバーとして利用中．mac osを使い続ける限りはPCを複数運用することから逃れられない気がする．．．

### メインPC：imac 2019

{% include figure image_path="https://lh3.googleusercontent.com/pw/AJFCJaXwEzOVSQnwJr8_XWzasTkkuMlYbPOw0HXIIqXORz2eJ7h1YMAJ-g-urcAhco-yYy7rrUcnHJK3zl3kC9wDDL9GjgzF0gXzpLmv86tkFWfRWZxDtBA" alt="this is a placeholder image" caption="" %}

据え置きパソコンは2台運用しており，メインマシンはimac 2019．構成は3.6 GHz 8コアIntel Core i9+Radeon Pro Vega 48 8 GBというもので，2020年コロナが始まったタイミングでそれまで使っていたimac 2014から買い替えた．結局27インチのimacやintel系のmac自体2020年で終わってしまったのでこのタイミングで買い替えたのは正解だった．cpuパワーについては満足しており，計算サーバーを使わなくてもできる小規模の計算についてはimacにやらせることも多い．

一方でGPUの性能については少し不満があり，ディスプレイの出力が5K+4Kに対応しておらず4K+4Kになってしまう．Studio displayには普通に5Kで出せていたので，追加でEizoのモニタを買うまで気づかなかった．この点はimac 2020ならAMD Radeon Pro 5700との組み合わせで6K+6Kまでいけたようなのでもう少し待っていればというのはあるが結果論だ．

また，ちょっと気になるのは本体が熱くなることでGPUもCPUも常に60度以上になってしまう．仕方ないのでサーキュレーターで常時冷却して50-60度くらいで安定させている．ここらへんは新しいapple siliconチップ搭載機の方が全然良い．

## ディスプレイ

ディスプレイはimacの他にAppleのStudio displayとEizoのEV2740Xによる27インチ3枚構成であり，Studio Displayを中央に配置してメインディスプレイとしている．右にimac，左にEizoを配置していて，Eizoにはnotionやthings，メーラーなど常駐していると便利なアプリを表示させ，Studio displayでターミナルかIDEの作業，右のimacはサブディスプレイとしてIDEやブラウジング，pdfを読んだりするのに利用している．

### メインディスプレイ：Apple Studio display

{% include figure image_path="https://lh3.googleusercontent.com/QmsQt3AIky8sBXS9l8_fm28y6lqvzvG9zNFEl4wYKKlTDZ7NIdz4oTVhQmVyo7BZ8dRcOwvF_68AkP6rf6XGD2ABc2wqakL39k-voeX3zh7PR-JNEakYJ2yJR4EVQp_vKUbEyKI3Og" alt="this is a placeholder image" caption="" %}

27インチのApple純正ディスプレイ．値段が高いので買うか迷ったが店頭で見て購入することにした．購入時のオプションはnano-textureガラスとVESAマウント仕様で，特にnano-textureガラスの反射の少なさは素晴らしい．ターミナルやIDEをダークモードで使っていることもありimacに代わりメインディスプレイとして利用している．

欠点は端子の数が少なすぎることで，特に入力を一つしか受けつけないので他のPCと切り替えができないのは大きな不満点だ．現状他のPCを使うときは左のEIZOにつなぐことにして凌いでいる．


### サブディスプレイ： EIZO EV2740X

{% include figure image_path="https://lh3.googleusercontent.com/pw/AJFCJaXgHvU07g_PC0ngWBu4Z7qoDNvdudWK6Y7zc9LIBz4sGm1Qka5wZprCqC6kksZGVNv-5rXb-mYNswg44wDusSaN-obSUu2fUsOs_3ZVN6dMLz7-9ec" alt="this is a placeholder image" caption="" %}

3枚目のモニターとしてEizoの新しい4K27インチディスプレイを向かって左側に配置．Studio Displayをもう一台買うことも考えたが，mac以外のOSで動くか怪しいところがあり，Linux/Windows機をいじることがあるのでEIZOにした．前モデルからパネルが変わっていて，直接比較したがこちらの方がより綺麗なので買うならこちらが良い．ベゼルの薄さも特筆すべき点で，並べるとstudio displayは野暮ったく見える．またUSBポートが豊富についており，デイジーチェーンにも対応しているとのことなのでこれで揃えてしまうのもありだと思う．自作のLinux機はHDMIで，imacからはUSB-Cで繋いで切り替えて利用できるようにしている．

一方で5Kに比べると精細感が落ちるし，画面の反射の少なさもnano-textureガラスの方が上回っている印象だ．またStudio displayとの相性かわからないが一度接続を切るとimacを再起動しない限りディスプレイを認識してくれないという問題があって困っている．


### サブディスプレイ：ipad pro 11インチ

{% include figure image_path="https://lh3.googleusercontent.com/JQwUG9T_9lMaVOkOdR5sJQE4ozUvP9Y3x7cZN62nfng7QHmFaE9xLTy49_Mfl3ubB_JYnB3R47LdgARyFiKmkyvDoDLMcLQtKa_11J21BvnnmdTzrfP4435K-h1jCx7TAhIoRhyr6w" alt="this is a placeholder image" caption="" %}

デスクではipad proも愛用している．最近のmac osだとsidercarという機能でipadを拡張ディスプレイ，ミラーリングとして利用するかまたはキーボードマイスのリンク（ユニバーサルコントロール）が可能だ．拡張ディスプレイだと私の環境だと動作がカク付くこともあったのでキーボードマウスのリンクをしている．特に純正カレンダーアプリはipadだと予定のリスト表示が可能になっていて，mac osだとできないのでカレンダー画面を常駐させている．必要な時にはいつでもipadとして利用できるので一台あると何かと便利だ．

ユニバーサルコントロールの不満点として，どうも有線だと使えないことが挙げられる．私の環境だと拡張ディスプレイは有線でも使えるがユニバーサルコントロールは不可能で，この機能を使うためだけにmacのwifiをオンにしないといけない．mac osはventuraからネットワークの優先順位を自分で決めることができない（多分）ので，変なところでwifiが優先されると困る．

ちなみに外に持ち出すのはipad miniの方で，第六世代でapple pencil2に対応したのを機に導入して使っている．ipad miniは8.3インチで持ち出すならこれくらいのサイズがちょうどよいと思う．



### モニターアーム：エルゴトロンLX


imacと2枚のディスプレイはそれぞれエルゴトロンLXで設置している．モニターアームを使うと想像以上にデスクのスペースが空いてくれる．幅160cmしかないデスクで27インチモニターを3枚設置するのは普通のモニタースタンドでは（不可能ではないが）厳しかった．

imacはスタンド仕様のものだが，amazonで販売されているアダプタ（VIVO Adapter VESA Mount Kitというやつ）を介して無理やりLXで吊っている．ただしimacは10kg近くあってエルゴトロンLXの耐荷重11.3kgは少々心許なかった．実際LXのネジをかなり固くしてようやく安定してくれるかなという感じで，揺れも相対的に大きい．できればより耐荷重の大きいモニターアームを使うことをおすすめしたい．

{% include figure image_path="https://lh3.googleusercontent.com/G_-jRs0auDIIkzPM8S7Eiu_Q8NhRh33J3Lno85omA3pIOqbMp6VxmY2PpCtkqyjAyx-bnKkP6J-w3RKqHWlgCkb9E-OPN9nQO5YnbRzMBUYbJlXbWtoCeHgdvUk6GOgcBwg9vb2PBA
" alt="this is a placeholder image" caption="imac用のアダプターはすごくしっかりしているのでおすすめ" %}

エルゴトロンに限らないが，デスクを保護したい場合にはモニターアーム用のプレートを使うのが良い．荷重もより分散してかかるために安定性も上がっているはずだ．

{% include gallery caption="This is a sample gallery with **Markdown support**." %}

また，私のように頻繁にデスクをいじりたい人にはエルゴトロン純正のクイックリリースブラケットも良い．これを使うとモニターアームとモニターアームを簡単に取り外しできるようになる．3000円とちょっと値段ははるがその価値はある．

{% include figure image_path="https://lh3.googleusercontent.com/pw/AIL4fc_CkT9Wpog1BjOLO0igcV7fF-xirAYL78VWJsHtHyvPvNoOXqM5n8B_rZhldhRNwRaabtvQZfU1fuf8R8i9EZXD1qOp0N4xGvYkxrN43-N9C6bUmgs" alt="this is a placeholder image" caption="右側をディスプレイ側に，左側をモニターアーム側につけて利用する" %}

## USB・SSDなど機能拡張

{% include figure image_path="https://lh3.googleusercontent.com/32ZkzoWenCpbPWZXvZkliviRFxYwjraKQlnvrys_qnmILoEWXpfQfuPh3If14xGDhCb0t0R7CvTXozDVH5bUlqFv_wO4JFMQoL5OqOfly21DIIKowpjvdPOzE8LPq_kBJojVQ8gY_g=w2400" alt="this is a placeholder image" caption="imac背面" %}

imacのポートはthunderbolt3が二つとUSB-Aが四つだけでこのままでは少なすぎるためドックやハブで拡張している．Eizoの2740Xにはかなり多くのポートがついているので，今後こちらも活用していきたいとは考えている．

### thunderboltドック：Caldigit TS3 plus

メインで利用しているthunderbolt3ドック．thunderbolt3出力があるのでここからeizoディスプレイに繋いでいる他，前面まで含めてUSB-Aポートが5つ，USB-Cポートが2つあって周辺機器の接続に使っている．これが机の上にあると配線が大変なのでデスク裏に固定している．大したことはないが多少は熱を持つので一応注意しないといけない．



### USB-Aハブ：Anker USB 3.0 高速4ポートハブ

{% include figure image_path="https://lh3.googleusercontent.com/AOK-1TFnzmy6KeTiyk4ddtQCYOcKBL6FiYbRGbBKm92mkZFMr9qXHs9q5lGZ94TVSNfxcjpmo6k-F8fmV6VY32Az4xU4cBTKA65Taypc0J5oIbdN8uW38K9Q_-eez9CWTSGoRR-iqQ=w2400
" alt="this is a placeholder image" caption="" %}

USBメモリなどを頻繁に使うのでUSB-Aポートを増やす必要があった．さらにimacのポートは全て背面にあるので，USBメモリなど頻繁に抜き差しするものとは相性が悪い．このAnkerの4ポートハブはずいぶん前に購入して以来使っていて，値段もずいぶん安かったのでもう十分もとはとった気がする．ケーブルが取り外しできず，しかも硬いので取り回しがよくないのが難点で，そのうち良い商品を見つけたら買い換えたい．

### CFexpressカードリーダー：Sony MRW-G2，Sony MRW-G1/T1

{% include figure image_path="https://lh3.googleusercontent.com/AK43cH20qjztg4uXkv0FbWslvuAJDLAB4SzuXkDVsTcqfme6Ze9ihN74d17CcD4J6R9-nAfo3Z3tsNBKEwpBi_zFgNv9j7Y6ZG_M1ggXyNXSYn0GjtxXFhSuvO7CM7B0LhGY2Nbd9w=w2400" alt="this is a placeholder image" caption="左がTypeA用，右がTypeB用．カードを入れると左のようにLEDが点灯する．" %}

カメラのデータ転送にCFexpress-TypeAとTypeBカードリーダーが必要なので利用している．MRW-G2がtypeA/SDカードリーダー，MRW-G1/T1がtypeB/XQDカードリーダーになっている．typeA用の方が少し値段が高いが，これはtypeA用は金属製なのにたいしてtypeB用はプラスチック製だからだと思う．両方とも競合にくらべてお高いが機能的には素晴らしい．CFexpressカードは転送時にかなり発熱するので，ちゃんとしたメーカーのものを買うとよいだろう．地味に接続時にLEDランプが点灯するのが便利で，繋がっているか目視ですぐ確認できてトラブルシューティングに役立っている．付属のケーブルは30cmとかなり短く，かつ硬いので取り回しには注意が必要だ．

### SSDケース：logitech  LGB-4BNHUC USB3.1(Gen2)対応4bayHDDケース

{% include figure image_path="https://lh3.googleusercontent.com/isxYioKjA8H_UMGSEtWmROmNhwPeim5qY9QO0vozDL0O6b2zLhjjtJKjIm33DlcNu9YoSRVctxFoPaPojp3v66S92pBM-or1ICAYJlMTTI_j9hWxWkLY4hvL4Clol0ymwEJjLjP1fQ=w2400" caption="" %}

音楽や写真などは外部SSDに保存するため，ケースとしてHDD/SSDを4台まで接続できるlogitechのHDDケースを利用している．USB-Cで繋げるのと2.5インチSSDをマウントできるアダプターが入っていてSSDでも問題なく使えるということで選択した．接続時はLEDインジケーターがひかるようになっているのも便利．かれこれ3年使っているが今の所トラブルもなく満足しているが，唯一不満なのは電源ケーブルと付属USB-Cケーブルの長さが少し短いところ．結局付属USB-Cはより長いものを買い足して利用している．

### ポータブルSSD：Samsung 970 EVO Plus 2TB（MZ-V7S2T0B/EC） + 玄人志向 M.2 NVMe SSD ケース（GWM.2NVST-U3G2CCA）

{% include figure image_path="https://lh3.googleusercontent.com/-hW7ufe5piYvc-qDrz7oQQLXtjjB4hfXPdfsB2Vm5Rrz02xwtIv4K5Hb7JfOGS6WwU00Whx-Au5uQUN7ReteDJsZZkJ2XJjb6epIfelQa2OuXXyvystXP_Z9GFZBsbB6gAAKfbEuNw" alt="this is a placeholder image" caption="" %}

据え置きのSSDとは別に，外出用のポータブルSSDも利用している．ポータブルSSDは完成品もたくさん売っていてそれでも問題ないが，安く済ませたかったのでケースとSSDをそれぞれ別で購入した．用途的に高速転送がしたかったのでM.2 SSDを選択している．品質はさすがSamsungで文句なし．一方ケースの方はamazonなんかで調べると大量にヒットするのでどれでも良いだろう．私は用途上実績のあるものが使いたかったので玄人志向のものを利用している．これは放熱のことを考えて作られているようで，熱伝導シートが付属してきた．実際に使っていて今まで問題もなくタフに使いたい場合におすすめだ．

{% include figure image_path="https://lh3.googleusercontent.com/CApGd_PzIkHDVSj4K9MM8Me3JINKHSacIH0P9jmy8PABp3zSTpP-9COOuQ1JRshBcQMpfE0iLI8xprUDN7OtUzcF7yhj7TLbghpNP0SmgO0Yi1yQPGlmugrDX9xrX0u9B0bY5Hkytg=w2400" alt="this is a placeholder image" caption="付属のサーマルシートをSSDにはったところ．このシートがSSDケースと密着する設計になっている．" %}

### USBメモリ：Sandisk dual drive Go USB Type-C

{% include figure image_path="https://lh3.googleusercontent.com/pw/AIL4fc9pTeAtnNaoOYCUpUigHxjLyKZj_kkWO26jjmS_Ae8aszuWnNNiCYir-9C6CDqFP-6BqCoqYO-Yht4AKtTG5Kq0dxrC-kWaRQrKh3EAghI8hUjN9JA" alt="this is a placeholder image" caption="" %}

簡単なデータのやり取りには依然としてUSBメモリが便利で活用しています．USB-CとUSB-Aが混在する昨今の環境では，このサンディスクのメモリのようにUSB-CとUSB-Aの両方が入っているものが便利です．特にmac book proはUSB-C端子しかないのでこの手のメモリでないと使えません．欠点は小さいためか他のUSBメモリと比べて発熱がすごいことです（笑．

## キーボードとマウス

{% include figure image_path="https://lh3.googleusercontent.com/VMKXgYoJLf23NYTkOjhDCd9jaHJGNekhHPJioAeX_SMXfM_voWFzfI3YO1u_wUYRZym_eOosYVc4ytzjV5NUYWA45oXqWjUDe7WRm0gsUEiosmZDHgeCp26M0ssfjPq_pUo5F-ZH8Q=w2400" alt="this is a placeholder image" caption="" %}

### キーボード：HHKB professional HYBRID

{% include figure image_path="https://lh3.googleusercontent.com/oQnBWiQASuWl7AMWTFU5jpKLU0RN28xZzafuVlQsRTmWca6K5JkNf_xTS7WChoC3IctxptDwPAvVfs4Ju9_SlLtSHMB57aS9qAguCtKkJ4n3r7VjCJqUfU1MNXIq02K5S1JyFYj_oQ=w2400" alt="this is a placeholder image" caption="" %}

キーボードは愛用者も多いだろうHHKBを使っている．購入時にRealforceとどっちにするか迷ったが，購入当時複数台接続先を切り替えられる静電式のものはこれだけだったのが決め手で購入．以前は普通のメカニカルキーボードを利用していて，変えてからチャタリングもないし打鍵感も良いしでこれはアップグレードする価値があったと思っている．機能面でいうとmacでもキーマップの変更ができる．emacsを使っているのでESCキーを左下に割り当てているがすこぶる便利でこれだけのために買ってもよかったと思っているくらい．接続先はUSBで繋がっているものの他にbluetoothで最大3台まで繋げるので，最大4台までいける計算だ．ただし，機材の相性もあるかもしれないがBTの接続より有線の方が安定感が高いので基本的に有線で利用している．購入したEIZOモニターがKVMスイッチに対応しているのでBTをつかう必要性もなくなった．

### マウス：Logitech G604

{% include figure image_path="https://lh3.googleusercontent.com/eOyANhY8xXVIMR_pFdmyTfUsGv_n_Z-dISUsGmiQngzelxjQYQMgoRF29G6WDT_XNMmB35JxbYSq9TC0XVb8RUBWIS6nHCb7416xA2vsagVskd13t1XetgNXIkozX15oWCHhdc116g=w2400" alt="this is a placeholder image" caption="" %}

マウスは先代のMX master2が壊れたのを機に購入．ゲーミング用のマウスだけあって親指部のボタンが6つあり，それを全てGHUBという専用ソフトウェアでカスタマイズできるので自由度が高い．のだが2023/6現在なぜかimacのGHUBが起動しなくなってしまい困っている．．． mac book proの方では動いているので何かの設定がおかしいのだろうが原因究明できずにいる．仕方ないのでmac book proの方でオンボードメモリにプロファイルを設定してimacの方でも利用できるようにしてある．このようにGHUBは結構不安定なアプリで，気づくと起動しなくなっていたりということが多い．windows版はもう少しマシなのかもしれないが，macで使おうとしている人は要注意．GHUBに限らずMx master系のアプリLogi optionsも不安定だったことも付言しておきたい．詳細な設定についてはまたどこかで記事にするつもりだ．

耐久性についてだが，3年使って表面ラバーがだいぶヘタってきてしまってあと1-2年で買い替えないとダメそう．表面にラバーを使っていると触り心地は良いが耐久性はよくないということがよく勉強になった．一方で今のところチャタリングなどの現象は皆無で快適に利用できている．Mx master系は3回買っていずれも長く持たずにチャタリングや接触不良で買い替えることになってイメージが良くなかったが，今回のG604でロジクール製マウスに対する印象が少し変わった．

### マウスパッド/リストレスト：エレコム マウスパッドhigh，リストレスト30cm

{% include figure image_path="https://lh3.googleusercontent.com/2-eCinm1P-2YgZ5X0SZawJ7bs_pe1-cZECBbjS07KuK0t4_N_rpX0ygE7fSbsbA732E6cSJ1Njicfmwl75_By26Uvv2REm_ssJuoLJmDNoxSsvfMJhi3X-Zluny09DS3aIvnUYfmJw=w2400" alt="this is a placeholder image" caption="" %}


両方ともゲルのパッドになっていて，親が使っていたマウスパッドを貰って以来気に入って使っている．マウスパッドに関しては譲ってもらって10年で壊れたので同じものを再度購入して使っている．接着部がへたってなかからゲルが出てきてしまうので永久的に使えるわけではないのには注意が必要だ．


## 照明

自宅ではデスクを壁に対して設置していて，どうしても暗くなりがちだった．それにより以前からモニターと周囲の輝度差による目の疲れに悩まされていた．対策としてモニター裏やデスク裏にバックライトを配置するとかなり快適になった．ものは全ていわゆるスマート照明で構成して，スマホやalexaからの操作に対応させている．特にGPSと連動して外出すると消灯，帰宅すると点灯するのが便利で，電気代が高いこの頃多少は節電になっているかも．

### Philips Hue ライトバー

{% include figure image_path="https://lh3.googleusercontent.com/f7PJDxJpERRleLu4mNnz-BJSXaihe5VamU9VAe94xZ98l7_pEBWSY32TYt_R37t7MwnfaSuZNPGLxmsSifB9DIBuhCbWnzezR5gplKJLx4b93BWvc6tGKF42ROmx0zRD-wzlORNZUA=w2400" alt="this is a placeholder image" caption="" %}

最初に導入したHueの照明で，そろそろ3年目になる．ひとつ500lmの明るさがあり，直置きや縦置き，両面テープなど複数の設置方法に対応しているのが魅力だ．一方でケーブルを外せないのがちょっとした困りごとで，私の使い方だともう少しケーブル長が長い方がよかった．またアダプタにバーライトを3本まで接続できるのだが，このアダプタがかなり大きいので電源タップによっては他の口を塞いでしまうだろう．

{% include figure image_path="https://lh3.googleusercontent.com/-ulM69JBqJYgP7w6gS1KHMgfdPRX3Liu_p-jc9H90mt0twdsXuJQe4jVkIhHT5RgECa2xLZsKjlAEgTnrs89Tc1F5v4e0nr6t6GSAGWtJLUvgBJ5EaJYXk1qSJQ9ka9LiFYSXjSsQQ=w2400" alt="this is a placeholder image" caption="二種類の設置用アイテムが同梱される" %}

なお，本品に限らずPhilips Hueシリーズをスマホから操作するにはHue ブリッジと呼ばれる製品が必要なので注意．値段は競合に比べて高いが一度購入してしまえば公称100台まで繋げるため，照明の一元管理が可能になる．philipsは企業として大きいのでhueシリーズの寿命は長いだろうから，hueで揃えて良いかなと感じている．スマート系の製品は販売中止になるとそのうちアプリの対応も中止になってしまうので極力長く続くだろう製品で揃えることを強くお勧めしたい（自戒を込めて．．．）．

### Philips Hue 100W相当 E26 フルカラー

{% include figure image_path="https://lh3.googleusercontent.com/pw/AIL4fc86XkfodJhsw8nS_FZaHoZkfX1s2I_Bu1aKFkBuxTuuOElZbggn2tFZg5wGSkr5_S3-453mV5pGI7Zpn33_zNHd05J9h9g8kNCxuPFV58V0WIkSRHE=w2400" alt="this is a placeholder image" caption="75W相当よりは少し大きく出来ているらしい" %}

おなじくHueのE26口金用の電球タイプ照明で，出力に関して100W相当と75W相当（以前は60W相当だった）が，色に関してフルカラー，ホワイトグラデーション，ホワイトとある．私が利用しているのはフルカラー100W相当タイプで最大光量が1600lmあってかなり明るい．75W相当タイプとあまり値段が変わらないのでこちらを購入した．明るいだけあって発熱も凄まじく，100%で使ってると触れない点に注意が必要．

{% include figure image_path="https://lh3.googleusercontent.com/CjM9auyUTEexrvAV7cMNgxVFiWq9TWddZuKjUQtHL8sNHkxRaXfdCwZjrA3SrXZLuz17L5x8rbmyprUq6ZzYqdMc_MryXkToAxeaTj2T2l2oE2cLbgyRJBFJmjGzOs5-P1IjDY3oSw=w2400" alt="this is a placeholder image" caption="E26に対応した機器が別途必要" %}

もともと家にあった適当なクリップ式口金につけて壁に当てて間接照明にしている．値段と明るさを考えると他のhue製品に比べてコストパフォーマンスが高いので，設置方法さえ考えられればおすすめだ．

### デスクライト：BenQ screen bar plus

{% include figure image_path="https://lh3.googleusercontent.com/Wk5oFZ3TFbrqxCK8gu_Eh23DMQmJwSRLdoiMKKCKuFzF1RDE6z_NqU66ERw1-LbAFuEgcDwHOswUVL5FkqAfBCBmShOmAIPwiZz13QMo6Au44Bi7nKaD5orQ-1xhFWs7TTyLkDvEhA=w2400" alt="this is a placeholder image" caption="" %}

モニターの上に置いて設置するユニークなデスクライト．普通のデスクライトは結構場所をとるのでこのアイデアは素晴らしいものの，光量はさすがに少なめ．ケーブルが短くて取り回しが悪いのが最大の不満点で，新しいのはリモコン部が無線になっていてケーブルマネジメントの観点からはそちらの方が良さそう．あと，マルチディスプレイ環境で使う場合はディスプレイの角度によっては隣のディスプレイに光が映り込む．studio displayに設置して使っているが，これだとstudio displayのカメラを塞いでしまうところにも注意が必要だ．

運用としてはswitchbotのスマートプラグにつけて，他の照明と一括でつけたり消したりできるようにしている．私のように消し忘れが多い人にはこの運用はおすすめだ．


### シーリングライト：Switchbot ceiling light pro

デスクとは関係ないが，philips hueの調光がとても便利だったので部屋のライトも調光可能にした．明るさが6畳用，8畳用，12畳用とあって最大の12畳用を購入した．これは最大光量だとかなり明るいのでおすすめだ．panasonicなどの国産シーリングライトと比べると値段が結構安いので耐久性は心配な点で，今後使いながら確かめていこうと考えている．


## オーディオ

ピアノが趣味で色々な音源を聴くためにUSB-DAC,アンプなどをデスクに設置している．場所をとるのが難点だがPCオーディオで気軽に楽しめるので音楽が好きな人にはよいかも．いい加減appleには純正アプリのflac対応してもらいたいが望み薄だろうか．．．

### スピーカー：Tannoy Reveal 402

{% include figure image_path="https://lh3.googleusercontent.com/FNyY6wdggyH8cTY3D7aVjA0P8xF9SYFe3hxBrQ48k1R7Y2TnkvFxeIP27sb925MMHBDSjnB5lsouKmtzWFrI8P7IJ3zxfsHmxBknVE9yRlXml1LLcHmnb0wh5GwB9Evz4IyaKP0oUQ=w2400" alt="this is a placeholder image" caption="" %}

トリプルディスプレイ環境だと設置場所に難儀するが，音はstudio displayやimacより良いので使い続けている．入力として3.5mm，RCA，XLRの三種類が使えて自由度が高いのもポイント．サイズはH240xW147xD212で，デスクに置くにはこれくらいが限界というくらいの大きさで値段も安い．ここ1ヶ月くらい試行錯誤した結果左右ディスプレイの下に配置していて，これだと音がこもらずに使えている．

スピーカーの音について，多少批評を加えておくと，モニタースピーカーとして売っているもののあまり音はシャープではないと思う．ただデスクで使うのにそんなに音がシャープでも困るので調整としてはこれくらいで良い．また，サイズを考えるとかなり低音が豊富に出る印象でリスニングには向いている．音場はあまり広くはないかなという気がするが，これは設置方法の問題もあるかも．いずれにせよ絶対的な音質には気になる点もあるが，値段を考えると破格の音質だと思う．

### USB-DAC：RME ADI-2 DAC FS

{% include figure image_path="https://lh3.googleusercontent.com/xTQsYlsyU9uTYBIag-WNQZu_3pkPwLFy38IX3XYktLmgRcECWmvjsRkCjOSrPQbjQl-j5p3Pyzz69uz-vemGtPx_eJN_SMPFo2-eHu1E9WWSAVeBUMKI6d3Rz11_lseTkkLmqgK9Pw=w2400" alt="this is a placeholder image" caption="" %}

元はヘッドホンを楽しむために購入したDAC．サイズも小さくてデスクにちょうどよい大きさなのも良い．接続はimacからADI-2 DAC FSにだして，XLRをヘッドホンアンプPhonitor Xに，RCAをスピーカーreveal 402につないでいる．電源つけっぱなしでも全然発熱しないので長時間音楽を聞いたりしても問題ない．一方で，XLRとRCAの出力切り替えができないという問題があって，しょうがないのでスピーカーはswitchbotのプラグをかましてalexaから電源を切れるようにした．これならヘッドホンを使いたい時にはスピーカーを切ってヘッドホンアンプに出力が行く寸法だ．

### ヘッドホンアンプ：SPL Phonitor X

ヘッドホンアンプが欲しかったので買ってしまった．音に関しては（好みもあると思うが）文句なく良いと思う．一方でデスクに設置するにはサイズ（特に奥行き！）が大きかったのと，発熱がすごいのが難点ではある．本機にはADI2 DACと異なりヘッドホン端子とライン出力の切り替えスイッチがあるので，本当は電源つけっぱなしでこちらからスピーカーに繋ぎたかったのだが発熱のせいでそれがやりにくいのが残念．

### デスク拡張： サンワサプライ デスクエクステンション W70cm×D25cm

Phonitorがあまりにも大きくて奥行き70cmのデスクに普通におくと邪魔なので，このデスクエクステンションで奥行きを増やして設置している．本品はデスクにクランプで固定するタイプで，耐荷重は5kgと少ない代わりに大掛かりにならないのが良い．奥行きをちょっとだけ増やしたいという場合におすすめのアイテムだ．

{% include figure image_path="https://lh3.googleusercontent.com/1Kbn2zCaiPvH4s6RRtiItsrtBi7WeXvd6bS3olM4C2lxZXKsUu2N37FzKGhNSgUwGACTMVYNyijZiQBxwNZ9YEg0kcPPdcNIgO-PIAxk9BnLwYcDznTEt0RD6jiVJpSm2euEmJnNyw=w2400" alt="this is a placeholder image" caption="組み立て前の様子" %}

### マイク：Blue Yeti nano

コロナがはじまって以降増加したオンライン会議用に購入した．imacの内臓マイクもそこそこ音が良かったので劇的な改善はなかったが，1万円ちょっとで買えることを考えるとコストパフォーマンスは良いと思う．機能的にはlogicoolのアプリGhubで音質設定が可能な点がすぐれているが，imacでghubが使えない問題のせいで現状ただのマイクになってしまった．マウスのところでも述べたがGhubの安定性だけもう少しなんとかしてほしい．

また，本マイクに限らないがコンデンサーマイクは結構遠くの音も拾うので，在宅会議だとダイナミックマイクの方がよかったのかもしれない．

## その他の小物

その他の小物をいくつかピックアップして列挙する．

### デスク時計：キングジム LT10

以前キングジムから発売されていたプログラムアラーム時計．アプリから細かくアラームの時間を制御できる．とはいえもっぱら目覚ましとしてつかっているだけなのだが．．． スマホからアラームを止めることができるので，出張中などにアラームが止まらない事態を防げるのが便利だ．

### スマートスピーカー： echo show5

照明などの音声制御はalexaで行っている．appleのhomepodでもよかったのだが，時計，目覚ましとしても使えるのでディスプレイがついているこちらのタイプにした．実際使ってみて音声の認識はappleのsiriより優れているような気がする．amazonのセールでたまに安くなっている時が狙い目で，通常価格は割高と感じる人も多いかも．

### 電源タップ：サンワサプライ TAP-SLIM11-3BK，エレコム ECT-2620BK

{% include figure image_path="https://lh3.googleusercontent.com/pw/AIL4fc9va1iMdOshhk9u2F3cYm44nj3IMQBRQDmAAz3klS9RqwMhN-X_MyCsOMvo333i07dSDmHJXBHXtihbFFmEkl8jMOjlKY9lYzXQXalXA1M61N4moUM" alt="this is a placeholder image" caption="エレコム ECT-2620BK，二つの口だけ幅広に作られている" %}

趣味で電源をたくさんつかうこともあって電源タップの所持数は多い方だと思う．デスクでは合計16個の電源を使っていて，それを2つのコンセントから供給しないといけないので電源タップも口数が多いものに選択肢が限られている．現在はエレコムの10個口タップとサンワの11個口タップをデスク裏に設置して配線管理を行っている．両者ともマグネットでの固定が可能だ．サンワの方は５個だけ３ピンがささるようになっている一方で，両者とも極性非対応なので極性２ピンへは変換アダプタを噛ませる必要があるのが難点．調べた限りだと10個口程度で極性対応のものは業務用以外は見つからなかった．細かい配線の組み方についてはまた別の機会に記事にしたい．

{% include figure image_path="https://lh3.googleusercontent.com/pw/AIL4fc_KbVSz59I-n8I1lyze5esVXHDEGIagnNJxgr1V4U2utAbVUbhliwccCjjZBDORhwq6vNXClfeXJK_CyzxxAMZXteE3pjZGEn_B1RNgc63BKuBIIgg" alt="this is a placeholder image" caption="サンワ TAP-SLIM11-3BK，二面に挿すようになっている" %}

### USB充電器：Anker PowerPort I PD/ PowerPort III 2-Port/ Anker Prime Wall Charger

デスクのUSB充電器としてAnkerのPowerPort I PD - 1 PD & 4 PowerIQを利用している．これはUSB-Aが4ポートとUSB-Cが1ポートついていてまとめて電源をとるのに便利だ．ただ近年はUSB-Cがより支配的になっているのでこれから買うならUSB-Cポートがたくさんついているものを買うべきだろう．
他にmac book pro用におなじくAnkerのPowerPort III 2-Port 100Wもつかっていて，これはmac純正より小さい上に2port充電が可能なので非常に良い製品だと思う．自宅用と外出用に二台買うほどお気に入り．

{% include figure image_path="https://lh3.googleusercontent.com/pw/AIL4fc9yT-0O0J1-hH4GqE5xU6pB1HRi_nf_B1EyBmJxUy12M2_RLkNVxb9XfvWgYHRYk4qfXE38DX_XdHkIWKhyVnmayTrGg8eN7T-bnLTLxkqnK_VkOTQ=w2400
" alt="this is a placeholder image" caption="PowerPort III(左)とappleの純正96W充電器(右)の比較．" %}

また，同じく100Wの充電器としてAnkerのPrime Wall Chargerも購入した．こちらはUSB-Aが1ポートとUSB-Cが2ポートついており，USB-CのみのPowerPort IIIよりも汎用性が高いが，こちらの方が気持ち発熱が多いように感じる．

### ケーブル類

付属品でついてくるケーブルで長さが短いものや取り回しが悪いものは他のものに買い替えるようにしている．コストを抑えるために転送性能の必要なケーブル，充電のみできればよいケーブルなどを極力峻別して購入している．ケーブルの材質はシリコンやナイロンなど，取り回しと耐久性に優れたものを買っておいた方が結局安くつくとおもう．

- belkin thunderbolt4 2m (INZ002bt2MBK)：ディスプレイ接続用のthunderboltケーブル．ケーブル自体も柔らかくて取り回しも良い．
- XLRケーブル 2m (CANARE EC02B)：USB-DACとアンプ接続のケーブル．楽器店のサウンドハウスに長さや色別で売っているので便利．



### サーキュレーター：アイリスオーヤマ PCF-SCAI15T

{% include figure image_path="https://lh3.googleusercontent.com/iW1EBooEYzRuRb_tojAa9B1kxLlGZPSm48e8U9RrZQM1uUQwT4hyLD4oPZQOqZgj4N56NZ59vjNT1PWV48LoKs4rdnWCMK0SNOzStZ7gFE2Y6b71mpSLvozeoplz-k-KXIuyzrlRNw" alt="this is a placeholder image" caption="" %}

imacの冷却用に使っているアイリスオーヤマのサーキュレーター．音はサーキュレーターにしては静かだが無音というわけではないくらい．私は音に鈍感なほうなので普段作業する分には問題ないが，神経質な方は注意した方がよいと思う．本品はalexaからの操作に対応しているのがポイントで，作業する時に電源が入るように設定して使っている．

### blue-rayドライブ：Pioneer BDR-X12J-UHD

{% include figure image_path="https://lh3.googleusercontent.com/oaFW-rPrK-HB40CjkUszkHSV9ezyLea6i6ltzibPw3criKR2VUiGORS25B7g3HCuujF7N0raVgMPDzFAFu3GEQd89qwuAVZq4n-3bD7_Ql3u3a5WlpNDPDxuvndyEZ-J5vf_fuAsew=w2400" alt="this is a placeholder image" caption="" %}

未だにCDを買ってリッピングをすることがあるので必須ということでデスクに配置してある．以前はapple純正のバスパワータイプを使っていたが音飛びが酷かったので奮発して購入した．こちらは全く音飛びがないのでやっぱり餅は餅屋ということか．今の所CDの読み込みにしか利用していないがBluerayも読めるらしく，未だにこの手のメディアを使う人なら一台持っていて損はないと思う．windows機だといくつか付属のソフトが使えるらしいが，macには非対応なのが残念．（使うだけならmacでも問題ない．）

## 今後やりたいこと

在宅ワークも長くなってきて既に結構環境には満足しているが，追加で試してみたいことをリストアップして終わりたい．

- デスクの買い換え：今使っているオカムラの組み立て事務デスクも悪くはないが，高さ70cmは私には微妙に低いということがあって，できればもっと高さ調整に自由がきく昇降式のデスクに買い替えたいと思っている．もう一点このデスク，幕板で横方向の強度を確保する作りになっていて，この幕板が邪魔というのもある．同じオカムラからはswiftという昇降デスクが発売されていて一回見に行ってみたい．
- studio displayを複数のPC間で使う方法を考えたい．imacの他にmac book proを繋げて使いたくて，thunderboltのスイッチャーとかがあると良いのだがニッチすぎて製品が見つからない．．．
- ipadの設置場所：現状ipadはデスクに直置きしているが，これもvesaなどで吊りたい．できればモニターのエルゴトロンLXにクランプなどで固定できると良いのだが．
- ミラーレスの設置方法の変更：現状オンライン会議で利用しているミラーレスは都度机の上にミニ三脚で設置していて，これがちょっと面倒くさいのでできればアームか何かで固定するようにしたい．
- 壁の有効利用：現状デスク正面の壁がデッドスペースになっているので，ここに収納などを作りたい．

## まとめ

5月にEIZOのディスプレイを購入してからスピーカーの配置変更などを1ヶ月くらいかけて試行錯誤して，ようやく落ち着いた感がある．おしゃれや綺麗とは程遠いがズボラな人間が作業するにはこれくらいがちょうどよい．来年には引っ越しも控えているのでこまめに記録として残しておいて再現しやすいようにしたいと考えている．



{% comment %}
https://gadget-touch.info/2018/02/07/hue-review/
{% endcomment %}


