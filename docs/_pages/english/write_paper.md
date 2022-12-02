---
layout: single
title:  "論文執筆チェックリスト 基本編"
date:   2022-09-04 10:03:40 +0900
categories: latex english
---


## LaTeXに関する技術的な部分

単位や引用のように細かい規則があって人の手だとミスが出る可能性があるところには極力パッケージを使うようにする．

- 単位の書き方には規則がある．`siunitx`パッケージを使うとこれを自動的に守ってくれて，煩雑な規則を考えなくて済む．
- `\ref`を使ったTableやFigureの引用にもミスが出やすいので`cleveref`パッケージを使う．
- 変数や添字などで立体と斜体の違いを明確に意識する．
- ベクトルなど太字を使うべきところで使っているかを確認する．
- 複数の図表を同じfloat環境に入れる場合には`subcaption`パッケージを使う．これでFigure. 1(a)のような表記を自動で行なってくれる．


## 体裁に関する部分

- 文をアラビア文字，ギリシャ文字，記号，略語で初めてはならない．文頭で数字を使うときはスペルアウトする．
- FigureかFigかは出版社によって好まれる方を採用する．ただし，文頭での省略表現はダメなので文頭ではFigureを使う．これらの違いは`cleveref`パッケージで文頭に`\Cref`，文中に`\cref`を使うことで実現できる．
- 文末ピリオドの後のスペースなどがちゃんとスペース一つになっているか．意図せず0個や2個になっているパターンがあるので，例えば`.  `などでTeX文書中を検索すると確認できる．
- 数式も文章として扱われる．数式末の句読点を忘れていないか．
- カッコの前には半角スペースが必要．
- 数字は慣例として一桁のものは文字で，それ以上のものはアラビア文字を利用する．

## 英語に関する部分（基本編）

- 人名がつく手法や方程式は，人名の冒頭は大文字，`'s`がつくかどうかはものによって色々な慣例がある．必ずtheがつく．
  ```markdown
  the Green's function
  the Maxwell equation
  ```

- 略称で定着していたり固有名詞化している手法



### 時制の選択
基本的には中学高校英語で習っている時制に準ずれば良いが，特に科学論文で注意すべき点について．

- 通常の状況や状態、行為を書いているのか。もしそうなら現在形を使う。
- 過去の限定された期間に起きた何かについて書いているのか。もしそうなら過去形を使う。
- 過去ではあるが、いつ起きたかは特定していない何かについて書いているのか。もしそうなら現在完了形を使う。
それぞれの時制がどのような場合に使われるかを注意深く考えるなら、論文の各部でふつうは次のような時制を使うことに気づくはずです。

- はじめに (Introduction)：現在形（一般的な状況）、過去形または現在完了形（先行研究）
- 試料と方法 (Materials and Methods)：過去形
- 結果 (Results)：過去形
- 考察 (Discussion)：過去形（考察の結論）、過去形または現在完了形（先行研究の検討）、現在形（まとめと今後の研究課題など）
これらすべての要約であるアブストラクトでは、さまざまな時制が混在することになります。

- アブストラクト ：現在形（背景）、過去形（試料と方法）、過去形（結果）、現在形（結論）


6b.2) 本文で図表に言及するときの動詞時制
図表に言及するときは現在形を使います。それは、紙のうえで図がつねに表示されているからです（つまり、通常の状態について述べることになります）．

Figure 1 shows a photograph of the device.
Patient data are shown in Table 1.

6b.3) 研究結果と一般的状態の動詞時制
研究結果や一般的状態を論じるとき、どの動詞時制を使うか決めにくいことがあります。この場合のルールは次のとおりです。

研究結果には過去形を使ってください。
一般的な状態や知識には現在形を使ってください。
たとえば、β遮断薬のアテノールを研究した場合はこのように書きます。

We found that atenolol lowered blood pressure in the control group by 10%. （自分の研究で見つけたことなので過去形）
しかし、β遮断薬に関する一般的なことがらは次のように書きます。

Cardioselective beta-blockers effectively lower blood pressure in most patients. （一般的な状態なので現在形）


<!-- アカデミックヤクザにキレられないためのLaTeX論文執筆メソッド https://qiita.com/suigin/items/10960e516f2d44f6b6de -->

<!-- 論文を書く上での規則 https://qiita.com/Ishotihadus/items/d6088aec3632545833e8 -->

## cover letter 

[参考？](https://www.thinkscience.co.jp/pdf/Ten_tips_for_writing_an_effective_cover_letter_Japanese.pdf)
[参考?](https://authorservices.taylorandfrancis.com/publishing-your-research/making-your-submission/writing-a-journal-article-cover-letter/)


## APS submit前に確認するページ

https://journals.aps.org/prb/authors/tips-authors-physical-review-physical-review-letters

https://journals.aps.org/authors/examples-errors-references

https://journals.aps.org/prb/authors/editorial-policies-practices

