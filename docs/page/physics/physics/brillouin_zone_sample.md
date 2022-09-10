---
layout: default
title:  "ブリルアンゾーン"
date:   2022-09-04 10:03:40 +0900
categories: physics solid-state
---

## ブリルアンゾーンサンプリング

### Γ-centerd sampling

$$ 
 \sum_{i=1,2,3}\frac{n_i+s_i}{N_i}b_i
$$


### Monkhorst-Pack sampling

$$ 
 \sum_{i=1,2,3}\frac{n_i+s_i+(1-N_i)/2}{N_i}b_i
$$
ここで$ni=1,2,\cdots N_i$を取る．$N_i$はメッシュの細かさを表す．



## Special-Points

第一ブリルアンゾーンの中でも特に対称性の高い点のことをspecial-pointsといってX,Zなどと大文字のラベルを打って表記する．文献によって異なる表記を用いていたりするため実際計算する時には結構苦労する． 結晶構造によってブリルアンゾーンの形が異なり，従って対称性の高い点も様々であるため結晶構造ごとにSpecial-Pointsがまとめられており，特に現代的な表記については以下の2本が参考になる．


ほぼ全ての構造に普遍的なK点をいくつかリストアップする．まず原点(0,0,0)のことをΓ点と呼ぶ．これは全ての結晶構造に共通である．継いでよく出現するのがX,Y,Z点で，これは逆格子空間のデカルト座標軸と第一ブリルアンゾーンの交点のことを指すことが多い．



- AiiDA
    https://aiida.readthedocs.io/projects/aiida-core/en/latest/reference/apidoc/aiida.tools.data.array.kpoints.html?highlight=kpoints.seekpath#module-aiida.tools.data.array.kpoints.seekpath

- ase
    https://databases.fysik.dtu.dk/ase/ase/dft/kpoints.html

ソフトウェアによってk点の指定方法がデカルト座標だったり分極座標だったりするので注意が必要．例えばQEはデカルト座標だがalamodeは分極座標である．


## 参考文献

[VASPの解説ページ](https://www.vasp.at/wiki/index.php/KPOINTS)