---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: ジョブ管理システムでconda/pyenvなどのpython仮想環境を利用する方法
layout: single
date:   2023-11-14 21:00:00 +0900
categories: 
 - code
tags:
 - bash
 - emacs
description: ジョブ管理システムでconda/pyenvなどのpython仮想環境を利用する方法
---

slurmなどのジョブ管理システムでpythonの仮想環境を読み込む方法について，condaとvenvの場合についてまとめた．今までログインシェルで仮想環境を起動した状態でジョブを投入していたのだが，やはりジョブスクリプトですべて完結しているのが望ましいと思う．

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

