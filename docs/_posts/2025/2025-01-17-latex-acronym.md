---
title: acronymパッケージを用いたLaTeXにおける略語管理
layout: single
date:   2025-1-16 21:00:00 +0900
toc: true
categories: coding
tags:
  - latex
header:
  teaser:
description: LaTeXのacronymパッケージを使用して略語を管理する方法を説明。初出時にフルスペルと略語を併記し、以降は略語のみを使用。略語リストの自動生成や複数形呼び出し機能もあり、長文での再表示も可能．
---

# 文書における略語の管理

---

文章中で略語を使う場合，初出の時にはフルスペルと略語を併記し，2回目からは略語のみを用いる．例えば以下のような単純な文書を考える．

> This document discusses artificial intelligence and machine learning. First, we will briefly review the concept of the machine learning. Then, artificial intelligence techniques will be explored in detail.
> 

ここで，artificial intelligenceとmachine learningは繰り返し登場する上に長いので，それぞれAI，MLという略語で置き換えたい．その場合は，以下のようにするのが正しい．

> This document discusses artificial intelligence (AI) and machine learning (ML). First, we will briefly review the concept of the ML. Then, AI techniques will be explored in detail.
> 

初回に略語が登場するときにartificial intelligence (AI)のように，フルスペルと括弧内に略語を併記しする．ただ，長い文章でこれを手動で管理していると，2回目以降の利用時にもフルスペルを利用したりというミスが発生する可能性があり良くない．そこでLaTeXでは略語を管理するためのパッケージがある．

# acronymパッケージ

---

acronymパッケージは略語管理に特化したパッケージで，　略語の定義と略語自体の使用を一元的に管理できる．他に似たことができるパッケージとしてGlossariesもあるが，こちらは名前の通り，用語集全般（略語，単語，定義など）を管理することを目的としたより複雑なパッケージであり，論文等で単に略語管理をしたいだけならオーバースペックだと思う．基本的にはデフォルトでインストールされていて追加のインストールは不要で，プリアンブルで`\usepackage{acronym}` とすることで利用できる．acronymの機能は大きく分けて二つある．

- **初回のみ完全な名称を表示**
    
    初めて略語を使用する際に完全な名称（フルスペル）と略語を併記し，その後は略語だけを表示する
    
- **略語リストの自動生成**
    
    文書中で使用した略語の一覧を自動生成して表示する
    

# acronymの使い方

---

acronymパッケージの使い方は至って簡単で，略語データをacronym環境に定義し，文中では`\ac{略語}` の形で略語を呼び出すだけで良い．詳細なドキュメントはターミナルから

```latex
texdoc acronym
```

で確認できる．ここでは個人的によく使う機能に絞って説明する．

## 基本の使い方（略語データの管理と文中での略語利用）

---

略語データはacronym環境の中に`\acro{登録名}{略語}{フルスペル}` の形で定義する．最初の引数が登録名で，あとから呼び出すときはこの登録名を使う．二つ目の引数がpdf上に表示される略語，最後の引数が単語のフルスペルである．例えば

```latex
 \acro{H2O}[$\mathrm{H_2O}$]{water}
```

とした場合，`\ac{H2O}` の初回表示はwater($\mathrm{H_2O}$)になり，2回目以降は$\mathrm{H_2O}$のみ表示される．このように，略語（やフルスペル）の中にLaTeXの命令をかけることも念頭においておこう．

acronym環境はプリアンブルではなく`document` 環境中に設定する．登録した略語を呼び出すときは`\ac{登録名}` とすると，自動的に初回のみフルスペル+略語併記になる．MWEは以下の通り．

```latex
\documentclass{a4}[article]

\usepackage[nohyperlinks]{acronym} % 略語リストを表示しない場合，nolistオプションをつける

\begin{document}

\section{Introduction}

This document discusses \ac{AI} and \ac{ML}. 
First, we will briefly review the concept of the \ac{ML}. 
Then, \ac{AI} techniques will be explored in detail.

\section{List of Acronyms}
\begin{acronym}
    \acro{AI}{AI}{Artificial Intelligence}
    \acro{ML}{ML}{Machine Learning}
\end{acronym}

\end{document}
```

この略語リストはacronymパッケージの読み込み時の設定によって，pdf上に表示/非表示できる．論文なら非表示だし，書籍や講義ノートでは表示するものもあるだろう．デフォルトでは表示するようになっており，`nolist` オプションをつけることで非表示化できる．`nohyperlinks` はハイパーリンクを設定しないオプションで，論文等では通常これを入れておいた方が良いだろう．

```latex
\usepackage[nohyperlinks,nolist]{acronym}
```

## 複数の略語呼び出し方法

---

略語を呼び出すコマンド（`\ac`）にはいくつかの派生系がある．以下によく使う一部のものをリストアップする．特に複数形を呼び出す`\acp` は非常に便利だ．

- \acp: 複数形（例: “AIs”）
- \ac*: フルスペルのみを表示（例: “Artificial Intelligence”）
- \acs: 略語のみを表示（例: “AI”）
- \acl: フルスペルのみ（略語の形容詞的使用向け）
- \acf: フルスペルと略語を明示的に併記（例: “Artificial Intelligence (AI)”）

## チャプターごとにフルスペルアウトする

---

書籍などの長い文章で，チャプターごとや章ごとに再度略語のフルスペルを書きたい場合は，`\acresetall` を文中で利用する．このマクロが使われた後では，次回`\ac`から略語を利用した時に再度フルスペルとカッコ内の略語を表示する．

```latex
\documentclass{a4}[article]

\usepackage[nohyperlinks]{acronym} % 略語リストを表示しない場合，nolistオプションをつける

\begin{document}

\section{Introduction}

This document discusses \ac{AI} and \ac{ML}. 
First, we will briefly review the concept of the \ac{ML}. 
Then, \ac{AI} techniques will be explored in detail.

\section{Introduction2}
\acresetall % 次の行の\ac{AI}と\ac{ML}はフルスペル+略語併記になる．
This document discusses \ac{AI} and \ac{ML}. 
First, we will briefly review the concept of the \ac{ML}. 
Then, \ac{AI} techniques will be explored in detail.

\section{List of Acronyms}
\begin{acronym}
    \acro{AI}{Artificial Intelligence}
    \acro{ML}{Machine Learning}
\end{acronym}

\end{document}
```

# まとめ

---

LaTeXにおける略語管理パッケージ，acronymの基本的な使い方を紹介した．論文等では頻繁に略語を用いるため，略語を自動的に管理する仕組みは必須である．acronymは非常に簡単に使える上に機能的にも優れており，まずはこのパッケージを利用して略語管理するのが良いと思う．

# 参考文献

---

[CTAN: Package acronym](https://ctan.org/pkg/acronym?lang=en)

[Glossaries](https://www.overleaf.com/learn/latex/Glossaries)
