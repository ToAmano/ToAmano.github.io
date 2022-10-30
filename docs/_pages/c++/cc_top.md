---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: C/C++ Top
layout: single
description: The top-page of Python.
---



## ファイルの出力と読み込み

<!--
http://www.slis.tsukuba.ac.jp/~fujisawa.makoto.fu/cgi-bin/wiki/index.php?string%A4%CB%A4%E8%A4%EB%CA%B8%BB%FA%CE%F3%BD%E8%CD%FD

peek
https://stackoverflow.com/questions/15082383/to-separate-comments-and-data-in-txt-file-by-c-fstream
-->

peek 関数は値を取得しつつ読み込み位置を現在のまま維持する．

```cc
#include <iostream>
#include <string>
#include <fstream>
int main(){
  std::ifstream input("input");
  while (input.good()) {
    char c = input.peek();
    if (c == '#' || c == '\n') {
      input.ignore(256, '\n');
      continue;
    }   
    std::string s1, s2; 
    int i;
    input >> s1 >> s2 >> i;
    if (input.good())
      std::cout << s1 << " - " << s2 << " - " << i << std::endl;
  }
  input.close();
  return 0;
}
```
