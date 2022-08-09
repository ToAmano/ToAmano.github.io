
# SMASS(Nose-Mass)
 
## background
<!-- https://www.vasp.at/forum/viewtopic.php?f=4&t=18412 -->

<!--https://www.cnblogs.com/panscience/p/4989975.html-->

<!--https://www.researchgate.net/post/How-can-I-reduce-temperature-oscillation-in-NVT-ensemble-simulation-of-FPMD -->


<!-- 
ここでかなり詳しく解説されている．
https://www.toutiao.com/article/7041787115478516237/?wid=1660033468818
-->

<!--
Qujing Zhengのブログページ．ここを読んで勉強しよう．
http://staff.ustc.edu.cn/~zqj/posts/NVT-MD/
-->

原理的には、N個の粒子を持つ架空のサーモスタット位置変数sの周波数
$$
\omega=\frac{1}{\pi}\sqrt{\frac{6(N-1)k_BT}{M_s}}
$$
が実システムの特性周波数にカップリングするような$SMASS=M_s$が必要である。Hunenberg, Adv.Polym. Sci. 173, 105 (2005)

特性周波数とは，固体ではフォノン周波数である．
論文 "NoseHoover chains: The canonical ensemble via continuous dynamics" by Martyna, Tuckerman and Klein (1992)では、Nose-Hoover質量は
$$
M_s=\frac{Nk_BT}{\omega^2}
$$
として与えられているのが良い選択とされています。液体では、「フォノン」周波数のようなものが、速度自己相関関数のスペクトルから得られるかもしれない．

最後に，Nose-Hoover サーモスタットとイオン運動が非正規アンサンブルにならない限り、SMASSはどのような値でも良いということを強調しておく必要がある．これは、架空のサーモスタットの周波数と、計算するシステムの特性周波数が桁違いである場合にのみ起こる可能性がある．


## How to choose proper SMASS ?

SMASS=0 の場合は、振動数$\omega$がMDの40ステップに相当するNose質量が自動的に計算・採用される．POTIMはfs単位であることに注意しよう．
$$
\frac{2\pi}{\omega}=40*\text{POTIM}
$$
まずはこれを試すと良い．この時選択されたSMASSはOUTCARの中に出力されているので計算時に確認すると良い．例えば結晶の場合，フォノンの典型的なエネルギースケールは$100\mathrm{cm}^{-1}$から$1000\mathrm{cm}^{-1}$程度であるが，これは時間スケールに直すと．

SMASS=0で自動設定される値が不適切な場合もありうる．自分でSMASS>0を選択したい場合，単位は原子質量*長さ^2であり，長さaは最初の格子ベクトルの長さに設定される．（stepver.F）



## Check calculation results
全体の温度が正しいだけでなく、個々の自由度の「温度」があらかじめ定義されたシミュレーションのTに平均化されていることが必要です（等分配原理が破られないように、たとえ正しいTに平均化されていても、冷たいモードと熱いモードを持ちたくはないものです）。これはvasprun.xmlの速度から確認することができる．
