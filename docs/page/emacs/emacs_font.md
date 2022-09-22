---
layout: default
title:  "emacs フォントやアイコンについて"
date:   2022-09-04 10:03:40 +0900
categories: emacs font gryph
---

emacsをiterm2で利用する場合（注意！ GUIではない！）のフォントやアイコンの設定について．

## emacsのフォント

ターミナルアプリでemacsを利用する場合，基本的にemacsはターミナルと同じフォントを利用する．（変更できない？） 例えば

```lisp
M: (font-family-list)
```

はGUIで実行すると利用可能なフォントを返すが，ターミナル上で実行すると`nil`が返ってきて設定できない．初心者の頃GUI emacsの記述を参考にターミナルでも同様の設定ができるのかと悪戦苦闘したので似たような被害者が出ないように（？）記述を残しておく．

もしかするとまた別な方法でターミナルとemacsで別々のフォントを設定する方法があるのかもしれないが自分は諦めている．まあターミナルをみやすいフォントにしておけばそこまで困ることはないだろうし．．．


<!-- 
GUIでのフォント設定について．

https://qiita.com/j8takagi/items/01aecdd28f87cdd3cd2c
https://www.emacswiki.org/emacs/iTerm2#h5o-8
https://qiita.com/TanukiTam/items/2df29e9b10e84a7d67a6
https://www.emacswiki.org/emacs/SetFonts
https://www.reddit.com/r/emacs/comments/pc189c/fonts_in_emacs_daemon_mode/
-->

## アイコンの利用（icons-in-terminal）

こちらが本題．GUI emacsではall-the-iconsというパッケージを使ってアイコンを利用することができるが，ターミナルでは上記のようにフォントがターミナルのものになるのでこのパッケージを使えない．これを代替する手法として，[icons-in-terminal](https://github.com/sebastiencs/icons-in-terminal#integrations)があるのでここで導入方法を紹介する．


```bash:install_icons_in_terminal.sh
# download from github
$ git clone https://github.com/sebastiencs/icons-in-terminal.git
$ cd icons-in-terminal

# install 
$ ./install.sh  
```

install後に出力されるように，`~/.config/fontconfig/conf.d/30-icons.conf`ファイルを編集して自分がターミナルで使うフォントだけを残しておく．

ここまでやったら，ちゃんとインストールできたかを確認する．

```bash
# check if correctly installed
$ ./print_icons.sh
```

綺麗に全てのフォントが出力されて入れば大成功．

Macにフォントが認識されているかを知りたければ`fc-list`コマンドを利用して

```bash
$ fc-list | grep -i icons-in-terminal
/Users/hoge/Library/Fonts/icons-in-terminal.ttf: icons\-in\-terminal:style=in-terminal
/Users/hoge/.fonts/icons-in-terminal.ttf: icons\-in\-terminal:style=in-terminal
```

のようになれば成功．

`install.sh`が`~/.local/share/icons-in-terminal`ディレクトリに内容をコピーするので，外部から参照するときはこれを使うと（どこでgit cloneしたかによらずに設定できるので）良い．ただファイルをコピーしているだけなので自分で好きなところに置いても良い．自分は設定用のファイルがあちこちに散らばると嫌なので


## うまくいかない場合（非ASCIIを含むフォントを利用している？）

自分の場合は非ASCII文字を含む[menlo for powerline](https://github.com/lxbrtsch/Menlo-for-Powerline)を利用していた[^1]．このような場合，icons-in-terminalと競合してしまって`./print_icons.sh`で一部フォントがうまく表示されない場合がある（原因は間違っているかも）[^2]．さらに自分の環境だと，itermを再起動すると表示されなくなるなどどうも挙動が不安定なことがある．そこでとりあえずの対策としてnon-ASCII文字に別のフォントを利用する作戦を使う．icons-in-terminalはそれ自体が特殊文字を大量に含んだフォントなので，これをnon-ASCII文字用のフォントとして設定すればうまく動いてくれるという仕組み．（この場合はおそらく`install.sh`すら実行する必要がなく`icons-in-terminal.ttf`だけあれば良いと思う．）

- まずicons-in-terminalが悪さをしないように`~/.config/fontconfig/conf.d/30-icons.conf`で全てのフォントの行をコメントアウト．
- itermのpreferences>profiles>textのfontのところで`use a different font for non-ASCII text`にチェックを入れる．
- そうするとnon-ASCII用のフォントを設定する項目が現れるので`icons-in-terminal`を選択．表れない場合はFinderで`icons-in-terminal.ttf`をダブルクリックしてMacにフォントをインストールしよう．

以上で`./print_icons.sh`を実行すると自分の場合は全てのアイコンが綺麗に出力された．iterm2ではこのようにnon-ASCIIに別のフォントを割り当てられるので，仮に上のステップでインストールがうまくいく場合でも，こちらの方が元のフォントをいじらずに安全だと思う．

## シェルでアイコンを表示させる（bash,zsh）

各アイコンには`\ue0b3`のような命令が指定されていて，これを使って表示のカスタマイズをおこなっている．しかしこれだとどのアイコンがどのコマンドなのか非常に分かりにくい．そこで各アイコンに名前を対応させるスクリプト`build/icons_bash.sh`がデフォルトで用意されている．これを使うためには単にsourceでファイルを読めばよい．恒常的に使う場合は`.zshrc`に書き込むとよい．

```bash
# ファイルを読み込み
$ source build/icons_bash.sh
# うまくいっているかテスト（この例だとファイルアイコンを表示）
$ echo $oct_file_media
```

## emacsでicons-in-terminalを使う．

icons-in-terminalにはemacs用のパッケージファイル`build/icons-in-terminal.el`が付属してくる．中身を見ればわかるようにフォント名と対応するグリフがずらりと並ぶ設定ファイルになっている．

```lisp
% 一例
( powerline_branch . "\xe0a0" )
```

実際にグリフを出力するにはLispで

```lisp
(insert (icons-in-terminal 'oct_flame))
```

とすればよい．従って，既存のパッケージでグリフを使いたい奴があったら，ちょっと面倒だが上のコマンドで書き換えることで利用可能．その際

```lisp
(require 'icons-in-termial)
```

を忘れずに！ 自分は今の所，all-the-iconsの書き換えしか行ったことがないが，これなら面倒なだけであまり技術はなくてもできる．やはりアイコン表示だと分かりやすいのでやる価値はある．そのうち書き直したelファイルをgitに上げられると良いのだが．．．

<!--
## 現状の環境の作り方

```markdown
# iterm2(ascii)     :: menlo for powerline
# iterm2(non-ascii) :: icons-in-terminal
```

```bash:install_menlo_for_powerline.sh
# menlo for powerlineのdownload
$ git clone https://github.com/lxbrtsch/Menlo-for-Powerline

# Finderでディレクトリの中の*.ttfファイルをダブルクリックしてフォントをインストールする．
```
-->


## 余談：icons-in-terminalの仕組みについて

[^1]: powerlineライクなプロンプトを自作するために導入した記憶がある．powerlineでは特殊文字を利用するため，それが入っているフォントが必要だった．

[^2]: そのほかに公式のgithubに元のフォントを編集してあるとうまくいかない場合があるとあるので，フォント自体をクリーンインストールしてみるのも手かも．