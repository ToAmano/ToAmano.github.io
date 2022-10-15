# init.elの設定について

init.elの設定についてはこのページに別途まとめる．



## pathを通す．

自動でサブディレクトリまでpathに追加してくれる以下のような関数を利用するとよい．

```common_lisp
   (defun add-to-load-path (&rest paths)
   (let (path)
   (dolist (path paths paths)
     (let ((default-directory (expand-file-name (concat user-emacs-directory path))))
     (add-to-list 'load-path default-directory)
     (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
   (normal-top-level-add-subdirs-to-load-path))))))
```

## パッケージ管理システム

```elisp
 (require 'package)
 (add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
 (add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/") t)
 (add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/") t)
 ;;(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)
 ;;(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/") t)

 (package-initialize)
 (unless package-archive-contents (package-refresh-contents))
 (dolist (pkg my-favorite-package-list)
   (unless (package-installed-p pkg)
     (package-install pkg)))
```

## バックアップファイルの保存場所設定

デフォルトだと`~`のついたファイルが大量にできて鬱陶しいので一箇所にまとめておく．

```elisp
;; http://yohshiy.blog.fc2.com/blog-entry-319.html
(setq backup-directory-alist '((".*" . "~/.emacs.d/.ehist")))
```

## 括弧の自動挿入

```elisp
 (electric-pair-mode 1)
```

## 対応するカッコのハイライト

TeX文書の数式などでの括弧のつけ忘れなどに気付きやすいように．

```elisp
 (show-paren-mode t)
=(setq show-paren-style 'parenthesis) ;;ハイライトのスタイル，これは対応する括弧のみハイライト
;;他に，expression（括弧で囲まれたところのハイライト）などがある
```


## 利用しているパッケージ


### magit(git用)

https://qiita.com/maueki/items/70dbf62d8bd2ee348274



### [スペルチェッカー](https://texwiki.texjp.org/?Aspell)

基本的にTeX文書を扱うので，英語のスペルチェッカーがあると便利．Emacsでは外部コマンド`aspell`を利用したスペルチェッカー`flycheck`が利用可能である．VScodeでよく見るスペルチェッカーのようにリアルタイムで間違っている部分をハイライト表示してくれる．`aspell`と`flycheck`両方のインストールと設定が必要．

```bash
# aspellのinstall
brew install aspell

# 辞書は
```
<!-- 
ユーザ辞書には2種類あります． ~/.aspell.lang.pws は標準辞書にはない単語を追加する辞書で， ~/.aspell.lang.prepl は特定のミススペルに対して修正置換対象を指定する辞書です．
.aspell.lang.pws はテキストファイルです．
* 1行目には，personal_ws-1.1 lang num [encoding]と書きます． lang は英語なら en，num は単語数ですが単なる目安です． 0でOKです．
* 2行目からは，登録単語を書きます． 1単語1行です．
日本人の人名などを人名辞典から引っ張ってきて片っ端から入れるのも良いでしょう．
.aspell.lang.prepl もテキストファイルです．1行目には
personal_repl-1.1 lang num [encoding]
と書きます．lang と num は上と同じです．2行目からは修正対象と修正語をペアで書きます．
misspelled_word correction
ここで設定された修正語は，スペルチェックの際に第一候補として表示されます．
-->

ついでelispの設定を以下のようにする．

```elisp
flychekerの設定

```