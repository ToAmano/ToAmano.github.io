---
layout: single
title:  "vscodeトップページ"
date:   2022-09-04 10:03:40 +0900
categories: vscode
---

## 拡張機能
### 一般的な拡張

1.PlantUML
    UML図を作成する．
1.Todo Tree
    ソースコード内にコメントで「TODO」と記載することでTODOをリスト管理できる．
1. Material Icon Theme
   explorerに表示されるフォルダのアイコンを視認性よくしてくれる．emacsのall-the-iconを思い出す．
1. Better Comments
    コメントの先頭に! * ? //を書くとその行の色を変えてくれる．
1. indent rainbow
    indentに色付け．特にpythonだと有用．
### markdown用拡張
<!-- https://ics.media/entry/18756/ -->
1. Markdown All in One
1. MarkdownLint
1. Markmap
    markdownの構造マップを見れる
1. Marp
    markdownからスライドを作成．<!--https://qiita.com/tomo_makes/items/aafae4021986553ae1d8 -->

### python

- 仮想環境の切り替えはステータスバーからできる．

### LaTeX

1. latex workshop
1. [CaTeX](https://konn-san.com/articles/2018-11-26-happy-latex-with-catex.html)
1. [LTeX](https://valentjn.github.io/ltex/)
    latexで英語の文法をチェックしてくれるかなり強力な拡張機能．英単語のスペルミスのみならず英文法もチェックしてくれる．

## 設定ファイルをdotfileで管理する

vscodeの設定ファイルは`~/Library/Application\ Support/Code/User/settings.json`にあるので，これをdotfileで管理してシンボリックリンクをはるようにするとよい．

既にインストールされている拡張機能はターミナルで`code`コマンドを利用して

```bash
# install vscode via homebrew
brew install --cask visual-studio-code

# see all extensions
code --list-extensions
```

とすることで確認できる．`code`コマンドが入っていない場合はhomebrewでvscodeをインストールし直すとよい．拡張機能をシェルスクリプトでインストールするには同じく`code`コマンドを利用して

```bash
code --install-extension ms-toolsai.jupyter
```

などとする．インストール時の拡張機能の名前はGUIで拡張機能のページを見るときに右側に表示されている．


<!--
https://omoshiteca.hatenablog.com/entry/2019/10/14/203531
https://atmarkit.itmedia.co.jp/ait/articles/2105/21/news026.html
設定ファイルの場所: https://maku.blog/p/tfq2cnw/
https://ics.media/entry/18756/
https://ics.media/entry/18756/
-->
