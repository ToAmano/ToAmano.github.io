---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: aspell+emacsでTeX文書の英語スペルチェック
layout: single
date:   2023-11-27 21:00:00 +0900
categories: 
 - code
tags:
 - bash
 - emacs
description: aspellとemacsによるTeX文書のスペルチェック方法をispellとflyspellのふたつ紹介．
---

以前にaspellを利用したTeX文書のスペルチェックの方法についての記事を書いたが，今回はそのスペルチェックをemacs上から実行する方法についてまとめる．方法はいくつかあるが，基本的な精神はemacsから外部のaspellなどのスペルチェックプログラムを参照してくれるというもので，emacs自体になにかスペルチェックをする機能があるわけではない．今回紹介する方法はスペルチェックプログラムとしてaspellを使う方法である．スペルチェックというと通常のコードにおける構文チェックのことも考えるが，今回の記事はあくまでTeX文書の英語スペルの間違いチェックのみに注力する．

## Macでのaspellのインストール

macでのaspellはhomebrewないしmacportsで簡単にインストールできる．

```bash
# homebrewの場合
brew install aspell 

# macportsの場合
sudo port install aspell 
```

## Emacsからaspellによるスペルチェックを可能にするispellパッケージ

名前がややこしいが，Emacs上からaspellを起動するパッケージはispellである．これは古くはispellというスペルチェッカがよく用いられていたことに起因する．`use-package`を使う場合の`init.el`の設定の例は以下のようなものである．

```emacs
(use-package ispell
  :ensure t ; 入っていない場合にインストールする
  :init
  (setq-default ispell-program-name "aspell") ; スペルチェッカーとしてaspellを利用
  :config
  (setq ispell-check-comments nil) ; コメント行はチェックしない
  (setq ispell-extra-args '("-t")) ; tex文書
  (setq ispell-local-dictionary "en_US") ; 辞書の指定
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+")) ;日本語の部分を飛ばす
)
```

最初の`ispell-program-name`でスペルチェッカーとして使うプログラムを指定する．自分の場合，環境によって`aspell`をフルパスで指定しないとemacsが見つけてくれないことがあった．この例では，`ispell-local-dictionary`で辞書としてデフォルトのアメリカ英語辞書を指定している．また，日英混在文書を処理するときのために最終行で日本語の部分を飛ばす設定にしてある．TeX文書用のaspellのオプション`-t`を`ispell-extra-args`で指定するとTeX構文がエラーで引っかかるのを防げる（完璧ではないが）．

この状態でemacs上で`M-x ispell`として対話的なスペルチェックを実行できる．とはいえ，正直これをやるんだったら一旦emacsから出てシェルでaspellを直接実行したほうが便利かな，と個人的には思う．

## Flyspellによるオンザフライのスペルチェック

Emacs上でスペルチェックするメリットを実感するには，やはりオンザフライで誤りを検出できる方がよいだろう．それを実現してくれるパッケージの一つがFlyspellである．Flyspellは編集中に誤り候補の単語の色を変えて強調してくれる．

```emacs
(use-package flyspell
    :ensure t
    :hook (yatex-mode . flyspell-mode)
    :init
    (setq-default ispell-program-name "/usr/local/bin/aspell") ; スペルチェッカーとしてaspellを利用
    :config
    (setq ispell-check-comments nil)
    (setq ispell-extra-args '("-t")) ; tex文書
    (set-face-attribute 'flyspell-duplicate nil
                       :foreground "white"
                       :background "orange" :box t :underline nil) ; 1行に2回以上出た単語をオレンジで強調
    (set-face-attribute 'flyspell-incorrect nil
                       :foreground "white"
                       :background "red" :box t :underline nil) ; 間違っている単語を赤で強調
)
```

設定はほぼispellのときと同様だが，`hook`でyatexモードのときだけ（ようはTeX文書をいじるときだけ）有効にしている．`set-face-attribute`は色の変更なので，なくても良い．

flyspellの注意点として，現在表示されている領域で単語チェックを毎回かけ直すという仕様になっており，スクロールしたときに少し反応が遅いという点が挙げられる．なので書いている時にはミスがあったらすぐわかるので便利なのだが，書き終わったあとにスクロールしてミスを調べるというような使い方には向かない．

## まとめ

emacsにおけるスペルチェックとして，ispellとflyspellの使い方を紹介した．ispellは正直あまり有り難みがないが，flyspellはオンザフライで誤字のハイライトができるので便利に使える．設定も大変ではないのでとりあえず入れておきたいパッケージだ．


## 参考

[Ispell: 対話的スペルチェック｜GNU EmacsでLaTeX文書を書く話](https://zenn.dev/maswag/books/latex-on-emacs/viewer/ispell)
[[備忘録]Emacsでスペルチェック #Emacs - Qiita](https://qiita.com/walking_with_models/items/da8eaf4afa39cf4ecd4a)
[[Home] Interactive Spell](https://www.emacswiki.org/emacs/InteractiveSpell)
[How to ignore comments in the LaTeX file with ispell (within Emacs if possible) - Stack Overflow](https://stackoverflow.com/questions/626506/how-to-ignore-comments-in-the-latex-file-with-ispell-within-emacs-if-possible)