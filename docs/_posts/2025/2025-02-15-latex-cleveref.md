---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: cleverefによる図表の管理(latex)
layout: single
date:   2025-2-15 21:00:00 +0900
categories: coding
tags:
 - latex
header:
  teaser: 
description: LaTeXにおける便利な参照管理パッケージcleverefの使い方
---


## LaTeXにおける図/表/式等の引用

---

LaTeXでは，図・表・数式・章などの要素に固有のラベル（`\label`）をうち，後から参照する際は`\ref` コマンドを利用すると図表番号を自動で管理できる．ただし`\ref` コマンドは番号だけを出力するため，図，表，式に合わせて「Figure \ref{a}」，「Table \ref{b}」，「Equation \ref{c}」のように接頭語をつけて参照する必要がある．以下に簡単な例を示す．

```latex
\documentclass{article}
\usepackage{graphicx}
\usepackage{amsmath}
\usepackage[colorlinks=true,citecolor=blue,linkcolor=blue,urlcolor=blue]{hyperref}

\begin{document}

\section{Introduction}\label{sec:example}
Figure. \ref{fig:example} is the example figure. In Table \ref{tab:example}, we can see that A is bigger than B.

\begin{figure}[h]
    \centering
    \includegraphics[width=0.5\textwidth]{example.png}
    \caption{An example figure.}
    \label{fig:example}
\end{figure}

\begin{table}[h]
    \centering
    \caption{An example table.}
    \label{tab:example}
    \begin{tabular}{c|c}
        A & B \
        \hline
        1 & 2 \
    \end{tabular}
\end{table}

As shown in FIg. \ref{fig:example} and Table \ref{tab:example}, cleveref simplifies referencing.

\begin{align}\label{eq:example1}
  y = x^2.
\end{align}
\begin{align}\label{eq:example2}
  z = y^2.
 \end{align}

From Eq. (\ref{eq:example1}) and (\ref{eq:example2}}, we have $z=x^4$.

\section{Conclusion}
We can reference \cref{sec:example}

\end{document}

```

ただしこの接頭語の扱いは，雑誌によっては「Figure」などとフルスペルを用いるのは文頭の場合だけで文中では「Fig.」と省略形を使うケースもあるなど統一されていない．論文を書き始めた段階では最終的な投稿先が決まっていない場合もあるので，この接頭語を自動で管理できると嬉しい．このような要件を満たしてくれるのがcleverefパッケージだ．cleverefパッケージは参照先のタイプ（表，図，式etc）を自動識別して，適切な接頭語付きで出力する．例えば上の例は以下のように書き換えられる．

```latex
\documentclass{a4}

\usepackage{cleeref} % パッケージ読み込み
\begin{document}

\end{document}
```

## cleverefの特徴

---

cleverefは上述の接頭辞の自動判別の他，複数参照もよしなにやってくれるなどの機能をサポートする．

1. 参照タイプを自動判別
    
    表、図、節、数式などを区別し、適切な接頭辞（"Table", "Figure", "Section" など）を自動で付与する．
    
2. 複数参照の記述
    
    複数の参照を1つのコマンドで`\cref{Fig1,Fig2}`のように記述し、「Figures 1 and 2」のように最適な複数参照の形で出力する．特に数式はまとめて複数同時参照することが多いので重宝する．
    
3. 接頭辞のカスタマイズ
    
    雑誌ごとに接頭辞が違う場合や日本語文書を使いたい場合，自分の好きなように接頭辞をプリアンブルで指定できる．（Eg. 「表1」「図2」）
    
4. **パッケージの互換性**
    
    hyperrefと同時に利用できる．
    

## 基本的な使い方

---

### インストールと設定

cleverefは多くのLaTeX環境でデフォルトインストールされているはず．呼び出しはプリアンブルで以下を追加する．

```latex
\usepackage{cleveref}

```

### マニュアル確認

LaTeXパッケージのマニュアルは`texdoc` コマンドで確認できる．詳細はこちらを確認すること．

```bash
$texdoc cleveref
```

### 基本的な参照

cleverefでは`\cref` コマンド(文頭では`\Cref`)を利用して参照先を指定する．以下の例では図，表，数式，章を引用する．デフォルトでは数式番号にだけカッコがつくよく見る形式になる．パッケージを読み込む順番には注意が必要で，amsmathやhyperrefの後に読み込まないとエラーになる．

