---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: youtube-dlでzoomの動画をダウンロードする
layout: single
date:   2023-7-26 21:00:00 +0900
categories: 
 - code
tags:
 - bash
description: youtube-dlでzoomの動画をダウンロードする．
---

cliの動画ダウンロードツールyoutube-dlは種々のサイトの動画DLに使えて重宝するが，今回はzoomの動画をDLする方法について調べたのでまとめる．開発者ツールを使って必要な情報を取得するというよくあるテクニックを用いることで簡単にできる．動画にパスワードがかかっていても問題ない．

## youtube-dlのバージョン

チェックしてみたら少し古いバージョンで試していた．
```bash
$ youtube-dl --version
2021.12.17
```

Zoomはyoutube-dlが公式で対応している．[対応サイトリスト](https://ytdl-org.github.io/youtube-dl/supportedsites.html)にも記載がある．

## zoomの動画ページから必要な情報を取得

ここではchromeを使う方法を紹介するが，他のブラウザでも似たことができると思う．まず，webページで右クリック->検証として開発者ツールを起動する．タブの中に「Network」があるのでそこに移動し，その状態でwebページを再読み込みするとネットワークのやりとりの一覧が表示される．

この一覧のなかから「mp4」を検索すると，GMTで始まる名前の項目が出てくる．これがお目当ての動画の項目だ．

この項目をクリックすると詳細が出てくる．その中でHeaderをチェックする．必要なのはHeader->Generalにある「Request URL」とHeader->Request Headersにある「Cookie」の値だ．これらをメモ帳かなにかにコピーしておく．


## youtube-dlでのダウンロード

ダウンロードのコマンドは以下のようんになる．大事なのは`--referer`オプションと`--add-header`オプションである．出力形式はここでは`-o video.mp4`としてmp4形式で保存する．

```bash
$ youtube-dl --referer "https://zoom.us/" --add-header "cookie: your-cookie" "your-request-url" -o "video.mp4"
```

これでちゃんと動画が保存されるはず．



## 参考文献

[How to download zoom recordings](https://michaelabrahamsen.com/posts/how-to-download-zoom-recordings/)