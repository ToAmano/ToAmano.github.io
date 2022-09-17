# tikz/pgfplots

とりあえず参考になるurlの列挙だけ．

[公式のマニュアル](https://tikz.dev/)

## 基本的な使い方
### 
https://bombrary.github.io/blog/posts/tikz-note01/

https://mathlandscape.com/latex-color/
https://konoyonohana.blog.fc2.com/blog-entry-97.html


### フォントの大きさを変える．
https://tex.stackexchange.com/questions/107057/adjusting-font-size-with-tikz-picture


### p in pを作る．
scope環境を利用して作ることができる．

https://tex.stackexchange.com/questions/124453/connecting-subplots

### Legendを消す
https://tex.stackexchange.com/questions/14506/pgfplots-prevent-single-plot-from-being-listed-in-legend

https://tex.stackexchange.com/questions/6114/hide-tick-numbers-in-a-tikz-pgf-axis-environment
yticklabels


### 複数の図を入れる
https://tex.stackexchange.com/questions/457844/align-two-tikz-pictures-vertically-in-standalone-environment




## 色を変える
defaultだと基本的な色しか使えないが，中にはyellowなど蛍光色で見にくい色がある．グラフの見やすさなどの観点で違う色を使いたい場合，基本的な方法はxcolorパッケージを利用する方法．
```
# 基本の19色
\usepackage{xcolor}

# dvipsnamesオプション付きで読み込むと追加の色を使える
\usepackage[dvipsnames]{xcolor}
```

https://mathlandscape.com/latex-color/
https://konoyonohana.blog.fc2.com/blog-entry-97.html


### フォントの大きさを変える．
https://tex.stackexchange.com/questions/107057/adjusting-font-size-with-tikz-picture


### p in pを作る．
scope環境を利用して作ることができる．

https://tex.stackexchange.com/questions/124453/connecting-subplots



### 参考文献
#### 全体的なことに関して
[基本的なこと1](https://bombrary.github.io/blog/posts/tikz-note01/)

[gnuplotとの連携](https://aprikose.sumomo.ne.jp/madchemiker/latex/figures-with-comments/)

[pgfplotsマニュアル](http://pgfplots.sourceforge.net/pgfplotstable.pdf)

[tikz+minipage](https://atatat.hatenablog.com/entry/cloud_latex27_tikz_layout)%


## compileをスピードアップする・グラフの作成の外部化1:tikzexternalize

https://tex.stackexchange.com/questions/45/how-to-speed-up-latex-compilation-with-several-tikz-pictures
<!--
Whenever you'd use a tikzpicture environment or a \tikz macro, give your picture a suggestive name, say riemann_sum, put the TikZ code in a single standalone document (with some boilerplate such that it matches the style of your main document. For example we don't want Computer Modern in our pictures while the main document is typeset with Times or a 10pt/12pt font size clash) called riemann_sum_sag.tex and use \includepdf{riemann_sum_sag} instead. The goal is to not have a single picture being compiled when you run make without having modified a *_sag.tex file. If this is not possible because you need to \ref something inside a picture, then so be it, but try to keep that to a minimum and instead choose good captions or something.

You'll also notice that there is a rule for files matching *_input.tex. This is for splitting the project into multiple files which is of course always a good idea when doing large projects. The rule detects whether such a file has been modified, and if it has triggers a recompilation of the document. LaTeX's \includeonly feature might be a good companion to this.
-->

## compileをスピードアップする・グラフの作成の外部化2::standaloneクラス


## グラフの外部化3::externalize
https://tikz.dev/library-external

## 解決方法がわかっていないこと

- subcaptionやminipageなどの分割を行う環境との相性がよくない．

  % % 注意 !! ここの二つのグラフはそのままlualatex --jobnameコマンドを使ってもうまく図が生成されない．．．
  % % 全体的にonecolumngrid+minipageとpgfplotsの組み合わせがよくない気がする．
  % % 一旦minipageをコメントアウトしてからlualatexを実行するとまあ悪くない図が得られる．

- semilogyaxisとaxis環境で作られる左側の余白が異なる．
  
  これは別に気にしなければそのままで良いと思う．
  ```latex

  ```

  図表のサイズ(軸ラベルを含まない四角く囲まれた部分)は同じだが，左側のラベルを含む余白の大きさが異なる．semilogyaxisの方が余白が大きく，普通に並べると揃わない．とりあえずの解決策としては後からpdfを編集するか，standaloneクラス+tikzオプションを利用する．
  
  システマチックにできるのはstandaloneクラスを使う方法．これはグラフの幅はある程度同じになるように指定しておかないといけない．しかしstandaloneクラスで図を作ると余白はなくなるものの引用の番号がおかしくなってしまうという新しい問題が発生する．．． これを解決するにはstandaloneクラスの文書に直接メインファイルのbblファイルをインポートすることで一応対応できる．

  ```latex
  \input{main.bbl}
  ```
  対処療法だけどとりあえずはこれで．．．

  追記::biblatexではなくてnatbibを利用する場合，standaloneの方でnatbibのstyleを指定しないとまずい？ (revtexはnatbibなので．．．）

  ```latex
  \usepackage[numbers]{natbib}
  本文
  \input{main.bbl}
  ```


- 図表のサイズ指定
  
  [APSのマニュアル](https://journals.aps.org/prl/authors)によると横幅は8.6cmにするべき？ これがおそらく2カラム組の場合の1カラム幅に対応しているのだろう．これもstandalone環境だとうまくいっているように見える．
