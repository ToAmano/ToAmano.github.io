---
layout: default
title:  "zshをlinuxへインストールする"
date:   2022-09-04 10:03:40 +0900
categories: bash zsh linux
---

## まえがき
管理者権限のないlinuxマシンでは，通常zshを利用することができない．使いたい場合は自分のホームディレクトリに別途zshをインストールする必要がある．


```bash
configure: error: "No terminal handling library was found on your system.
This is probably a library called 'curses' or 'ncurses'.  You may
need to install a package called 'curses-devel' or 'ncurses-devel' on your
system."
```
