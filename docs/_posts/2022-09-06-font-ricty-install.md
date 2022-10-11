---
layout: single
title:  "プログラミング用フォントRictyを試す"
date:   2022-09-06 10:00:00 +0900
categories: vscode 
---

## Rictyのインストール via homebrew

homebrewからインストールする場合，

```bash
$ brew tap sanemat/font
$ brew install ricty
```

を実行する．成功すれば以下のようなコメントが出力される．

```bash
***************************************************
To install Ricty:
  $ cp -f /opt/homebrew/opt/ricty/share/fonts/Ricty*.ttf ~/Library/Fonts/
  $ fc-cache -vf
***************************************************
```

`fc-cache`はmacにフォントをインストールするためのコマンド．ライセンスの関係でフォントの生成は自分でやる必要があるということのようだ．

## Ricty Diminishのインストール via homebrew

Rictyの姉妹フォントであるRicty Diminishのインストールは

```bash
$ brew install --cask font-ricty-diminished
```

で良い．

## フォントがインストールされていることの確認

フォント一覧を表示する`fc-list`コマンドを利用していくつか結果が出て来れば成功．

```bash
$ fc-list : family | grep -i ricty

Ricty Discord
Ricty Diminished Discord
Ricty
Ricty Diminished
```


## VScodeにフォントを適用する

Rictyを試しにVScodeに導入する．GUIで設定する場合はcode>基本設定>設定からEditor:Font Familyを探して，ここにRictyを追加する．順番は前のものをより優先して利用する，ということのようだ．

```markdown
# デフォルト
Menlo, Monaco, 'Courier New', monospace

# 変更後
Ricty, Menlo, Monaco, 'Courier New', monospace

# Ricty Diminishedを利用する場合には'が必要（スペースのあるフォント名には必須らしい）
'Ricty Diminished', Menlo, Monaco, 'Courier New', monospace
```

## バッククォートの表示がおかしい問題について

[こちら](https://memo.koumei2.com/vscode%E3%81%AE%E3%83%90%E3%83%83%E3%82%AF%E3%82%AF%E3%82%A9%E3%83%BC%E3%83%88%E8%A1%A8%E7%A4%BA%E3%81%8C%E3%81%8A%E3%81%8B%E3%81%97%E3%81%84/)の記事を参考にして修正．

まず，入っていなければfontforgeをインストール．

```bash
brew install fontforge
```

次のようなスクリプトを書く．一行目はインストールされているfontforgeの場所に合わせて修正する．以下はm1mac+homebrewの場合のデフォルトの場所になっている．

```bash:fix_ricty.pe
#!/opt/homebrew/bin/fontforge -lang ff

Open($1)
Select(0u0060)
SetGlyphClass("base")
Generate($1)
```

あとはこのスクリプトをRictyに対して適用する．フォントがインストールされている場所は`/Library/Fonts/`以下なので

```bash
# スクリプトに実行権限を付与
chmod +x fix_ricty.pe

# Rictyを一括変換
./fix_ricty.pe ~/Library/Fonts/Ricty*
```

で修正されたフォントが生成される．

## 肝心の見栄えについて

英語を利用する場合は優れたフォントが数多くあるが，日本語フォントについては今まであまり気にしたことがなかった．自分は少なくともVScodeのデフォルトフォントよりはみやすいと思うのでしばらく使ってみようと思う．

