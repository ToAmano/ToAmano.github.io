---
layout: default
title:  "fractional coordinate"
date:   2022-09-04 10:03:40 +0900
categories: physics solid-state
mathjax: true
---


## 分極座標とデカルト座標の変換

結晶の基本ベクトルが与えられた時に，デカルト座標の点$(x,y,z)$から分極座標$(b_1,b_2,b_3)$への変換をどうするべきかを考える．

ここでは一応デカルト座標と分極座標の変換ということにしているが，より一般に任意の座標間の変換について使える手法である．一般論への拡大を可能にするために，デカルト座標の基底を

$$
\vec{r}_1=
\begin{pmatrix}
1 \\
0 \\
0 
\end{pmatrix} ,
&\vec{r}_2=
\begin{pmatrix}
0 \\
1 \\
0 
\end{pmatrix} ,
&\vec{r}_3=
\begin{pmatrix}
0 \\
0 \\
1 
\end{pmatrix}
$$

と置く．結晶ベクトルを$\vec{a}_1$, $\vec{a}_2$, $\vec{a}_3$とおき，分極座標$(b_1,b_2,b_3)$とする．すると任意のベクトル$\vec{p}$は
$$
\vec{p}&=x\vec{r}_1+y\vec{r}_2+z\vec{r}_3 \\
&=b_1\vec{a}_1+b_2\vec{a}_2+b_3\vec{a}_3
$$

と書ける．これを行列形式で書き直すと

$$
\begin{pmatrix}
\vec{r}_1 & \vec{r}_2 & \vec{r}_3 
\end{pmatrix}
\begin{pmatrix}
x \\
y \\
z
\end{pmatrix}
=
\begin{pmatrix}
\vec{a}_1 & \vec{a}_2 & \vec{a}_3 
\end{pmatrix}
\begin{pmatrix}
b_1 \\
b_2 \\
b_3
\end{pmatrix}
$$

となる．簡単のためにこの式を

$$
R\vec{x}=A\vec{b}
$$

と書いておく．今はデカルト座標を考えているから左辺の行列$R$は単位行列になっているが，一般の場合にはもっと複雑な行列になっている．ここから分極座標$b$を求めるには左から行列$A^{-1}$を作用させれば良く，これが変換を与える公式である．

$$
\vec{b}=A^{-1}R \vec{x}
$$

例えば結晶中の全部の原子の座標$\vec{x}_1$から$\vec{x}_n$を変換したいというように複数の点を変換させたい場合は，

$$
\begin{pmatrix}
\vec{b}_1 & \vec{b}_2 &\cdots & \vec{b}_n
\end{pmatrix}
=A^{-1}R 
\begin{pmatrix}
\vec{x}_1 & \vec{x}_2 &\cdots & \vec{x}_n
\end{pmatrix}
$$

とすれば一括して扱える．

典型的なpythonコードは以下のようになる．ここではまず，numpy配列x[i][j]はi番目の原子のデカルト成分jを表すとする．この順番にしてあるのはaseがこの形式で座標を扱っているからである．そうすると上の式はトレースをとって扱うことになる．

$$
\begin{pmatrix}
\vec{b}^{T}_1 \\
\vec{b}^{T}_2 \\
\cdots \\
\vec{b}^{T}_n
\end{pmatrix}^{T}
=
\begin{pmatrix}
\vec{x}^{T}_1 \\
\vec{x}^{T}_2 \\
\cdots \\
\vec{x}^{T}_n
\end{pmatrix}^{T}
(A^{-1}R )^{T}
$$

これをpythonで書いたのが以下．ただし$R=1$としてある．

```python
import numpy as np

# lattice vectors (here we have fcc)
a  = 5.0
a1 = a*np.array([-1/2,0,1/2])
a2 = a*np.array([0,1/2,1/2])
a3 = a*np.array([-1/2,1/2,0])

# Build the matrix of lattice vectors stored column-wise
# and get its inverse
A = np.vstack([a1, a2, a3]).T
A_inv = np.linalg.inv(A)

# A random set of cartesian coordinates stored row-wise
X_T = np.array([[0.25, 0.75, 0.1], 
                [0.5, 0.25, 0.3]])

# Perform the inverse operation to get fractional coordinates. Resultant B is ?
B = np.matmul(A_inv, X_T.T).T

# Compute the cartesian coordinates to check if X_T_check=X_T
X_T_check = np.matmul(A, B.T).T
```

これを実行すると以下のような結果を得て計算がうまくいっていることがわかる．