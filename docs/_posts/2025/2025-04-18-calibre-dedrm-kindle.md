---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: 【calibre】kindle電子書籍のDRM解除方法
layout: single
date:   2025-4-18 21:00:00 +0900
categories: coding
tags:
 - mac
 - kingle
 - apple
toc: true
header:
  teaser: 
description: Calibreを利用したamazon kindle本のDeDRM方法について，今までcalibre4を利用していたのをアップデートして，2025/4時点で最新のバージョンを使って環境を作り直したので方法のメモ．
gallery1:
 - url: /assets/posts/2025-04-18-calibre-dedrm-kindle/kindle_option.png
   image_path: /assets/posts/2025-04-18-calibre-dedrm-kindle/kindle_option.png
   alt: "placeholder image 1"
   title: "Image 1 title caption"
 - url: /assets/posts/2025-04-18-calibre-dedrm-kindle/kindle_filepath.png
   image_path: /assets/posts/2025-04-18-calibre-dedrm-kindle/kindle_filepath.png
   alt: "placeholder image 1"
   title: "Image 1 title caption"
gallery2:
 - url: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_setting.png
   image_path: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_setting.png
   alt: "placeholder image 1"
   title: "Image 1 title caption"
 - url: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_plugin.png
   image_path: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_plugin.png
   alt: "placeholder image 1"
   title: "Image 1 title caption"
gallery3:
 - url: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_convertformat.png
   image_path: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_convertformat.png
   alt: "placeholder image 1"
   title: "Image 1 title caption"
 - url: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_convertformat2.png
   image_path: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_convertformat2.png
   alt: "placeholder image 1"
   title: "Image 1 title caption"
gallery4:
 - url: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_kobo.png
   image_path: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_kobo.png
   alt: "placeholder image 1"
   title: "Image 1 title caption"
 - url: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_kobo_dedrm.png
   image_path: /assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_kobo_dedrm.png
   alt: "placeholder image 1"
   title: "Image 1 title caption"
---


Calibreを利用したamazon kindle本のDeDRM方法について，今までcalibre4を利用していたのをアップデートして，2025/4時点で最新のバージョンを使って環境を作り直したので方法のメモ．

# amazon kindle本のDeDRM方法

結論から言うと、2025/4/18現在、kindle本のDRM解除は、windows+calibre+deDRMで実行可能である．いくつか実行上の注意点があるので、そこに触れながら手順を紹介する．

