





```latex
\documentclass[a4]{article}
\usepackage{blindtext}
\begin{document}
これがequation環境です．ギリシャ文字や分数などの数学記号もお手のもの．
\begin{equation}
  f(x)=\alpha x^2+\beta x +\gamma \\
  \frac{1}{x}=\sqrt{x} \\
  \sum_{n=0}^{\infty}\frac{1}{n^2}=
\end{equation}

文中に数式を入れることもできます．例えば$f(x)=\alpha x^2+\beta x +\gamma$のように．

文中と独立環境では，分数や総和記号などの表記が若干異なっている場合があります．
\blinddocument
\end{document}
```




- 2行にわたる添字（多重添字）:`substack`コマンド
  
    ```latex
    \begin{equation}
    \sum_{\substack{ij \\ kl}}  
    \end{equation}
    ```

- 数式番号の調整
  
  特定の行に載せたくない場合は`nonumber`コマンドを利用する．
    ```latex
    \begin{equation}
    f(x)=ax^2+bx+c \nonumber \\
    g(x)=ax^2+bx+c \nonumber  
    \end{equation}
    ```
