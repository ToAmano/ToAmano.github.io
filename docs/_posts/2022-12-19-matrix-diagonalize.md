---
layout: single
title:  "行列の対角化の基礎"
date:   2022-12-19 09:00:00 +0900
categories: math
tags:
 - linux
 - bash
mathjax: true
---

## 行列の対角化の基礎

与えられた\(n\times n\)次元の正方行列 \(A\) に対して，正則行列 \(P\) をうまく取ってきて $E=P^{-1}AP$を対角行列にする操作を対角化という．より具体的には$A$の$n$本の固有ベクトル$x_1,x_2,\cdots,x_n$が線型独立なら，$A$は対角化可能である．対応する固有値を$\lambda_1,\lambda_2,\cdots,\lambda_n$とする．この時対角化のための行列$P$としてはこれら$n$個のベクトルを並べた
\[
 P=(x_1,x_2,\cdots,x_n)
\]
とすると，対角化後の行列$E$は
\[
 E=diag(\lambda_1,\lambda_2,\cdots,\lambda_n)
\]
となる．
