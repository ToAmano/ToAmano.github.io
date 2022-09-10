# LaTeX各種設定


## 環境設定
MacTeXのinstall via homebrew
```
brew install mactex
```

latexmk
http://www2.yukawa.kyoto-u.ac.jp/~koudai.sugimoto/dokuwiki/doku.php?id=latex:latexmk%E3%81%AE%E8%A8%AD%E5%AE%9A



## predifinedな変数
https://cns-guide.sfc.keio.ac.jp/2001/11/5/1.html



## 図の作り方
LaTeX内で図の作成を簡潔させる方法について．もちろんpythonなどで作成した図をincludegraphicsで取り込んでも良いが，文字のサイズなどをLaTeX文書と一緒に扱いたい場合はグラフ自体をLaTeX内で作成した方がよい．

ファイルにはいっtデータをプロットしたい場合は，pgfplotsを利用する．
[pgfplots](pgfplots.md)

### 色を変えたい場合

defaultだと基本的な色しか使えないが，中にはyellowなど蛍光色で見にくい色がある．グラフの見やすさなどの観点で違う色を使いたい場合，基本的な方法はxcolorパッケージを利用する方法．
```
# 基本の19色
\usepackage{xcolor}

# dvipsnamesオプション付きで読み込むと追加の色を使える
\usepackage[dvipsnames]{xcolor}
```
https://www.ctan.org/pkg/xcolor


### gnuplotとtikzの連携
https://qiita.com/satl/items/0c11c8808b43f806ee21

https://geniusium.hatenablog.com/entry/2018/09/16/114600


### 結晶構造のグラフを作る
VESTAソフトウェアを使うのも一案だが，asyを利用することで綺麗な図が作成できる．
https://tex.stackexchange.com/questions/141363/draw-realistic-3d-crystal-structures-diamond

[asymptote公式マニュアル](https://asymptote.sourceforge.io/asymptote.pdf)


## minipage

https://texblog.org/2007/08/01/placing-figurestables-side-by-side-minipage/


## githubでの文書管理
https://zenn.dev/junkato/articles/github-actions-to-generate-pdfs-for-pages


