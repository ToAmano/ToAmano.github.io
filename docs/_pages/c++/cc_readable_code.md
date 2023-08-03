---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: C/C++ 読みやすいコードを書く
layout: single
description: The top-page of Python.
---

## 命名規則

| スネークケース | snake_case |
| キャメルケース | camelCase  |
| パスカルケース | PascalCase |

c++では標準ライブラリがスネークケースなので合わせた方がよい．

## コード全体で守った方が良いこと

- DRY原則 ( Do not Repeat Yourself)
  同じ処理を何回も書かないようにする．もし似た処理を何回も使うなら，その処理は関数に切り出せないか考える．

- 単一責任法則（）
  役割をクラスでどれぐらいの粒度で分割するのかについての決めごとです。
  設計の考え方である、関心の分離に深く関わってきますので重要です。
  単一責任法則とはずばり、「ある一つのクラスが変更される理由は一つだけにしろ」ということを言っています。
  その結果、クラス一つが持つ責任は一つだけになります。
  これにより、クラスは適切に分割されるので可読性が上がり、さらに変更箇所が一か所に集中するので保守性も良くなるでしょう。
  さて、「ある一つのクラスが変更される理由は一つだけにしろ」というのが単一責任法則なのですが、この説明は難しいので言い換えましょう。
  クラスはただ一つの意味のあるまとまりのデータ群を持っていて、そのデータ群を管理する責任だけを持つ。
  ここで注意すべきは、クラスが持つデータ群の管理責任を他のクラスに分散しないことです。
  （分散はだめだが、譲渡は問題ない。この譲渡する考え方をムーブセマンティクスという。C++にもムーブコンストラクタという機能でサポートされている）
  さらに管理責任で最も大事なのは書き換え責任です。
  できるだけイミュータブルにしろの項目のget_name関数で外部からnameが書き換えられるのを防止したのも、書き換え責任を分散しないためです。
  （書き換え責任という点において、HaskellやRust等は究極の単一責任法則を実現できるでしょう。具体的に、Haskellでは副作用を分離し、値はそもそも書き換えられない。Rustでは所有権を持つものだけが値を書き換えられる。でそれぞれ書き換え責任を言語レベルで制御しています）

## C++特有

- `const`修飾子を使う
- `override`修飾子を使う
- コンストラクタでの変数の初期化に際しては，メンバ初期化子リストを使うことで高速化できる

## 高速化のtips

- ベクトルにforループでアクセスするとき，ベクトルのサイズを一度だけ評価する．
  ```cc
  // これは良くない
  for (int i=0; i<vec.size(); i++) 
  // これは良い
  for (int i=0, n=vec.size(); i<n; i++) 
  ```

## ファイル分割

- 基本的にはヘッダーファイル(.hpp)とソースファイル(.cpp)を分割し，ソースファイル側からヘッダーファイルを`include`するようにする．
- (できれば)ファイルは1クラスに1つとして，クラス名とファイル名を一致させる．複数人でやる時はこれくらい分割してあると他人がコードを読みやすい．
- 同じヘッダファイルの複数読み込みによるredefinitionエラーを避けるために，インクルードガードと呼ばれるテクニックがある．その一つは以下のようにヘッダファイルに`ifndef`マクロを使う方法．
  ```
  #ifndef TEST
  #define TEST
  中身
  #endif //!TEST
  ```


## 参考文献

[C++におけるおすすめ命名規則](https://qiita.com/rinse_/items/a11ec988e7378642e8e2)

[C++ コーディング指針](https://qiita.com/shirakawa4756/items/7430f447883a74831bf9)

[同じクラスの再定義を防止する - C++ プログラミング](https://ez-net.jp/article/87/hA5CKttD/C622OUxjj--t/)

[数値計算屋にはFortranは捨てなくても良いけどソフトウェアエンジニアリングを学んでほしい](https://hpcmemo.hatenablog.com/entry/2019/03/22/024916)


<!--
c++ベクトルまとめ
https://qiita.com/ysuzuki19/items/df872d91c9c89cc31aee

C++ 値渡し、ポインタ渡し、参照渡しを使い分けよう
https://qiita.com/agate-pris/items/05948b7d33f3e88b8967

https://qiita.com/elipmoc101/items/01003c82dbd2e464a071

https://hpcmemo.hatenablog.com/entry/2019/03/22/024916

https://docs.sakai-sc.co.jp/article/software-engineering/separation-of-concerns.html

https://docs.sakai-sc.co.jp/article/software-engineering/loose-coupling-in-source-code.html
-->
