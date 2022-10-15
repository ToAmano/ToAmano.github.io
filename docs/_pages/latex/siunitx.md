---
layout: single
title:  "siunitx パッケージ"
date:   2022-09-04 10:03:40 +0900
categories: latex
---

## siunitxパッケージの基本的な使い方

<!-- https://uec.medit.link/latex/units.html -->
siunitxパッケージのメインとなるのは単位を記述する`\si`コマンド，単位と数字を記述する`\SI`コマンドだ．また，各種の単位に対して`\cm`のようにコマンドが定義されている．基本となるSI単位はもちろん，それ以外にもBohrなどが用意されていて基本的な用途ではあまり困ることはない．以下は簡単な例だ．


```latex
\usepackage{siunitx}
\begin{docoment}
siunitxパッケージで単位のみを書くと，例えば\si{\cm}のようにsi{単位}と指定する．数字と一緒に書く場合は\SI{10}{\cm}のようにSI{数字}{単位}とすればよい．

数式環境内でも利用可能で，
\begin{equation}
\SI{1000}{\g}=\SI{1}{\kg}
\end{equation}
のように使える．

メガ，ギガなどの接頭辞や，指数表示もおてのもの．\SI{250}{\giga\volt}とか$\SI{1.0e-10}{\giga\volt}

\end{document}

```

## siunitxパッケージでサポートされている単位の一覧



## pgfplotsと一緒に使う

本来意図された使い方ではないかもしれないが，pgfplotsの図の軸ラベルにsiunitxを使って単位を入れる方法を考える．例えば横軸に`Length (cm)`と入れたい場合，Lengthはローマン体にしないといけない．また，Lengthと(cm)の間にはスペースが必要．`\SI`の数字部分に文字を入れたい場合，オプションで`parse-numbers = false`とする必要がある．というわけで単純な例は以下のようなものになる，()を手で打っているのが気持ちわるいが，どうも単位を書く際に本来はカッコを使うのは推奨されていないらしく，siunitxパッケージでもこういう使い方は想定されていないようだ．

```latex
\SI[parse-numbers = false]{\mathrm{Length}}{(\cm)}
```

これをpgfplots内で使う場合，原因はわからないがコマンド全体を`{}`で囲まないとエラーで動かなかった．

```latex
\begin{document}
\begin{tikzpicture}
\begin{axis}[
 xlabel= {\SI[parse-numbers = false]{\mathrm{Length}}{(\cm)}}
]
\end{axis}
\end{tikzpicture}
\end{document}
```





<!-- https://tex.stackexchange.com/questions/30817/how-to-use-siunitx-with-non-numerical-values -->

