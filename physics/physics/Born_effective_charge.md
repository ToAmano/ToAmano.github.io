# Born有効電荷

Born有効電荷の定義はeV単位で

$$
Z_{\kappa,\alpha\beta}=\Omega_0\left.\frac{\partial P_{\beta}}{\partial \tau_{\kappa,\alpha}}  \right|_{E=0}
$$

である．カッパは原子種，αとβはcartesian座標．つまり，0電場において，ある原子がα方向にズレた時の分極βのズレを計算している．α=βの時は比較的わかりやすいと思うが，原子が少しズレるとα以外の方向の分極もズレるということである．Ωは系のunit cellの体積． この標識は他の手法でも書くことができる． 電場eの元での系の全エネルギー（エンタルピー？[2]）を考えると，

$$
E[e]=E_{KS}-\Omega_0\sum_{\beta}P_{\beta}e_{\alpha}
$$

とかけるので，分極は

$$
P_{\alpha}=-\frac{1}{\Omega_0}\frac{\partial E}{\partial \mathcal{E}_{\alpha}}
$$

とエネルギーの電場微分で表されることになる．したがってこれを式(1)に代入すると，Zの表式としては以下のようになる．

$$
Z_{\kappa,\alpha\beta}=-\left.\frac{\partial E}{\partial \tau_{\kappa,\alpha}\partial \mathcal{E}_{\beta}}  \right|_{E=0}=\frac{\partial F_{\kappa\alpha}}{\partial \mathcal{E}_{\beta}}=\Omega_0\left.\frac{\partial P_{\beta}}{\partial \tau_{\kappa,\alpha}}  \right|_{E=0}
$$

二つ目の等号でエネルギーの座標微分が力であることを用いた．これは電場をかけた時の力の変化ということができる．quantum espressoでは，以上二つの式に基づいた計算が可能になっており，それぞれ

```bash
zeu=.true.　　
zue=.true.
```

のふたつのオプションによって使い分けることができる．これら2つの方法での具体的な計算については，[1]のp114あたりに簡潔にまとめられている．

$$

$$

# 参考文献

[1] [http://www.phythema.ulg.ac.be/webroot/misc/books/PhD-Ph.Ghosez.pdf](http://www.phythema.ulg.ac.be/webroot/misc/books/PhD-Ph.Ghosez.pdf)

[2] [http://cmt.dur.ac.uk/sjc/thesis_prt/node56.html](http://cmt.dur.ac.uk/sjc/thesis_prt/node56.html)