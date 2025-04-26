---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: LaTeXでgit更新の差分をハイライトする(latexdiff-vc)
layout: single
date:   2025-3-2 21:00:00 +0900
categories: coding
tags:
 - latex
 - git
header:
  teaser:
description: LaTeXでgit更新の差分をハイライトするコマンド，latexdiff-vcの簡単な使い方の紹介．
---


LaTeX の原稿を修正したときに，修正内容の差分を分かりやすく PDF にして確認したい場合がある．これは差分を自分で確認したい場合はもちろん，共著者のレビュー時やレフェリーへの返答にこの赤字の版を含めるとわかりやすさが大きく向上するという点も大きい．追加した部分を手で`\textcolor{red}{text}` の形でハイライトしても良いのだが，自動でやってくれるコマンドに `latexdiff` および `latexdiff-vc` がある．本記事では，LaTeX 文書の変更点を簡単にハイライトする方法として `latexdiff` を紹介し、さらに `latexdiff-vc` を活用して Git との統合を行う方法を解説する．

## latexdiff について

`latexdiff` は 2 つの LaTeX ファイルを比較して変更点を自動でハイライトするツール．

### インストール

多くの LaTeX 環境には `latexdiff` が標準で含まれている．もしインストールされていない場合は以下の方法で導入できる．

```bash
sudo apt install latexdiff  # Ubuntu / Debian
brew install latexdiff       # macOS (Homebrew)

```

### 基本的な使い方

詳細なオプションは`latexdiff —help` で確認できる．基本的な使い方は比較したい二つのファイルを引数として渡すものだ．

```bash
$latexdiff old.tex new.tex > diff.tex

```

これにより、`old.tex` と `new.tex` の違いが `diff.tex` に出力される．`diff.tex` を通常通りコンパイルすると、追加された部分は青色、削除された部分は赤色の取り消し線付きで表示される．変更点の表示方法は`—type` オプションで変更できる．`UNDERLINE` ，`CTRADITIONAL`，`BOLD` などが指定できる．

実際に簡単な例でテストしてみよう．超簡単なtest1.texとtest2.texを用意する．test2.texはtest1.texに一行足したもの．

```latex
\documentclass[a4]{article}
\begin{document}
This is the test document.
\end{document}
```

```latex
\documentclass[a4]{article}
\begin{document}
This is the test document.
We added this line!!
\end{document}
```

二つのファイルの差分を

```latex
$latexdiff test1.tex test2.tex > diff.tex
```

でとってコンパイルすると，青色で追加した部分が強調される．これはわかりやすい！

{% include figure popup=true image_path="/assets/posts/2025-03-02-latexdiff-tutorial/latexdiff_simple_example.png" alt="latexdiffで更新部分が青くハイライトされる．" caption="青い部分がハイライトされたところ．typeオプションで見栄えは調整できる．" %}


## latexdiff-vcについて

vcはVersion Controlの略で，`latexdiff-vc` は `latexdiff` コマンドをラップしたもので，基本的にはlatexdiffが入っていればlatexdiff-vcも入っており追加のインストールは不要．latexdiff-vcはGit と連携して過去のコミットと現在のバージョンを比較して差分を可視化する．現実的には論文はgitで管理している場合が多く，latexdiff-vcの方がはるかに使える場面が多いだろう．

### 基本的な使い方

`-r`に何もオプションをつけない場合，このコマンドは最新のコミットとの差分を取得する．

```
latexdiff-vc --git -r main.tex
```

このコマンドは以下の動作をする．

1. `main.tex` の最新版と直前のコミットを比較
2. `diff.tex` を生成

現実的には特定のコミットとの差分を見たい場合が多い．この場合は`-r` オプションで過去のコミットIDを指定する．以下の例では1a2b3cを自身のコミットIDで置き換える．

```bash
latexdiff-vc --git -r 1a2b3c main.tex
```

`latexdiff` 自体のオプションは全く同じものが全て`latexdiff-vc` でも使えるので，例えば可視化方法を変更したければ上述の`--type` オプションが使える．latexdiff-vc特有の（latexdiffにはない）オプションで有用なものを二つ挙げておく．

- `--force` : 既存のdiffされたファイルを強制的に上書きする．デフォルトだと上書きするかわざわざ確認されて面倒臭いので．
- `--dir` : 指定したディレクトリ以下にdiffファイルを出力する．

### 構造化されたlatexファイルの処理

一般的には論文を作るときは複数のlatexファイルを用意していることが多いので，単純に一つのファイルのdiffをとってもあまり嬉しくない．そこで`--flatten` オプションを利用して`input` で読み込んでいる複数ファイルをひとまとめにできる．これはlatexpandとかと似た挙動．投稿時とは違って画像のパスを変更する必要はないため，こうして生成されたファイルをそのままコンパイルすればめでたく変更点が強調されたpdfが出来上がる．

```bash
latexdiff-vc --git --flatten -r 1a2b3c main.tex
```

さらに，生成されたtexファイルをlatexmkでコンパイルしたい場合，`--run` オプションをつけて以下のように実行する．

```bash
latexdiff-vc --git --run -c LATEX='latexmk -f' --flatten --force -r 1a2b3c main.tex
```

`--run` オプションはdiffファイルを生成した後，latexコマンドを使ってコンパイルする．`-c` オプションでコンパイルコマンドを指定でき，ここに`latexmk` を使えば一気通貫でコンパイルできる．

 **Notice:** 注意点として，bibファイルを用いて文献管理をしている場合，`latexdiff-vc`はbblファイルを利用してdiffを取るため，bblファイルがgit管理されていないとdiffを取るのに失敗する．

通常bblファイルをgit管理するのは推奨されない（.gitignoreのデフォルトには.bblが含まれる）が，簡単なworkaroundとしてレポジトリに.bblファイルを含めるようにすればこのエラーは回避できる．
 {: .notice}

## まとめ

LaTeX 文書の差分を簡単に可視化する `latexdiff` と、Git と統合した `latexdiff-vc` の使い方を概説した．これらのツールを使うことで手動で変更箇所をマークする必要がなくなり，Git の履歴を活用して簡単に差分を取得できる．

## TODO

- [ ]  github actionのワークフローで自動でdiffされたファイルを作成する．

## 参考文献

- [LaTeXでgit更新の差分をPDFにする](https://zenn.dev/ganariya/articles/latex-diff-vc)
