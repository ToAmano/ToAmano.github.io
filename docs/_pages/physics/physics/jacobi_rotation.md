---
layout: single
title:  "Jacobi法 (Jacobi Rotation)"
date:   2022-09-04 10:03:40 +0900
categories: physics solid-state
mathjax: true
---

対角行列を対角化する手法であるJacobi法（Jacobi Rotation）について．


## ヤコビ法の概要

<!--
https://en.wikipedia.org/wiki/Jacobi_rotation

https://hooktail.org/computer/index.php?Jacobi%CB%A1

https://www.eng.niigata-u.ac.jp/~nomoto/16.html
-->

行列Aが対称行列である時，直交行列Pを用いて

$$
 P^{-1}AP = B
$$

と対角化できる．Jacobi法ではこの直交行列Pを反復作業で求める．つまり，行列Aの非対角成分の1つをゼロにする直交行列$P_1$を用意すると，
$$
 A_1 = P_{1}^{-1}AP_{1} 
$$
原理的にはこれを$n$回繰り返せば対角行列$B$を得られる．

$$
P_n^{-1}\cdots P_1{-1} A P_n\cdots P_1 = B
$$

行列$A$を対角化する行列は$P= P_n\cdots P_1$である．


## 行列Aの非対角成分の1つをゼロにする直交行列の作り方

概要で述べた手順が実行できるには，非対角成分の一つを0にする直交行列が作れないといけない．最も簡単な例として2次元行列の例を考えよう．
