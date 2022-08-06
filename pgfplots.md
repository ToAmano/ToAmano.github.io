# tikz/pgfplots






### 
https://bombrary.github.io/blog/posts/tikz-note01/


### 色を変える
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