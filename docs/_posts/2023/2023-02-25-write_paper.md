---
layout: single
title:  "論文執筆チェックリスト基本編"
date:   2023-2-25 21:00:00 +0900
categories: latex english
---


LaTeXでの論文執筆時の注意点や，論文投稿時の流れなどをまとめておく．まず全般的な注意として，出版社のHPに著者用の注意点などをまとめたページがあるのでそこを参照して，出版社ごとのLaTeXテンプレートや慣習に従う必要がある．

## 論文原稿の執筆時に注意することリスト

### LaTeXに関する技術的な部分

単位や引用のように細かい規則があって人の手だとミスが出る可能性があるところには極力パッケージを使うようにする．

- 単位の書き方には規則がある．`siunitx`パッケージを使うとこれを自動的に守ってくれて，煩雑な規則を考えなくて済む．
- `\ref`を使ったTableやFigureの引用にもミスが出やすいので`cleveref`パッケージを使う．
- 変数や添字などで立体と斜体の違いを明確に意識する．
- ベクトルなど太字を使うべきところで使っているかを確認する．
- 複数の図表を同じfloat環境に入れる場合には`subcaption`パッケージを使う．これでFigure. 1(a)のような表記を自動で行なってくれる．ただし，投稿する際にこうした図表は一つのpdfにまとめるように言われる可能性あり．
- 図表の横幅についても出版社ごとに推奨値がある場合がある．
- 図のキャプションは図の下．表のキャプションは表の上．

### 体裁に関する部分

- 文をアラビア文字，ギリシャ文字，記号，略語で初めてはならない．文頭で数字を使うときはスペルアウトする．
- FigureかFigかは出版社によって好まれる方を採用する．ただし，文頭での省略表現はダメなので文頭ではFigureを使う．これらの違いは`cleveref`パッケージで文頭に`\Cref`，文中に`\cref`を使うことで実現できる．
- 文末ピリオドの後のスペースなどがちゃんとスペース一つになっているか．意図せず0個や2個になっているパターンがあるので，例えば`.  `（ピリオド+スペース二つ）などでTeX文書中を検索すると確認できる．
- 数式も文章として扱われる．数式末の句読点を忘れていないか．
- カッコの前には半角スペースが必要．
- 数字は慣例として一桁のものは文字で，それ以上のものはアラビア文字を利用する．

### 英語に関する部分（基本編）

- 人名がつく手法や方程式は，人名の冒頭は大文字，`'s`がつくかどうかはものによって色々な慣例がある．必ずtheがつく．
  ```markdown
  the Green's function
  the Maxwell equation
  ```

- 略称で定着していたり固有名詞化している手法


### 時制の選択

基本的には中学高校英語で習っている時制に準ずれば良いが，特に科学論文で注意すべき点について．

基本的なルールとしては

- 通常の状況や状態，行為を書いているなら現在形．
- 過去の限定された期間に起きた何かについて書いているなら過去形．
- 過去ではあるが，いつ起きたかは特定していない何かについて書いているなら現在完了．

というのがよく知られている．これを論文の各部に当てはめると大体以下のようになる．

- abstract ：現在形（背景），過去形（方法），過去形（結果），現在形（結論）
- Introduction：現在形（一般的な状況），過去形または現在完了形（先行研究）
- Methods：過去形
- Results：過去形
- Discussion：過去形（考察の結論），過去形または現在完了形（先行研究の検討），現在形（まとめと今後の研究課題など）

特に論文特有で注意すべき点

- 本文で図表に言及するときの動詞時制は現在系を使う．
  ```
  Figure 1 shows HOGEHOGE.
  FUGAGUFA are shown in Table 1.
  ```

- 研究結果について言及するときには過去形を，一般的な事柄（広く知られていることなど）については現在形を使う．

{% comment %}
We found that atenolol lowered blood pressure in the control group by 10%. （自分の研究で見つけたことなので過去形）
Cardioselective beta-blockers effectively lower blood pressure in most patients. （一般的な状態なので現在形）
{% endcomment %}


<!-- アカデミックヤクザにキレられないためのLaTeX論文執筆メソッド https://qiita.com/suigin/items/10960e516f2d44f6b6de -->

<!-- 論文を書く上での規則 https://qiita.com/Ishotihadus/items/d6088aec3632545833e8 -->

## 論文執筆完了後の流れ

LaTeXで文書を完成させたら，いよいよ投稿することになる．投稿時やその後の流れについて簡単にまとめる．

- 論文を出版社に投稿（arxivとどちらが先かは分野などによって異なる）
  - 投稿時にはLaTeXファイルを一つにまとめる必要がある．
  - 投稿内容を編集者にアピールするカバーレターを作成する必要がある．
  - 出版社の方でLaTeXファイルがコンパイルされるまで調整する必要がある．
- 原稿がレフェリーに送られ，数週間~1ヶ月でレフェリーレポートが送られてくる．これに対する返事をまとめて，論文を再投稿
  - レフェリーの質問コメントに対する返事をまとめたAuthor Responseを作成する必要がある．
  - レフェリーの質問コメントを原稿に反映させる．
  - 反映させた点をリスト化しておくと親切．