**Notice:** Macではたぶんこの手順では無理で、Windowsマシンが必須と思われる．(一部kindleデバイスがあればできるみたいな記事もあるが、手元にないので未検証）
{: .notice}

**Notice:** kindleはたびたびDRMがアップデートされており、ここの方法もそのうち動かなくなる可能性がある．実際にネットの記事を参考にするときはいつ書かれたものか注意しないといけない．
{: .notice}

### 0. 事前準備

windows PCを用意する．以下の手順はWindowsa11で実施したが、以前Windows10でも実行したことがあるのでおそらくどちらでも動くはず．

### 1. kindle for PCのインストール

kindle本のダウンロードのため、kindle for PCを用意する．バージョンが重要で、現在**バージョン2.4.0以下**を使う必要がある．最新版は2.7なので、すでに最新のkindleが入っている場合はいったんアンインストールしてから古いバージョンを入れる必要がある．アンインストールする場合はwindowsのメニューから「インストールされているアプリ」へ行き、アプリの三点リーダからアンインストールできる．

{% include figure popup=true image_path="/assets/posts/2025-04-18-calibre-dedrm-kindle/uninstall_kindle.png" alt="" caption="これはWindows11の場合で、10の場合は若干違うかも．" %}

kindleの古いバージョンはおそらく公式ページには残っていないので、野良サイトから入れる必要がある．ここではepubor.comで提供されていたv.2.4の[リンク](https://download.epubor.com/KindleForPC-installer-2.4.0-70904.exe?_ga=2.51666025.137058597.1744960351-807057709.1744960351&_gl=1*10j9u4g*_gcl_au*MTQ2MTcyNjc4MC4xNzQ0OTYwMzUx*_ga*ODA3MDU3NzA5LjE3NDQ5NjAzNTE.*_ga_BFKP04KTVR*MTc0NDk2MDM1MS4xLjEuMTc0NDk2MjMyMS42MC4wLjA)を利用した.

インストール後、ログイン、同期してDRM解除したい本をローカルにダウンロードする．ダウンロードされたファイルの場所は、ツール>オプション>コンテンツから確認できる．自分の場合は`OneDrive/ドキュメント/My Kindle Content`という場所にあった．

{% include gallery id="gallery1" caption="(左)ツールは左上にある． (右)パスの確認中．自分で指定したパスに変更もできる．" %}

### 2. Calibre8.3.0のインストール

次に、Calibreをインストールする．こちらのサイトからWindows版の最新（現在8.3.0）を入れよう．ちなみに古いバージョンでも試したが問題なく動いたので，Calibre側のバージョンはあまりシビアにならなくて良さそうだ．

{% include figure popup=true image_path="/assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_install.png" alt="" caption="" %}

インストールして起動ができることを確認する．ここにCalibre用のDRM解除(DeDRM)プラグインをインストールしていく．

### 3. Calibre用のDeDRMプラグインをダウンロード

---

Calibre用のDeDRMプラグインがgithubにあるのでそれをダウンロードする．おおもとのレポジトリは以下の`apprenticeharper/DeDRM_tools`だが、これはメンテされていないっぽいのでフォークの一つである`noDRM/DeDRM_tools`を利用した．

- おおもとのレポジトリ

[https://github.com/apprenticeharper/DeDRM_tools](https://github.com/apprenticeharper/DeDRM_tools)

- 今回利用したレポジトリ

[https://github.com/noDRM/DeDRM_tools](https://github.com/noDRM/DeDRM_tools)

Releasesから極力新しいものを選んでv10.0.9をダウンロードした．リンクは[こちら](https://github.com/noDRM/DeDRM_tools/releases/download/v10.0.9/DeDRM_tools_10.0.9.zip)．

ダウンロード後に解凍すると、中に`DeDRM_plugin`と`Obok_plugin`というzipが入っており、これを次のステップで利用する．

{% include figure popup=true image_path="/assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_dedrm_tools_dir.png" alt="" caption="" %}

**Notice:** Obok_pluginは今回は不要だが、kobo本をdeDRMするときに利用できるので一緒に入れておくと便利だ．
{: .notice}

### 4. DeDRMプラグインをCalibreにインストール

Calibreにステップ3でダウンロードしたプラグインを入れる．環境設定>プラグインと進む．

{% include gallery id="gallery2" caption="(左)Calibreの設定画面． (右)プラグイン画面．" %}

次に、右下の「ファイルからプラグインを読み込み」から、ステップ3でダウンロードした`DeDRM_plugin` を選択してインストールする．プラグインを有効化するためにCalibreを再起動する．

{% include figure popup=true image_path="/assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_load_plugin_from_file.png" alt="" caption="" %}

### 5. kfx inputプラグインをインストール

別のプラグインを一つ入れる．これはkindleのkfx形式に対応するために必要なプラグイン．再び環境設定>プラグインから、左下の「新規プラグインを取得」をクリックして、「kfx」で検索し、インストールする．インストール後は再起動が必要．

{% include figure popup=true image_path="/assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_kfxinput.png" alt="" caption="" %}

**Notice:** deDRM_toolとちがって、KFX inputはCalibreのライブラリにすでに登録されているためこのような簡単な手順でインストールできる．
{: .notice}

### 6. 実際にDeDRMをかける

以上で準備が完了した．kindle本のDRM解除をするには、左上の「本を追加」から、ステップ1でダウンロードしたkindle本（拡張子azw）を選択する．ファイル名はわけわからないので更新時間や容量から推測するしかない．．．

{% include figure popup=true image_path="/assets/posts/2025-04-18-calibre-dedrm-kindle/kindle_file.png" alt="" caption="" %}

読み込みが完了し、書籍の形式がKFXになっていればDeDRMが成功している．DeDRM_toolは読み込み時にDRM解除をするので，この段階で失敗していたらバージョンなど何かがおかしいということ．再度やり直そう．

{% include figure popup=true image_path="/assets/posts/2025-04-18-calibre-dedrm-kindle/dedrm_success.png" alt="" caption="" %}

**Notice:** deDRMに失敗すると、書籍の形式がKFX-ZIPになっているため、容易に判別がつく．この時はkindleバージョンが2.7になっていて失敗していた．

{% include figure popup=true image_path="/assets/posts/2025-04-18-calibre-dedrm-kindle/dedrm_fail.png" alt="" caption="" %}
{: .notice}

### (option) 7. フォーマットを変更する

epub形式やpdf形式で書き出したい場合は、そのままcalibre上で作業できる．「本を変換」を選択し、右下のOKを押すとデフォルトでepub形式で書籍を書き出せる．これでDRM解除したepub形式のファイルが手にはいるので、自分のお気に入りの環境で本を読める．

{% include gallery id="gallery3" caption="(左)本を変換． (右)変換時の画面．右上でフォーマットを選択し，右下から実行する．" %}

**Notice:** 出力形式を変更する場合は右上の出力形式から所望の形式を選択できる．教科書など、ものによってはpdf形式も使いやすいので、自分は両方書き出すようにしている．
{: .notice}

### (option) 8. pdf形式で書き出すときの設定

pdf形式で書き出す際、余白が大きくなってしまうことがある．多少なりともましにするには、書き出すときの「ページ設定」で、余白を上下左右0ポイントに設定する．

{% include figure popup=true image_path="/assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_pdf.png" alt="" caption="" %}

## koboの書籍をdeDRMする方法

ステップ3でダウンロードした`Obok_plugin` をCalibreにインストールすると、右上に「Obok DeDRM」というマークが現れるので、これをクリックするとkoboの本はDRM解除できる．koboの場合はWindowsでもMacでもこの方法で実行できるため、以下macで実行した．

{% include figure popup=true image_path="/assets/posts/2025-04-18-calibre-dedrm-kindle/calibre_kobo.png" alt="" caption="" %}

### 1. 楽天koboデスクトップのインストール

下記ページからmac/windows向けのデスクトップアプリをインストールし，同期して本をローカルに落としておく．

[初めての方へ：楽天Kobo電子書籍ストア](https://books.rakuten.co.jp/info/introduction/e-book/)

### 2. DeDRMの実行

koboデスクトップが入ったら，あとはCalibre上で「Obok DeDRM」をクリックすると，画像のようにポップアップが出てきて一括でDeDRMを実行できる．

{% include gallery id="gallery4" caption="(左)追加されたアイコン． (右)変換時の画面．kindleと違って自動でkoboライブラリを探してきてくれるので便利だ．" %}

## 参考文献

- [How to Remove DRM from KFX ZIP Files?](https://www.epubor.com/how-to-remove-drm-from-kfx-zip-files.html)
- [kindle本のDRMを解除してPDFにする方法 - Qiita](https://qiita.com/takatukioniku/items/731ab5b656210a2739e5)
