# tikz/pgfplots






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

## compileをスピードアップする．

https://tex.stackexchange.com/questions/45/how-to-speed-up-latex-compilation-with-several-tikz-pictures
Whenever you'd use a tikzpicture environment or a \tikz macro, give your picture a suggestive name, say riemann_sum, put the TikZ code in a single standalone document (with some boilerplate such that it matches the style of your main document. For example we don't want Computer Modern in our pictures while the main document is typeset with Times or a 10pt/12pt font size clash) called riemann_sum_sag.tex and use \includepdf{riemann_sum_sag} instead. The goal is to not have a single picture being compiled when you run make without having modified a *_sag.tex file. If this is not possible because you need to \ref something inside a picture, then so be it, but try to keep that to a minimum and instead choose good captions or something.

You'll also notice that there is a rule for files matching *_input.tex. This is for splitting the project into multiple files which is of course always a good idea when doing large projects. The rule detects whether such a file has been modified, and if it has triggers a recompilation of the document. LaTeX's \includeonly feature might be a good companion to this.