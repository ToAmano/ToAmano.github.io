---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: PythonInstall
layout: single
description: The Python Installation.
permalink: /python/install
---

## python環境の作成方法概要

python環境を作成するに当たって，おおきく二つのことを考える必要がある．

- プロジェクトによるpythonのバージョン変更が必要かどうか
- パッケージ管理をどうするか



## pyenvによる環境構築

pyenvのgithubページは[こちら](https://github.com/pyenv/pyenv)．

- 1: pyenvのinstall
  ```
  # githubからのinstall
  # 公式は~/.pyenvに入れることを推奨しているが別の場所でも問題なく動く
  git clone https://github.com/pyenv/pyenv ~/.pyenv
  ```
  
  '''
  # macならhomebrewを使ったinstallも可能
  brew install pyenv
  '''