- 原稿がアクセプトされる（Congratulation! ）
- アクセプト後の諸々の処理
  - 1, 出版社側から出版原稿(プルーフ)のチェック依頼が後日来る
  - 2, 著者側がチェックして修正を依頼する
  - 3, 1--2を修正事項なくなるまで行い著者側がokを出す．プルーフ改訂はおおむね数日～1週間で届く．

各ステップごとに（主にLaTeX関連で）注意すべき点をまとめる．

### LaTeXファイルを一つにまとめる．

通常執筆時には，原稿を分割して編集していると思う．例えばイントロはintroduction.tex，結果はresults.texなどとした上で，メインのTeXファイルから分割したファイルを読み込んでいる．実際に投稿する際にはこれら分割されたファイルを一つにまとめないといけない．これを手でやったら大変なので，いくつかの簡単なツールがCTANにある．`latexpand`，`flatex`，`flatten`，`texdirflatten`など．．． いずれも微妙に挙動が違うらしいので，自分のスタイルにあったものを使うと良いと思う．とりあえずまとめたファイルだけ欲しいという場合には`latexpand`で良い．

```latex
latexpand -o submit.tex input.tex
```

ただし，`latexpand`は図表をまとめたディレクトリやpathの編集は行ってくれないので，そこはマニュアルでやる必要がある．


また，投稿時にはディレクトリの構造がフラットになっている必要がある．編集時には例えば図は`figure/`ディレクトリ，表は`table/`ディレクトリなどに置いておくことが多いが，投稿時には全てメインファイルと同じディレクトリにないといけない．

```
--- main.tex
 |
 |- figure
 |    |- fig1.pdf
 |	  |- fig2.pdf
 |- table
	  |- table1.tex
   	  |- table2.tex
```

これらのpathは文書中の`includegraphics`や`input`で明示されていることが多いが，以下のようにプリアンブルでpathを追加できるので活用したい．

```
{% raw %}
 % path for includegraphics
 \graphicspath{{figure/}{table/}}

 % path for input
  \makeatletter
  \providecommand*{\input@path}{}
  \g@addto@macro\input@path{{figure/}{table/}}% append
  \makeatother
{% endraw %}
```

こうすれば，元々

```
\includegraphics{figure/fig1.pdf}
```

としていたものが

```
\includegraphics{fig1.pdf}
```

で済むので，編集中も投稿時も後者のように書いておけばpathの心配をしなくてすむ．

（やることリスト）：inputstandaloneの場合にはどうすれば良いだろうか？


## cover letter 

論文投稿時には，同時に論文の内容をまとめ，出版社に出版の価値ある原稿であることをアピールするカバーレター（大体A4で1枚）を添付できる．これはわざわざLaTeXで書く必要もないが，LaTeXで書くこともできるのでここではそれについて簡単に．

カバーレターには決まった書式はないのでそのままでも良いが，エディターが見やすい形式にしておくことで多少は良い印象を与えられるかもしれない（？）．LaTeXにはcoverletter用のテンプレートやパッケージもいくつか存在する．個人的に便利で使っているのがmoderncvというパッケージで，これは本来job application用のテンプレートだが投稿用にも転用できる．

そのほかにもいくつかのサンプルがoverleafの[ページ](https://www.overleaf.com/gallery/tagged/cover-letter)にあるので，参考にすると良いと思う．

[参考？](https://www.thinkscience.co.jp/pdf/Ten_tips_for_writing_an_effective_cover_letter_Japanese.pdf)
[参考?](https://authorservices.taylorandfrancis.com/publishing-your-research/making-your-submission/writing-a-journal-article-cover-letter/)


### 出版社のサーバーでコンパイルがうまくいかない

手元の環境ではうまくコンパイルできるTeXファイルが，投稿時に出版社のサーバーでうまく処理できないという場合がある．特殊なパッケージを使っていてそれが向こうでインストールされていなかったり，手元と向こうでパッケージのバージョンが違ったりというのがよくあるパターン．従って，この手の煩わしさを無くしたければ極力有名どころのパッケージを使い，あまり凝ったことはしないのが消極的だが確実な方法だ．

また，pgfを筆頭に，編集時には必要でも最後の投稿時には必要ないパッケージも存在する．これらはコメントアウトしておくと無用なトラブルを避けられて良い．

### レフェリーレポートへの返事

再投稿時にはレフェリーレポートに対する返信もファイルにまとめておく必要がある．カバーレターとは違い，こちらには新たなデータなどを入れる場合があったりして，ワードで書くよりLaTeXで書く蓋然性が高い．こちらも可読性を上げるためにはある程度フォーマットに従って書くのがよく，いくつかのテンプレートやパッケージがある．同じく[overleafのページ](https://www.overleaf.com/gallery/tagged/letter)から色々探してみると良い．


{% comment %}
## APS submit前に確認するページ

https://journals.aps.org/prb/authors/tips-authors-physical-review-physical-review-letters
https://journals.aps.org/authors/examples-errors-references
https://journals.aps.org/prb/authors/editorial-policies-practices
{% endcomment %}


## 参考文献

[分割TeX fileを単一TeX fileに統合する](https://zenn.dev/ultimatile/articles/b3fbd4ec65373d)
[Replace \input{fileX} by the content of fileX automatically](https://tex.stackexchange.com/questions/21838/replace-inputfilex-by-the-content-of-filex-automatically)
