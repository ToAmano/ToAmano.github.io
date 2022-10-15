---
layout: default
title:  "その他諸々のアプリなど"
date:   2022-09-04 10:03:40 +0900
categories: app
---

## その他諸々のアプリなど



## Zotero(文献管理)
文献管理アプリの一つZoteroについてのメモ．Zoteroはgoogle driveなどのクラウドとの連携で（ほとんどの場合）無料で利用することができる．プラグインも色々揃っているので自分のやりたいことを実現しやすい．

### install
```bash
brew install --cask zotero
```

### ブラウザからpdfを取ってきてくれる公式拡張機能の導入



### zotero+zotfile+クラウドの連携

ここにzotfileを入れるんだけど，これは

[ZotFile](http://zotfile.com/)

にアクセスするしかないっぽい．

→ zipを入れたら，zoteroのツールバーから，ツール → addonと行けば良い．

インストールしたら，以下の設定を行う．zoteroとzotfile両方に設定が必要．

[Zotero で論文管理してみた話 - Qiita](https://qiita.com/Yarakashi_Kikohshi/items/39dfbf3059aaf0690761)

```bash
Zotero
zotero→環境設定→
1. 同期→ファイルの同期の2つのチェックを外す．
2. 詳細→ファイルとフォルダ→基本ディレクトリをgoogledriveへ
3. 詳細→ファイルとフォルダ→データディレクトリを/Users/amano/Documents/Zoteroへ

zotfile
tools→zotfile preference
General setting → Location of Files
→ CustomLocationでGoogleDriveのフォルダを選ぶ．
同じくUse subfolder defined byで，/%c/%w/%yとする．
これでcollection/journal/yearで分類される．

```

最後の/%c/の分類によって，論文をある程度わかりやすく管理できるかなと思う．ただすこしわからないのは，zoteroだとサブコレクションがあって，メインコレクションにいれた文書はサブコレクションに入れられる．逆にサブコレクションに入れたものはメインコレクションに入れられない．対応して，保存するときは基本的にメインコレクションに入れておくのが良い？

- この点に関しては，以下のような記事があった．

[Collection and Subcollection](https://forums.zotero.org/discussion/62575/collection-and-subcollection)

[collections and tags [Zotero Documentation]](https://www.zotero.org/support/collections_and_tags)

というわけで，collection間でitemを追加でなく移動する場合は，cmdを押しながらdragすること．



## [betterbibtex](https://retorque.re/zotero-better-bibtex/)
Zoteroから出力できるbibtexファイルをカスタマイズするための拡張機能．


- citation keyの変更
citation keyとはTeX文書中で`¥cite{...}`のところで利用する文字列のこと．

環境設定を開くとBetter BibTeXの項目が追加されているのでそれを開く．defaultで
```
auth.lower + shorttitle(3,3) + year
```
になっているところを
```
[auth:lower][year][shorttitle1_1]
```
に変更する．その後 Zotero のコンソール画面で、マイライブラリ全体を全選択（Cmd+A）し、右クリック > Better Bib Tex > Reflesh Bib Tex key を選択する．




## その他

- 左欄の下の方に重複アイテム

- **Zotero Citation Counts Manager**

[GitHub - eschnett/zotero-citationcounts: Zotero plugin for auto-fetching citation counts from various sources](https://github.com/eschnett/zotero-citationcounts)

一応入れてみたが，google scholarからはデータをとってこないようで，あまりあてにならなそう．．．

- zotero storage scanner

[GitHub - retorquere/zotero-storage-scanner: A Zotero plugin to remove the broken & duplicate attachment link of the bibliography](https://github.com/retorquere/zotero-storage-scanner)

重複ファイルを調べてくれる．

- zoteroQuickLook

[GitHub - mronkko/ZoteroQuickLook: Implements QuickLook in Zotero](https://github.com/mronkko/ZoteroQuickLook)

→ beta版でzotero PDF readerなるものが導入されて，これが結構使いやすいらしい．

- zotero beta and zotero PDF viewer

[dev builds [Zotero Documentation]](https://www.zotero.org/support/dev_builds)

→ これはかなり使いやすいわ！ zotero connecterとzot fileは今まで通り使えそうなので，問題が発生するまではこのbetaを使用する．（2021/10/28）

[pdf reader preview [Zotero Documentation]](https://www.zotero.org/support/pdf_reader_preview)

annotationではcitationが使用できないっぽいが，note（右側に表示されるやつ）の方ではcitationを使用することができる．これは便利だね．
