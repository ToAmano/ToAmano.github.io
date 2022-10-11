---
layout: single
title:  "siunitx パッケージ"
date:   2022-09-04 10:03:40 +0900
categories: latex
---

## siunitxパッケージの基本的な使い方

siunitxパッケージのメインとなるのは単位を記述する`\si`コマンド，単位と数字を記述する`\SI`コマンドだ．また，各種の単位に対して`\cm`のようにコマンドが定義されている．基本となるSI単位はもちろん，それ以外にもBohrなどが用意されていて基本的な用途ではあまり困ることはない．以下は簡単な例だ．


```latex
\usepackage{siunitx}
\begin{docoment}
siunitxパッケージで単位のみを書くと，例えば\si{\cm}のようになる．数字と一緒に書く場合は\SI{10}{\cm}のようにすればよい．

数式環境内でも利用可能で，
\begin{equation}
\SI{1000}{\g}=\SI{1}{\kg}
\end{equation}
のように使える．

メガ，ギガなどの接頭辞や，指数表示もおてのもの．\SI{250}{\giga\volt}とか$\SI{1.0e-10}{\giga\volt}

\end{document}

```

## siunitxパッケージでサポートされている単位の一覧．