```latex
\documentclass{article}
\usepackage{graphicx}
\usepackage{amsmath}
\usepackage[colorlinks=true,citecolor=blue,linkcolor=blue,urlcolor=blue]{hyperref}
\usepackage{cleveref} % cleveref must be loaded after amsmath&hyperref

\begin{document}

\section{Introduction}\label{sec:example}
\Cref{fig:example} is the example figure. In \cref{tab:example}, we can see that A is bigger than B.

\begin{figure}[h]
    \centering
    \includegraphics[width=0.5\textwidth]{example.png}
    \caption{An example figure.}
    \label{fig:example}
\end{figure}

\begin{table}[h]
    \centering
    \caption{An example table.}
    \label{tab:example}
    \begin{tabular}{c|c}
        A & B \
        \hline
        1 & 2 \
    \end{tabular}
\end{table}

As shown in \cref{fig:example,tab:example}, cleveref simplifies referencing.

\begin{align}\label{eq:example1}
  y = x^2.
\end{align}
\begin{align}\label{eq:example2}
  z = y^2.
 \end{align}

From \Cref{eq:example1, eq:example2}, we have $z=x^4$.

\section{Conclusion}
We can reference \cref{sec:example}

\end{document}

```

**結果例**：
cleveref-sample.png
{% include figure popup=true image_path="/assets/posts/2025-02-15-latex-cleveref/cleveref-sample.png" alt="cleverefを利用したMWEの出力" caption="" %}

上の例でわかるように，cleverefは接頭辞の自動設定だけでなく，複数参照時もよしなに接頭辞や順番を修正してくれる．使い方は`\cref` の中に複数のラベルをカンマ区切りで指定するだけ．ただし，カンマの後にスペースがあると参照に失敗するので注意が必要だ．

```latex
\cref{fig:example,tab:example}
\cref{eq:example1,eq:example2}

```

**出力例**：

- Figure 1 and Table 1
- Equations (1) and (2)

違う種類（図と表など）の参照のときはそれぞれ接頭辞を出力し，同じ属性ならば接頭辞が複数形になったうえで番号が並ぶ形になる．

またhyperrefとの互換性があり，参照先に飛べるようになる．上の例に示すように，パッケージの読み込む順番は必ずhyperrefを先にする必要があるがその他の設定は特にない．

```latex
\usepackage[colorlinks=true,citecolor=blue,linkcolor=blue,urlcolor=blue]{hyperref}
\usepackage{cleveref}
```

## 接頭辞のカスタマイズ

---

### 接頭辞の変更

デフォルトの接頭辞はプリアンブルで`\crefname` および`\Crefname`を使用してカスタマイズできる．これで言語や投稿先に合わせて一括で設定を変更できる．形式は

```latex
\crefname{環境名}{単数形}{複数形}
```

という形で指定する．環境名は`figure` や`table` などのフロート環境から，`equation`, `align` などの数式環境，`chapter` や`section`などの章なども利用可能．例えばAPSの雑誌に投稿するならば以下の設定で大丈夫だろう．雑誌によって色々違うので確認は必要だが，投稿前にここだけ書き換えればよいのがcleverefの良いところだ．

```latex
\crefname{equation}{Eq.}{Eqs.}
\crefname{figure}{Fig.}{Figs.}
\crefname{table}{Table}{Tables}
\crefname{section}{Sec.}{Secs.}
\crefname{appendix}{Appendix}{Appendices}

\Crefname{equation}{Equation}{Equation}
\Crefname{figure}{Figure}{Figsure}
\Crefname{table}{Table}{Tables}
\Crefname{section}{Section}{Sections}
\Crefname{appendix}{Appendix}{Appendices}

```

日本語文書で図や表と指定することも可能．

```latex
\crefname{equation}{式}{式}
\crefname{figure}{図}{図}
\crefname{table}{表}{表}
\crefname{section}{節}{節}
\crefname{appendix}{付録}{付録}

\Crefname{equation}{式}{式}
\Crefname{figure}{図}{図}
\Crefname{table}{表}{表}
\Crefname{section}{節}{節}
\Crefname{appendix}{付録}{付録}

```

<aside>
💡

文中でもfigureのように省略したくない場合は，`noabbrev` オプションでcleverefを呼び出す．

</aside>

## まとめ

---

cleverefパッケージはLaTeX文書内での参照作業を大幅に簡略化し柔軟な表現を可能にする便利ツールだ．私が利用するのは複数参照と接頭辞の自動割当くらいだが，それでも相当効率化できる．

## 補足

---

数式や図表のラベル名の付け方をどうするべきかは難しい問題だ．私は上の例のように接頭辞とコロンから始めたうえで，論文ならば図表や数式の番号と中身，書籍ならば小番号を利用してラベリングするようにしている．

```bash
# 論文
eq:1:myeq # 式1
fig:5:myresult  # 図5
table:1:mytable # 図1
sec:2-1

# 書籍
eq:3-11:15:myeq #3-11節の式15
fig:2-4:2:myfig #2-4節の図2
```

## 参考文献

---

- [CTAN: Package cleveref](https://ctan.org/pkg/cleveref)
- [Overleaf: cleveref Documentation](https://www.overleaf.com/learn/latex/Cleveref)