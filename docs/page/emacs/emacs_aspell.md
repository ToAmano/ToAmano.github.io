---
layout: default
title:  "emacsでの英単語チェッカー"
date:   2022-09-04 10:03:40 +0900
categories: emacs english
---

emacsでlatex文書を書くときの英単語のスペルミスを減らすために英単語チェッカーを入れる．英単語チェッカーとしてシステムに`aspell`をインストールし，emacsで`ispell`と`flycspell`モードを利用する．

## aspellのインストール

まずはhomebrewからシステムにaspellをインストールする．

```bash
brew install aspell
```

## ispellをemacsで利用

ややこしいが，aspellをemacsで利用するためのパッケージが`ispell`である[^1]．aspellをemacsから利用するには以下のような設定を`init.el`に書き込む[^2][^3]．

```latex:init.el
;; aspellにパスを通す
;; https://texwiki.texjp.org/?Aspell
(add-to-list 'load-path "/opt/local/bin/")
(add-to-list 'load-path "/opt/homebrew/bin/")

;; スペルチェックにaspellを利用する
(setq-default ispell-program-name "aspell")

;; 日英混文の処理
(use-package aspell
  :ensure t
  :config
  (setq ispell-local-dictionary "en_US")
  (add-to-list 'ispell-skip-region-alist '("[^\000-\377]+"))
)
```

利用方法としては`M-x ispell`を覚えておけばよい．

## flyspellの利用

flyspellはエンジンとしてaspellを利用してemacsで誤った単語をハイライトしてくれる．したがって前項でのaspellの設定を終わらせていないと動かない．基本的にはデフォルトで入っているので`init.el`ファイルで設定を書くだけでよい．`hook`でyatex-modeが起動した時に自動で有効にする設定にしてある．config以下は個人的な色の設定なのでなくても良い．

```latex
(use-package flyspell
    :ensure t
    :hook (yatex-mode . flyspell-mode)
    :config
    (set-face-attribute 'flyspell-duplicate nil
                       :foreground "white"
                       :background "orange" :box t :underline nil)
    (set-face-attribute 'flyspell-incorrect nil
                       :foreground "white"
                       :background "red" :box t :underline nil)
)
```

flyspellはispellと違って文書を書いている時にリアルタイムでハイライトしてくれるので私のような適当な人間にはありがたい．

## aspellに辞書を追加

<!--
https://stakizawa.hatenablog.com/entry/20080122/t1
-->


[^1]: https://texwiki.texjp.org/?Aspell
[^2]: https://futurismo.biz/archives/5995/
[^3]: https://zenn.dev/maswag/books/latex-on-emacs/viewer/ispell
