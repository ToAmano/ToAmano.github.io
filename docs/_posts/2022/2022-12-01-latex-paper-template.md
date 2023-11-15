---
layout: single
title:  "論文のcover letterとresponse to referee commentsをLaTeXで書く"
date:   2023-12-01 09:00:00 +0900
categories: LaTeX
tags:
 - ssh
---

## 論文のcover letterとresponse to referee comments

論文をLaTeXで書くにあたり，cover letterとレフェリーへのresponseもLaTeXで書きたいということで，適したテンプレートがないか調べてみた．ジャーナルによってpdfで提出できるかどうかは違いがあるかもしれないが，少なくともAPSでは共にpdfで送信することができる．LaTeXで書いておけば次の論文以降でも使いまわしやすいメリットがある．

## cover letter

cover letterについては，`moderncv`ドキュメントクラスが使いやすい．これはCVおよびcover letter用のドキュメントクラスで，[github上で公開](https://github.com/moderncv)されている．マニュアルもレポジトリ内で[公開](https://github.com/moderncv/moderncv/blob/master/manual/moderncv_userguide.pdf)されているので，詳しいことはそちらを参照されたい．ここではcover letterを書くことに絞って記述していく．

テンプレートはover leaf上で公開されている[ページ](https://www.overleaf.com/gallery/tagged/cover-letter)で他のドキュメントクラスも含めて色々みられるので要チェック．ここのcover letterはjob application用のものだが，まあ論文用もまあ似たようなものなので参考になると思う．自分は一番地味だと思った[これ](https://www.overleaf.com/latex/templates/carta-de-motivacion-slash-presentacion/bwxpnywmjksk)をもとに作成した．overleafのテンプレートは細かいコメントでオプションについても解説があるので非常に参考になる．これを使って作ったMWEは以下のようなものだ．

```
\documentclass[12pt,a4paper,roman]{moderncv} % font familyは'sans'と'roman'

% ======== 基本設定 =====

% moderncv themes
\moderncvstyle{classic}                            % 'casual' (default), 'classic', 'oldstyle' and 'banking'
\moderncvcolor{green}                              % 'blue' (default), 'orange', 'green', 'red', 'purple', 'grey' and 'black'
%\renewcommand{\familydefault}{\sfdefault}         % to set the default font; use '\sfdefault' for the default sans serif font, '\rmdefault' for the default roman one, or any tex font name

% ======== 幅などを調整する場合 =====

\usepackage[scale=0.82]{geometry}                  % adjust the page margins (original is too small for me.)
%\setlength{\hintscolumnwidth}{3cm}                % if you want to change the width of the column with the dates
%\setlength{\makecvtitlenamewidth}{10cm}           % for the 'classic' style, if you want to force the width allocated to your name and avoid line breaks. be careful though, the length is normally calculated to avoid any overlap with your personal info; use this at your own typographical risks...


% ========= ここから著者情報（基本的に全てoption） ========
% personal data
\name{Tomohito}{Amano}
\title{Title}
\address{Department of hoge, University of fuga}{1-1-1 Address, Tokyo, Japan.} % the "postcode city" and and "country" arguments can be omitted or provided empty

%\phone[mobile]{000-000-000-000}
\phone[fixed]{+81-000-000-000}
%\phone[fax]{+000-000-000-000}
\email{hogehoge.example.com}
%\extrainfo{additional information}

% ========= 内容 ======

\begin{document}

% 宛先
\recipient{The Editorial Office}{Journal hogehoge}
\date{\today}

% 文頭
\opening{\textbf{Paper title}: hogehoge \\
\textbf{Authors}: hogehoge, fugafuga }

% 文末
\closing{Sincerely yours,}

\makelettertitle

% 以下本文．みやすいように段落ごとにvspaceで間隔を開けている．
Dear Editors of Journal hogehoge

\vspace{0.5cm}

We are submitting a paper entitled "hogehoge" for consideration of publication as Regular Article in Journal hogehoge.

\vspace{0.2cm}

comments.

\vspace{0.3cm}

\name{On behalf of all the authors, \\ First-name}{Last-name}
\makeletterclosing

\end{document}
```


## response to referee comments

レフェリーコメント，およびそれへのレスポンスについては，stackexchangeの[このページ](https://tex.stackexchange.com/questions/2317/latex-style-or-macro-for-detailed-response-to-referee-report)が参考になる．

テンプレートとしては[review_response_letter](https://github.com/mschroen/review_response_letter)というレポジトリがあったりするが，そこまでやるのが大袈裟だという場合には`enumerate`などのリストを使う，自分で簡単にマクロを定義する方法などが紹介されている．



