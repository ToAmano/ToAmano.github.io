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


## mathjax

mathjaxをgithub pagesで使うには，テンプレートファイルをいじる必要がある．`minimal mistakes`の場合は，`_include/head/custom.html`というファイルを以下の内容で作成した．

```custom.html
{% if page.mathjax %}
<script>
    MathJax = {
      tex: {
        inlineMath: [['$','$'], ['\\(','\\)']],
        processEscapes: true,
        tags: "ams",
        autoload: {
          color: [],
          colorV2: ['color']
        },
        packages: {'[+]': ['noerrors']}
      },
      chtml: {
        matchFontHeight: false,
        displayAlign: "left",
        displayIndent: "2em"
      },
      options: {
        renderActions: {
          /* add a new named action to render <script type="math/tex"> */
          find_script_mathtex: [10, function (doc) {
            for (const node of document.querySelectorAll('script[type^="math/tex"]')) {
              const display = !!node.type.match(/; *mode=display/);
              const math = new doc.options.MathItem(node.textContent, doc.inputJax[0], display);
              const text = document.createTextNode('');
              node.parentNode.replaceChild(text, node);
              math.start = {node: text, delim: '', n: 0};
              math.end = {node: text, delim: '', n: 0};
              doc.math.push(math);
            }
          }, '']
        }
      },
      loader: {
        load: ['[tex]/noerrors']
      }
    };
</script>
<script async src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-chtml.js" id="MathJax-script"></script>
{% endif %}
```

mathjaxの部分については[こちら](https://qiita.com/memakura/items/e4d2de379f98ad7be498)のページを参考にした．

`minimal mistakes`の場合はこれで自動的に読み込んでくれるようになる．詳しくはgithubレポジトリの`_layouts/default.html`ファイルを参照してみると，ここで`head/custom/html`を読み込むようになっている．一般的なテーマを使っている場合，こちらのlayoutのファイルもいじる必要があるかもしれない．


- 通常のLaTeXと同じく，`tag`による番号づけ，`label`によるラベリング，`\eqref`による参照が可能．

```
ガウスの発散定理は，
  \begin{align}
    \int_V \nabla\cdot AdV=\int_S A\cdot n dS
    \tag{1}
    \label{eq:gauss}
  \end{align}
です．式\eqref{eq:gauss}は，微分の体積分はものの関数の面積分になる，と言っています．
```

<!--
http://www.yamamo10.jp/yamamoto/internet/WEB/MathJax/index.php#EQ_NUMBER
http://memopad.bitter.jp/web/mathjax/TeXSyntax.html

https://www.eng.niigata-u.ac.jp/~nomoto/download/mathjax.pdf
-->


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
