# Born有効電荷

## Born有効電荷の定義
Born有効電荷(BEC)の定義はeV単位で

$$
Z_{\kappa,\alpha\beta}=\Omega_0\left.\frac{\partial P_{\beta}}{\partial \tau_{\kappa,\alpha}}  \right|_{E=0}
$$

である．κは原子種，αとβはcartesian座標．つまり，0電場において，ある原子がα方向にズレた時の分極βのズレを計算している．Ωは系のunit cellの体積．結晶がイオンだけで構成されていると考えると，原子$i$がずれた時の分極のずれはこの原子の電荷×原子が動いた距離だから
$$
Z_{\kappa,\alpha\beta}=\Omega_0*Q_{\kappa,\alpha\beta}
$$
となり，BECはイオン電荷と一致する．しかしながら現実の物質では原子が移動するとそれに伴って電子分布が変化し，BECは必ずしもイオン電荷と一致しない．実際$Z$は3×3の行列であり，原子がα方向にずれるとそれ以外の方向$¥beta¥neq¥alpha$にも分極が発生する場合がある．これは上述のようなイオンだけの単純なモデルでは起こり得ないことである．

## BECのいくつかの表現

電場eの元での系の全エネルギー（エンタルピー？[2]）を考えると，
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

二つ目の等号でエネルギーの座標微分が力であることを用いた．これは電場をかけた時の力の変化ということができる．


## Quantum Espressoでの計算
quantum espressoでは，以上二つの式に基づいたDFPT計算が可能になっており，それぞれ

```bash:ph.x
zeu=.true.　! dF/dEから計算,default　
zue=.true. ! dP/dtauから計算
```

のふたつのオプションによって使い分けることができる．これら2つの方法での具体的な計算については，[1]のp114あたりに簡潔にまとめられている．

## 参考文献

[1] [http://www.phythema.ulg.ac.be/webroot/misc/books/PhD-Ph.Ghosez.pdf](http://www.phythema.ulg.ac.be/webroot/misc/books/PhD-Ph.Ghosez.pdf)

[2] [http://cmt.dur.ac.uk/sjc/thesis_prt/node56.html](http://cmt.dur.ac.uk/sjc/thesis_prt/node56.html)