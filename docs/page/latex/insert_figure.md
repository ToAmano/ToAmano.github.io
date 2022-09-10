
## figure環境

図の挿入にはfigure環境を使う．オプション!htbは図表を挿入する場所を表していて，latexは最初のオプションから順番に試していく．


| 位置 | 概要 | 
|--|--|
|! | 多少無理してでもfigure環境を宣言した場所に場所を確保 |
|h | figure環境宣言した場所（here）に場所を確保 |
|t | figure環境宣言したページの上部（top）に場所を確保 |
|b | figure環境宣言したページの下部（bottom）に場所を確保 |
|p | 最後のページ（p）に図の場所を確保 |    


pdfやpngなどの図を挿入する場合は`\includegraphics`命令を利用してファイルを読み込む．texファイルを読み込むなどより高度な操作も可能だがここでは触れない．figure環境には`\label`を指定することができ，また`caption`で説明書きを入れることもできる．また，通常は図表を中心に揃えたいので`\centering`命令を利用する．

```latex
\begin{figure}[!htb]
\centering
\includegraphics[width=3cm]{path/to/finename}
\label{fig:hoge}
\caption{test figure environment}
\end{figure}
```

`\includegraphics`のオプションはなくてもよく，その場合はlatexが自動で図の大きさを決めてくれる．オプションとしてはwidthに加えていくつかの設定が可能．


## [subcaption環境](https://gitlab.com/axelsommerfeldt/caption)

複数の図表を挿入したい場合はよく紹介されている`minipage`を用いてページを分割する方法に加えて，より図表の挿入に特化した高機能な`subcaption`，`subfig`などの方法がある．`subfigure`というのもあるのだが，これは古いパッケージとのこと．以下では基本的に`subcaption`を使う方法について述べる．このパッケージは`caption`パッケージにバンドルされていて，mactexを利用していればデフォルトで入っている．
<!-- 
https://texblog.org/2007/08/01/placing-figurestables-side-by-side-minipage/
-->

- (a)，(b)を消す
<!-- https://tex.stackexchange.com/questions/165508/remove-a-b-from-subfigure-numbering-but-keep-the-subfigure-caption -->
`captionsetup`コマンドで(a)や(b)を消せる．

```latex
\documentclass{article}
\usepackage{graphicx}
\usepackage{subcaption}

\begin{document}

\begin{figure}
\captionsetup[subfigure]{labelformat=empty}
\begin{subfigure}{.5\textwidth}
\centering
\includegraphics[height=3cm]{example-image-a}
\caption{Test subfigure 1}
\end{subfigure}%
\begin{subfigure}{.5\textwidth}
\centering
\includegraphics[height=3cm]{example-image-b}
\caption{Test subfigure 2}
\end{subfigure}%
\caption{Two subfigures}
\end{figure}

\end{document}
```