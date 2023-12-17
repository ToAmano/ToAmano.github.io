---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: latexで外部ファイルから表を作成する方法
layout: single
date:   2023-11-16 21:00:00 +0900
categories: 
 - code
tags:
 - bash
 - emacs
description: 
---

latexで外部ファイルから表を作成する方法を紹介する．グラフの場合，tikzやpgfplotでは外部ファイルからデータを読み込むことが可能だが，表（table）の場合には意外とわからない．

## csvsimple

## 参考文献

[天地有情 [LaTeX] csvsimple -- ＣＳＶで表作成 ～初歩の初歩～](https://konoyonohana.blog.fc2.com/blog-entry-79.html)
[Creating a Table caption with csvsimple package using \csvautotabular{} - TeX - LaTeX Stack Exchange](https://tex.stackexchange.com/questions/431063/creating-a-table-caption-with-csvsimple-package-using-csvautotabular)


## condaの場合

condaを利用するには，もしanacondaを利用しているなら`.bash_profile`に記載するように`conda.sh`を読み込む必要がある．通常のshell利用時にはあまり意識しないので注意が必要．

```bash
. ${HOME}/anaconda3/etc/profile.d/conda.sh
conda activate your_env
# テスト
# conda env list
```

## venvの場合

venvの場合は通常のshellと同様の操作で大丈夫．

```bash
VENV_DIR="/path/to/env/"
python -m venv ${VENV_DIR}
source ${VENV_DIR}/bin/activate
```

