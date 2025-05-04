---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: 【latexdiff-vc】LaTeXでgit更新の差分をハイライトする
layout: single
date:   2025-3-2 21:00:00 +0900
categories: coding
tags:
 - latex
 - git
toc: true
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

## github actionで自動的にlatexdiff-vcを実行する

---

いちいち`latexdiff-vc` を実行するのは面倒くさいため，github actionでプッシュ/タグづけされた時に自動的にdiffをとったpdfを生成，リリースに追加するようにした．このテンプレートは

[paper_template/.github/workflows/latex-build.yml at master · ToAmano/paper_template](https://github.com/ToAmano/paper_template/blob/master/.github/workflows/latex-build.yml)

においてある．

まず，トリガーはタグが追加された時とした．プッシュのたびに実行するとちょっと頻度が多いかなということと，セマンティックバージョニングがむずかしいと感じたため．

```yaml
on:
  push:
    tags:
      - '*'  # Trigger on all tag pushes
```

また，最初に以下のおまじないを追加する．permissionsはReleaseにファイルをアップロードするのに必要だった．原稿ディレクトリをMANUSCRIPT_DIRで指定する．

```yaml
permissions:
  contents: write  # Releaseへのアップロードに必要

env:
  MANUSCRIPT_DIR: manuscript  # 原稿ディレクトリを指定
```

ジョブとしては以下の二つを用意した．

1. **build-main-pdf**
    
    ➔ LaTeXドキュメントをビルドし，生成されたPDFをGitHub Releaseにアップロードする．
    
2. **build-diff-pdf**
    
    ➔ 直前のタグとの変更差分を取ったdiff PDFを作成し，それもGitHub Releaseにアップロードする．
    

環境構築にはすでにtexliveのイメージがあるのでこれを拝借した．いちいちビルドしているとかなり時間がかかるので，コンテナを利用して高速化する恩恵が大きいと判断した．

```yaml
jobs:
  build-main-pdf:
    runs-on: ubuntu-latest
    container: danteev/texlive:latest
```

メインの処理ではリポジトリをチェックアウトしてLaTeXファイル (main.tex) をビルド，Releaseへアップロードする．デフォルトでは直近のコミットしか取得しないが，これだとlatexdiff-vcが動かないため`fetch-depth` を0に指定して全てのコミット履歴を取得する．

```yaml
    steps:
    - name: Checkout repository
      uses: actions/checkout@v4
      with:
        fetch-depth: 0  # 差分比較のため全履歴取得

    - name: Compile LaTeX document and name pdf to tag name
      working-directory: ${{ env.MANUSCRIPT_DIR }}
      run: |
        latexmk -jobname=${{ github.ref_name }} -pdf main.tex

    - name: Upload PDF to Release
      uses: softprops/action-gh-release@v2
      with:
        files: |
          ${{ env.MANUSCRIPT_DIR }}/${{ github.ref_name }}.pdf
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

二つ目のJobでlatexdiff-vcを利用して差分を表示するpdfを生成する．一つ目のジョブでレポジトリをチェックアウトしているので，そちらが完了してから実行するように指定してある．

```yaml
  build-diff-pdf:
    runs-on: ubuntu-latest
    container: danteev/texlive:latest
    needs: build-main-pdf
```

こちらのJobでは前回のタグ付けが行われたコミットIDを取得してdiffをとるため，タグ取得->コミットID取得の順でジョブを実行する．初回のみ前回のタグがないため，この場合には空文字を出力するようにして，以降のJobをスキップするよう`if: steps.prev_tag.outputs.prev_tag != ''` の指定を入れてある．

```yaml
    steps:
    - name: Get previous tag
      id: prev_tag
      run: |
        PREV_TAG=$(git describe --tags --abbrev=0 HEAD^ 2>/dev/null || echo "")
        echo "Previous tag is $PREV_TAG"
        echo "prev_tag=$PREV_TAG" >> $GITHUB_OUTPUT
    - name: Get commit ID of previous tag
      if: steps.prev_tag.outputs.prev_tag != ''
      id: prev_commit
      run: |
        PREV_COMMIT=$(git rev-list -n 1 ${{ steps.prev_tag.outputs.prev_tag }})
        echo "Previous commit ID is $PREV_COMMIT"
        echo "prev_commit=$PREV_COMMIT" >> $GITHUB_OUTPUT   
```

無事コミットIDが生成できたらいよいよ`latexdiff-vc`を実行する．生成されるファイル名が`main-diff${COMMID_ID}.pdf` の形になったためこれをリネームして，最終的にReleaseに追加する．`latexdiff-vc` は失敗することもあり得るので，ファイルが生成されない場合にはスキップしてエラーを発生させないようにしている．

```yaml
    - name: Run latexdiff-vc
      working-directory: ${{ env.MANUSCRIPT_DIR }}
      if: steps.prev_tag.outputs.prev_tag != ''
      run: |
        latexdiff-vc --git --run -c LATEX='latexmk -f' --flatten --force -r ${{ steps.prev_commit.outputs.prev_commit }}  main.tex
        
    - name: Rename diff PDF to tag name
      working-directory: ${{ env.MANUSCRIPT_DIR }}
      if: steps.prev_tag.outputs.prev_tag != ''
      run: |
        DIFF_PDF="main-diff${{ steps.prev_commit.outputs.prev_commit }}.pdf"
        TARGET_PDF="${{ github.ref_name }}-diff.pdf"
        if [ -f $DIFF_PDF ]; then
          mv $DIFF_PDF $TARGET_PDF
        else
          echo "No diff PDF found. Skipping rename."
        fi     
    - name: Upload diff PDF to Release
      uses: softprops/action-gh-release@v2
      if: steps.prev_tag.outputs.prev_tag != ''
      with:
        files: |
          ${{ env.MANUSCRIPT_DIR }}/${{ github.ref_name }}-diff.pdf
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      continue-on-error: true       
```


## まとめ

LaTeX 文書の差分を簡単に可視化する `latexdiff` と、Git と統合した `latexdiff-vc` の使い方を概説した．これらのツールを使うことで手動で変更箇所をマークする必要がなくなり，Git の履歴を活用して簡単に差分を取得できる．


## 参考文献

- [LaTeXでgit更新の差分をPDFにする](https://zenn.dev/ganariya/articles/latex-diff-vc)
