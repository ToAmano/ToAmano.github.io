---
layout: single
title:  "github_pagesについて"
date:   2022-09-04 10:03:40 +0900
categories: git guthub 
tags:
- github 
---


## minimal mistakes

- 画像貼り付け1

https://mmistakes.github.io/minimal-mistakes/post%20formats/post-image-standard/

```liquid
# 通常のhtml記法
<img src="{{ site.url }}{{ site.baseurl }}/assets/images/filename.jpg" alt="">

# kmarkdown記法
{% raw %}
 ![alt]({{ site.url }}{{ site.baseurl }}/assets/images/filename.jpg)
{% endraw %}
```

- 画像貼り付け2

```liquid
画像の貼り付けにはminimal mistakes helperが使える
https://mmistakes.github.io/minimal-mistakes/docs/helpers/
{% raw %}{% include figure image_path="/assets/images/unsplash-image-10.jpg" alt="this is a placeholder image" caption="This is a figure caption." %}{% endraw %}
```


## 参考文献

<!-- 
https://qiita.com/noraworld/items/f0da9ecb608476fe3a02#jekyll-remote-theme

https://www.mk-mode.com/blog/2019/01/27/jekyll-with-minimal-mistakes/

https://simondosda.github.io/posts/2021-09-15-blog-github-pages-3-content.html

https://www.smashingmagazine.com/2014/08/build-blog-jekyll-github-pages/


(sidebarの参考になるかも)
https://masamichi.me/development/2020/05/28/github-pages-blog-part3-cutomize-setting.html
https://masamichi.me/development/2019/12/14/github-pages-blog.html

https://chadbaldwin.net/2021/03/14/how-to-build-a-sql-blog.html

mathjax: https://qiita.com/memakura/items/e4d2de379f98ad7be498
mathjax: https://pandanote.info/?p=3715 （現状この設定に従っている）


https://peterroelants.github.io/posts/adding-tags-to-github-pages/
タグについて

https://qiita.com/eijiSaito/items/b4a1675ec196546aa4f2
-->
