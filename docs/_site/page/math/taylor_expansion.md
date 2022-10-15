Taylor展開
基本的な関数のTaylor展開を紹介します．

Taylor展開とは
Taylor展開とは，関数$f(x)$を，$x$の冪級数に展開することを言います．式で書けば

$$
f(x)=\sum_{n=0}^{\infty}a_n(x-a)^n \label{1} $$
となります．特に$a=0$とした展開式

$$
f(x)=\sum_{n=0}^{\infty}a_nx^n
$$
のことをMaclaurin展開と言います．
ある関数が\eqref{1}の形に展開できたとすると，その展開係数$a_n$は，両辺を$n$回微分してから$x=a$と置くことにより

\begin{align} a_n=\frac{f^{(n)}(a)}{n!} \end{align}
と求まります．従ってこの係数を順番に計算すれば，関数のTaylor展開を得ることができます．
とまあ，以上結構適当にTaylor展開を導入しましたが，物理で最低限使う程度ではこの程度の理解でいいと思います．というのは普通物理学で使う関数はTaylor展開できることが多いからです．ただ，世の中にはTaylor展開できないような関数も存在します．そのあたりの事情は，また次の機会に記事にしたいと思います．今回はあくまでもいくつかの初等関数のTaylor展開を紹介するのが目的です．

指数，三角関数のTaylor展開
基本的な初等関数のtaylor展開は覚えて置く必要があります．一番有名なのは指数関数$e^x$のTaylor展開でしょう．$(e^x)'=e^x$だから，展開係数は$a_n=1/n!$となって

\begin{align} e^x=\sum_{n=0}^{\infty}\frac{x^n}{n!}\label{a} \end{align}
を得ます．
次に，三角関数のTaylor展開を考えましょう．$f(x)=\sin x$とすると，$f'=\cos x$，$f''=-\sin x$，$f'''=-\cos x$，$f''''=\sin x$の繰り返しだから

\begin{align} \sin x&=x-\frac{1}{3!}x^3+\frac{1}{5!}x^5+\cdots \\ &=\sum_{n=0}^{\infty}\frac{(-1)^nx^{2n+1}}{(2n+1)!} \label{b} \end{align}
です．展開の中に$x$の奇数乗しか現れないのは，$\sin$が奇関数であることに照らし合わせれば真っ当であることがわかります．全く同様に

\begin{align} \cos x&=1-\frac{1}{2!}x^2+\frac{1}{4!}x^4+\cdots \\ &=\sum_{n=0}^{\infty}\frac{(-1)^nx^{2n}}{(2n)!} \label{c} \end{align}
であることがわかります，\eqref{a}，\eqref{b}，\eqref{c}から，有名なEulerの公式

\begin{align*} e^{ix}=\cos x+i\sin x \end{align*}
が成立していることが確認できます．
さて，$\tan x$のTaylor展開はあまり出てこないので最初だけ覚えておけば良いでしょう．ただその導出方法は大切で$\sin$と$\cos$のTaylor 展開を辺々割って低次の項から整理します．つまり面倒な（？）$\tan x$の微分を計算することなくTaylor展開が得られるのです．実際に計算してみると
\begin{align*} \tan x = \frac{\sin x}{\cos x} \\ \simeq \frac{x-x^3/6}{1-x^2/2} \\ \simeq x +\frac{1}{3}x^3 \end{align*}

を得ます．
次に対数関数を考えましょう．$\log x$は原点で発散してしまうので$x=0$の周りで冪級数に展開するのはあまり意味がありません．代わりに$\log (x+1)$の展開を考えると

\begin{align*} \log (x+1)=\sum_{n=0}^{\infty}\frac{1}{n}x^n \end{align*}
が成立していることが確認できます．このTaylor展開は特に対数級数といって親しまれています．
双曲線関数のTaylor展開
先ほど，$\tan x$のTaylor展開は$\sin$と$\cos$のTaylor展開から導かれるという話をしました．今度は双曲線関数の展開を指数関数の展開か\\ ら導出してみましょう．まず，$\cosh$の方は

\begin{align*} \cosh (x)&=\frac{e^x+e^{-x}}{2}=\frac{1}{2}\left[\sum_{n=0}^{\infty}\frac{x^n}{n!}+\sum_{n=0}^{\infty}\frac{(-x)^n}{n!}\right] \\ &=\sum_{n=0}^{\infty}\frac{x^{2n}}{(2n)!} \end{align*}
これが求まれば$\sinh$の方も全く同様に

\begin{align*} \sinh x&=\frac{e^x-e^{-x}}{2}=\frac{1}{2}\left[\sum_{n=0}^{\infty}\frac{x^n}{n!}-\sum_{n=0}^{\infty}\frac{(-x)^n}{n!}\right] \\ &=\sum_{n=0}^{\infty}\frac{x^{2n+1}}{(2n+1)!} \end{align*}
となります．ここで三角関数の展開と見比べてみると，

\begin{align*} \sin (ix) =i\sinh (x)\\ \cos (ix) = \cosh (x) \end{align*}
の関係が成り立っていることがわかります．$\tanh$の展開は，$\tan $の導出と全く同様にして

\begin{align*} \tanh x=\frac{\sinh x}{\cosh x}\simeq x-\frac{1}{3}x^3+\frac{2}{15}x^5 \end{align*}
となります．

等比数列のTaylor展開
最後にもう一つだけ紹介しておきましょう．それが等比級数の和でおなじみの

\begin{align*} \frac{1}{1-x}=\sum_{n=0}^{\infty}x^n \end{align*}
の公式です．これは等比級数の和である右辺が左辺になる，ということでおなじみですが，こうして左辺と右辺を入れ替えるとTaylor展開のような公式に\ なります．ただ，等比級数の知識のある方にはわかると思いますが，この公式は$|x|<1$でしか成り立ちません．実際，$x=2$とでもしてみると左辺は$-1$である一方，右辺は無限大になってしま\ います．このようにTaylor展開は常に全ての$x$で成立するわけではないのです．今回は$|x|<1$ですが，この$x$の上限のことを収束半径と言います．

まとめ
いくつかの関数のTaylor展開を紹介してきました．これらの公式は導出できることはもちろん覚えていることが求められます．

$e^x=1+x+x^2/2+x^3?3!+\cdots$
$\sin x=x-x^3/6+x^5/120+\cdots$
$\cos x=1-x^2/2+x^4/24+\cdots$
$\sinh x=x+x^3/6+x^5/120+\cdots$
$\cosh x=1++x^2/2+x^4/24+\cdots$
$\log (1+x)=1+x+x^2/2+x^3/3+\cdots$
$1/(1-x)=1+x+x^2+x^3+\cdots$