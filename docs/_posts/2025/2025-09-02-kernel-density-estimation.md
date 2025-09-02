---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults
title: カーネル密度推定の概要とPython実装
layout: single
date:   2025-9-02 21:00:00 +0900
categories: coding
tags:
 - git
header:
  teaser:
description: カーネル密度推定の概要と，実用上重要なガウシアンカーネル密度推定の理論的詳細，Pythonによる実装までをコンパクトに紹介．
---


## 密度推定の概要

カーネル密度推定に入る前に，簡単に密度推定について振り返る．

統計学や機械学習において、密度推定（Density Estimation）は重要な問題であり，与えられた観測データ点$x_1,x_2,\cdots, x_n$から，そのデータを生成した確率分布の密度関数$f(x)$を推定する逆問題の一種である．

応用例としては異常検知や分類問題などが挙げられる．

ちなみに私は今回機械学習の予測データの可視化のために密度推定を利用している．

最も単純な密度推定手法はヒストグラムである．データを固定幅のビンに分割し、各ビンの頻度を計算する：

$$
\hat{f}(x) = \frac{1}{nh} \sum_{i=1}^{n} \mathbf{1}_{[x-h/2, x+h/2]}(x_i)
$$

ここで$h$ はビン幅、$\mathbf{1}_{A}(x)$ は指示関数である．

しかし、ヒストグラムには推定された確率密度が不連続になったり，ビン幅やビンの境界の選択によって大きく結果が変わる問題がある．そのためヒストグラムよりも高度な密度推定アプローチが研究・実用化されてきた．これらは大きく**パラメトリック手法**と**ノンパラメトリック手法**に分類される．

### パラメトリック推定

パラメトリック推定では密度関数の関数形を事前に仮定して有限個のパラメータを推定する．

代表的な手法として，正規分布を仮定するのもこの例である．

$$
f(x) = \mathcal{N}(x|\mu, \sigma^2) 
$$

$$
\mathcal{N}(x|\mu, \sigma^2)  = \frac{1}{\sqrt{2\pi\sigma^2}} \exp\left(-\frac{(x-\mu)^2}{2\sigma^2}\right)
$$

この場合，パラメータ $\mu$（平均）と $\sigma^2$（分散）を最尤推定で求める：

$$
\hat{\mu} = \frac{1}{n}\sum_{i=1}^{n} x_i
$$

$$
\hat{\sigma}^2 = \frac{1}{n}\sum_{i=1}^{n} (x_i - \hat{\mu})^2
$$

他の例として，クラスタリングの文脈で用いられる混合ガウシアンモデル（GMM）もこの一種である．これはあらかじめ決めた$K$個にデータをクラスタリングし，$K$個のガウシアンの重ね合わせで全体の確率密度を表す．

$$
f(x) = \sum_{k=1}^{K} \pi_k \mathcal{N}(x|\mu_k, \sigma_k^2)
$$

パラメータ ${\pi_k, \mu_k, \sigma_k^2}$ は最尤推定で決定できる．

このようなパラメトリックな手法は少ないパラメータで表現可能だったり，解釈しやすい利点がある反面，事前に仮定した分布が間違っていると大きな誤差が生じてしまう点や，現実にあるような複雑な密度分布の推定には向かない欠点がある．

### ノンパラメトリック推定

ノンパラメトリック推定では密度関数の関数形を仮定せず，データから直接密度を推定する．ヒストグラムはまさにノンパラメトリックな手法である．

今回紹介するカーネル密度推定はこちらに属する．ほかにk近傍法（k-NN密度推定）も知られており，これは点 $x$ の密度を，$x$ から $k$ 番目に近いデータ点までの距離 $d_k(x)$ を用いて推定する：

$$
\hat{f}(x) = \frac{k}{2nd_k(x)}
$$

ノンパラメトリックな手法は複雑な多峰性分布にも対応可能な一方で大量のデータが必要で計算コストが高いのが問題である．要はパラメトリックな手法との使い分けが重要だ．

## カーネル密度推定の数学的詳細

### 基本的なアイデア

データポイント1つ1つに「山」（カーネル関数）を置いて重ね合わせることで全体の密度分布を推定する．ヒストグラムでは各データポイントが矩形のビンに貢献するが、KDEでは各データポイントが滑らかな「山」を形成し、連続的な密度関数を生成する．ヒストグラムの自然な拡張になっている．

```
データポイント:  •     •   •    •
各点のカーネル:   ∩     ∩   ∩    ∩
合成された密度:   ～～～～～～～～～～～

```

### 数学的定義

簡単のために一次元で考える．$n$個のデータポイント $x_1, x_2, \ldots, x_n$ が与えられたとき，カーネル密度$\hat{f}(x)$は以下のように定義される：

$$
\hat{f}(x) = \frac{1}{n} \sum_{i=1}^{n} K_h(x - x_i) = \frac{1}{nh} \sum_{i=1}^{n} K\left(\frac{x - x_i}{h}\right)
$$

ここで：

- $K(\cdot)$：カーネル関数
- $h$：バンド幅（帯域幅）パラメータ
- $n$：データポイントの数

である．

カーネル関数としてはガウシアンがもっともよく用いられる．そのほかに矩形関数などが利用されることもある．ガウシアンカーネルは通常の規格化されたガウス関数

$$
K(u) = \frac{1}{\sqrt{2\pi}} \exp\left(-\frac{u^2}{2}\right)
$$

で与えられる．従って，カーネル密度をあらわに表すと

$$
\hat{f}(x) = \frac{1}{nh\sqrt{2\pi}} \sum_{i=1}^{n} \exp\left(-\frac{(x - x_i)^2}{2h^2}\right)
$$

となる．データポイントの数$n$は所与なため，ハイパーパラメータとして与えるべきはバンド幅$h$のみである．ヒストグラムと同様，$h$は大きすぎても小さすぎてもダメで最適な値を選択しないといけない．以下，$n\to\infty$で$h\to 0$と仮定する．

- **$h$ が小さすぎる場合**：過学習気味になり、ノイズの多い推定結果
- **$h$ が大きすぎる場合**：過度に滑らかになり、詳細な構造を失う

### バンド幅の決定方法

というわけでバンド幅をどのように決定するか，いくつかの方法が用いられている．

[scipyの実装](https://docs.scipy.org/doc/scipy/reference/generated/scipy.stats.gaussian_kde.html)ではScott’s RuleとSilverman’s Ruleという二つの経験則が提供されている．これは

$$
h_{\mathrm{scott}} = n^{-1/(d+4)} \sigma
$$

$$
h_{\mathrm{silverman}} = \left(\frac{4}{d+2}\right)^{1/(d+4)} n^{-1/(d+4)}  \sigma
$$

ここで$\sigma$ はデータの標準偏差，$d$ は次元数である．いずれもデータ数$n$に対して減少する形になっており，二つのルールは係数が異なるだけである．

普通の一次元の場合は$d=1$だから

$$
h_{\mathrm{scott}} = n^{-1/5} \sigma
$$

$$
h_{\mathrm{silverman}} = \left(\frac{4}{3}\right)^{1/5} n^{-1/5}  \sigma \simeq 1.06 n^{-1/5}  \sigma 
$$

となる．

$n$の指数$-1/5$がどこから出てきたのかを知るには，もう一つよく用いられるバンド幅決定方法である，最小二乗クロスバリデーション（LSCV）を知る必要がある．以下少し数学的な変形が続くので飛ばしても良い．

基本的なアイデアは真の密度関数 $f(x)$ と推定密度関数 $\hat{f}_h(x)$ の二乗誤差を最小化するバンド幅 $h$ を選択することである．まず，ある点$x$における真の密度と推定密度の二乗距離(MSE)は以下の期待値で定義される：

$$
\text{MSE}(\hat{f}(x), h) := \mathbb{E}[(\hat{f}_{h}(x) - f(x))^2]
$$

期待値は確率密度に対して取る．

これを$x$に関して積分した積分二乗誤差は

$$
\text{IMSE}(\hat{f}(x), h) := \int \mathbb{E}[(\hat{f}_{h}(x) - f(x))^2] dx
$$

であり，これを最小化する$h$を考える．

ところがこの式は真の密度 $f(x)$ を含んでおり，これは未知であるためサンプルで代用する必要がある．サンプルと$\hat{f}_{h}(x)$には相関があるためクロスバリデーションによって真の密度$f(x)$を評価する．これが最小二乗クロスバリデーション法の概要である．

そこで式変形を続ける．平均二乗誤差（MSE）をバイアスとバリアンスに分解できる．

$$
\text{MSE}(\hat{f}(x), h) = \underbrace{\mathbb{E}[(\hat{f}(x) - \mathbb{E}[\hat{f}(x)])^2]}{\text{バリアンス項}} + \underbrace{\mathbb{E}[(\mathbb{E}[\hat{f}(x)] - f(x))^2]}{\text{バイアス項}}
$$

一項目のバリアンス項は推定密度の分散(variance)を表し，$h$が小さくなると大きくなる（過学習）．二項目のバイアス項は真の密度と推定密度の誤差を表し，$h$が大きいと大きくなる（過平滑化）．最適なバンド幅はこの両者のバランスを取る点で決まる．

具体的なカーネル密度推定の密度を代入していこう．

まず，$\hat{f}_{h}(x)$の点$x$での期待値は

$$
E[\hat{f}(x)] = E\left[\frac{1}{nh}\sum_{i=1}^{n}K\left(\frac{x-X_i}{h}\right)\right] \\
= \frac{1}{n}\sum_{i=1}^{n}E\left[\frac{1}{h}K\left(\frac{x-X_i}{h}\right)\right] \\
= E\left[\frac{1}{h}K\left(\frac{x-X}{h}\right)\right] \\= \int \frac{1}{h}K\left(\frac{x-X}{h}\right)f(X)dX  \\= \int K(u)f(x-hu)du 
$$

である．ただし，2行目までのデータ点$X_i$を，3行目で確率変数$X$に置き換えている．4行目で確率変数$X$による積分にしている．

さて、ここで $f(x-hu)$ をテイラー展開すると

$$
f(x-hu) = f(x) - hu\frac{df(x)}{dx} + \frac{h^2u^2}{2}\frac{d^2f(x)}{dx^2} + o(h^3)
$$

となるから，両辺に$K(u)$をかけて$u$で積分すると

$$
\int K(u)f(x-hu)du - f(x)\int K(u)du \\= -h\frac{df(x)}{dx}\int uK(u)du + \frac{h^2}{2}\frac{d^2f(x)}{dx^2}\int u^2K(u)du + o(h^3)
$$

である．左辺の第一項は$E[\hat{f}(x)] $である．

ここで、カーネル関数の条件より

$$
\int uK(u)du = 0 \\ \int K(u)du = 1
$$

なので右辺の一項目は$0$であって

$$
E[\hat{f}(x)] - f(x) \\= \frac{h^2}{2}\frac{d^2f(x)}{dx^2}\int u^2K(u)du + o(h^3)
$$

すなわちバイアス項は

$$
\mathbb{E}[(\mathbb{E}[\hat{f}(x)] - f(x))^2] = \left(\frac{h^2}{2}\frac{d^2p(x)}{dx^2}\int u^2K(u)du\right)^2 + o(h^6).
$$

となる．$n\to\infty$で$h\to 0$

一方バリアンス項は$\hat{f}(x)$ の分散（分散を $\text{Var}(\cdot)$ と書く）である．よって点$x$での評価は

$$
E[(\hat{p}(x) - E[\hat{p}(x)])^2] = \text{Var}(\hat{p}(x)) \\ = \text{Var}\left(\sum_{i=1}^{n}\frac{1}{h}K\left(\frac{x-X_i}{h}\right)\right) \\ = \frac{1}{n}\text{Var}\left(\frac{1}{h}K\left(\frac{x-X}{h}\right)\right)
$$

と再びデータ点$X_i$についての平均を確率変数$X$に置き換えられる．さらに変形を続けて

$$
E[(\hat{p}(x) - E[\hat{p}(x)])^2]  = \frac{1}{n}\left\{E\left[\left(\frac{1}{h}K\left(\frac{x-X}{h}\right)\right)^2\right] - E\left[\frac{1}{h}K\left(\frac{x-X}{h}\right)\right]^2\right\} \\ = \frac{1}{nh}\int K(u)^2f(x-hu)du - \frac{1}{n}\left[\int K(u)f(x-hu)du \right]^2
$$

と$X$に関する積分を得る．$f$を$x$の周りでテイラー展開することを考えよう．

仮定から$n\to\infty$で$h\to 0$なので，最高次は第一項の展開一項目の$1/nh$の項である．次の次数は第一項の展開二項目および第二項の展開一項目の$1/n$である．従って，

$$
E[(\hat{p}(x) - E[\hat{p}(x)])^2]  = \\  = \frac{f(x)}{nh}\int K(u)^2du + o(1/n) 
$$

と評価できる．

以上バイアスとバリアンスを足し合わせて，最小二乗誤差は

$$
\text{MSE}(\hat{f}(x), h) = \frac{f(x)}{nh}\int K(u)^2du + \frac{h^4}{4}\left(\frac{d^2f(x)}{dx^2}\int u^2K(u)du\right)^2 + o(1/n) + o(h^6)
$$

となる．両辺$x$で積分して

$$
\text{IMSE}(\hat{p}(x), h) \simeq \frac{1}{nh}\int K(u)^2du + \frac{h^4}{4}\int\left(\frac{d^2p(x)}{dx^2}\int u^2K(u)du\right)^2 dx 
$$

である．与えられた$n$に対してこれを最小にするような$h$を求めれば良い．両辺を$h$で微分して

$$
\frac{d\text{IMSE}(\hat{p}(x), h)}{dh} = \frac{-1}{nh^2}\int K(u)^2du + h^3 \int\left(\frac{d^2p(x)}{dx^2}\int u^2K(u)du\right)^2 dx + \cdots
$$

が$0$であれば良いから，求める$h$は

$$
h^* = \frac{1}{n^{1/5}}\left(\frac{\int K(u)^2du}{\int (f''(x))^2 dx \left(\int u^2K(u)du\right)^2}\right)^{1/5}
$$

で与えられる．$n^{-1/5}$の依存性はこのように出現する．

ただし分母に 真の確率密度の二階微分$f''(x)$ が入っているので，これを何らかの方法で評価する必要があり，前述のクロスバリデーションやヒューリスティクスを用いて係数を決める必要がある．ScottやSilvermanのルールはこの係数を与えるものと解釈できる．

### 多次元への拡張

$d$ 次元のデータ $\mathbf{x}_1, \mathbf{x}_2, \ldots, \mathbf{x}_n$ に対しては：

$$
\hat{f}(\mathbf{x}) = \frac{1}{n} \sum_{i=1}^{n} K_\mathbf{H}(\mathbf{x} - \mathbf{x}_i)
$$

ここで、$\mathbf{H}$ はバンド幅行列で、多変量ガウシアンカーネルは：

$$
K_\mathbf{H}(\mathbf{u}) = \frac{1}{(2\pi)^{d/2}|\mathbf{H}|^{1/2}} \exp\left(-\frac{1}{2}\mathbf{u}^T\mathbf{H}^{-1}\mathbf{u}\right)
$$

で与えられる．

## 実装例（スクラッチ）

`scipy.stats`ライブラリの`gaussian_kde`関数に実装があるので実務上はこれを利用すれば良いが，基本的な一次元KDEについて簡単なスクラッチ実装を示そう．

```bash
import numpy as np
import matplotlib.pyplot as plt
from typing import Callable, Union

class KDE1D:
    """
    一次元カーネル密度推定（KDE）のスクラッチ実装
    """
    
    def __init__(self, data: np.ndarray, bandwidth: float = None, kernel: str = 'gaussian'):
        """
        パラメータ:
        data: 観測データ (1次元配列)
        bandwidth: バンド幅（帯域幅）。Noneの場合はScott's ruleで自動計算
        kernel: カーネル関数の種類 ('gaussian', 'epanechnikov', 'uniform')
        """
        self.data = np.array(data)
        self.n = len(self.data)
        
        # バンド幅の設定（Scott's rule）
        if bandwidth is None:
            self.bandwidth = self._scotts_rule()
        else:
            self.bandwidth = bandwidth
            
        # カーネル関数の設定
        self.kernel_name = kernel
        self.kernel_func = self._get_kernel_function(kernel)
    
    def _scotts_rule(self) -> float:
        """
        Scott's ruleによるバンド幅の自動計算
        h = n^(-1/5) * σ
        """
        return np.std(self.data) * (self.n ** (-1/5))
    
    def _get_kernel_function(self, kernel: str) -> Callable:
        """カーネル関数を取得"""
        kernels = {
            'gaussian': self._gaussian_kernel,
            'epanechnikov': self._epanechnikov_kernel,
            'uniform': self._uniform_kernel
        }
        
        if kernel not in kernels:
            raise ValueError(f"未対応のカーネル: {kernel}")
        
        return kernels[kernel]
    
    def _gaussian_kernel(self, u: np.ndarray) -> np.ndarray:
        """ガウシアンカーネル: (1/√(2π)) * exp(-u²/2)"""
        return (1 / np.sqrt(2 * np.pi)) * np.exp(-0.5 * u**2)
    
    def _epanechnikov_kernel(self, u: np.ndarray) -> np.ndarray:
        """エパネチニコフカーネル: (3/4) * (1 - u²) for |u| <= 1"""
        result = np.zeros_like(u)
        mask = np.abs(u) <= 1
        result[mask] = 0.75 * (1 - u[mask]**2)
        return result
    
    def _uniform_kernel(self, u: np.ndarray) -> np.ndarray:
        """一様カーネル: 1/2 for |u| <= 1"""
        result = np.zeros_like(u)
        mask = np.abs(u) <= 1
        result[mask] = 0.5
        return result
    
    def evaluate(self, x: Union[float, np.ndarray]) -> Union[float, np.ndarray]:
        """
        指定された点でのKDEの値を計算
        
        KDE(x) = (1/nh) * Σ K((x - xi) / h)
        
        パラメータ:
        x: 密度を推定したい点（スカラーまたは配列）
        
        戻り値:
        推定された密度値
        """
        x = np.array(x)
        original_shape = x.shape
        x = x.flatten()
        
        # 各データ点からの寄与を計算
        densities = np.zeros(len(x))
        
        for i, xi in enumerate(x):
            # 正規化された距離を計算: u = (x - xi) / h
            u = (xi - self.data) / self.bandwidth
            
            # カーネル関数を適用して密度を計算
            kernel_values = self.kernel_func(u)
            densities[i] = np.mean(kernel_values) / self.bandwidth
        
        # 元の形状に戻す
        return densities.reshape(original_shape) if original_shape != () else densities[0]
    
    def plot(self, x_range: tuple = None, n_points: int = 1000, 
             show_data: bool = True, ax=None):
        """
        KDEの結果をプロット
        
        パラメータ:
        x_range: プロット範囲 (min, max)
        n_points: プロット用の点数
        show_data: 元データのヒストグラムを表示するか
        ax: matplotlib axes object
        """
        if ax is None:
            fig, ax = plt.subplots(figsize=(10, 6))
        
        # プロット範囲の設定
        if x_range is None:
            data_range = np.max(self.data) - np.min(self.data)
            margin = data_range * 0.2
            x_range = (np.min(self.data) - margin, np.max(self.data) + margin)
        
        # KDEの計算とプロット
        x_plot = np.linspace(x_range[0], x_range[1], n_points)
        density = self.evaluate(x_plot)
        
        ax.plot(x_plot, density, 'b-', linewidth=2, 
                label=f'KDE ({self.kernel_name}, h={self.bandwidth:.3f})')
        
        # 元データのヒストグラム表示
        if show_data:
            ax.hist(self.data, bins=30, alpha=0.3, density=True, 
                   color='gray', label='データ（正規化ヒストグラム）')
            ax.scatter(self.data, np.zeros(self.n), alpha=0.6, 
                      color='red', s=20, label='観測データ')
        
        ax.set_xlabel('x')
        ax.set_ylabel('密度')
        ax.set_title('一次元カーネル密度推定 (KDE)')
        ax.legend()
        ax.grid(True, alpha=0.3)
        
        return ax

def demo_kde():
    """KDEのデモンストレーション"""
    # サンプルデータの生成（二峰性分布）
    np.random.seed(42)
    data1 = np.random.normal(-2, 0.8, 150)
    data2 = np.random.normal(3, 1.2, 100)
    data = np.concatenate([data1, data2])
    
    # 異なるバンド幅でのKDE比較
    fig, axes = plt.subplots(2, 2, figsize=(15, 12))
    bandwidths = [0.2, 0.5, 1.0, None]  # None = Scott's rule
    
    for i, bw in enumerate(bandwidths):
        ax = axes[i//2, i%2]
        
        kde = KDE1D(data, bandwidth=bw, kernel='gaussian')
        kde.plot(ax=ax)
        
        title = f"バンド幅 = {kde.bandwidth:.3f}" + \
                (" (Scott's rule)" if bw is None else "")
        ax.set_title(title)
    
    plt.tight_layout()
    plt.show()
    
    # 異なるカーネルでの比較
    fig, axes = plt.subplots(1, 3, figsize=(18, 6))
    kernels = ['gaussian', 'epanechnikov', 'uniform']
    
    for i, kernel in enumerate(kernels):
        kde = KDE1D(data, kernel=kernel)
        kde.plot(ax=axes[i])
        axes[i].set_title(f'{kernel.capitalize()} カーネル')
    
    plt.tight_layout()
    plt.show()

if __name__ == "__main__":
    # 使用例
    print("=== 一次元KDE実装デモ ===")
    
    # 簡単な例
    sample_data = np.random.normal(0, 1, 100)
    kde = KDE1D(sample_data)
    
    print(f"データ数: {len(sample_data)}")
    print(f"自動計算されたバンド幅: {kde.bandwidth:.4f}")
    
    # 特定の点での密度推定
    test_points = [-1, 0, 1]
    for point in test_points:
        density = kde.evaluate(point)
        print(f"x={point}での推定密度: {density:.4f}")
    
    # デモの実行
    demo_kde()
```

## 実装例（scipyの利用方法）

次に，実用上重要なscipyのgaussian_kdeを利用する方法を簡単に紹介する．詳細はライブラリのドキュメントを参照すること．

### 基本的な1次元KDE

```python
import numpy as np
import matplotlib.pyplot as plt
from scipy.stats import gaussian_kde

# サンプルデータの生成
np.random.seed(42)
data = np.concatenate([np.random.normal(2, 1, 100),
                      np.random.normal(6, 1.5, 100)])

# KDEの計算
kde = gaussian_kde(data)

# 評価点の準備
x_eval = np.linspace(-2, 10, 1000)
density = kde(x_eval)

# 可視化
plt.figure(figsize=(10, 6))
plt.hist(data, bins=30, density=True, alpha=0.7, color='lightblue', label='ヒストグラム')
plt.plot(x_eval, density, 'r-', linewidth=2, label='KDE')
plt.xlabel('値')
plt.ylabel('密度')
plt.title('1次元Gaussian KDE')
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()

```

### 4.3 機械学習結果の可視化

応用例として，機械学習の結果をKDEを利用して可視化することを考えよう．

```python
def plot_ml_results_with_kde(pred_values: np.array, true_values: np.array,
                            feature_names: list = None, save_path: str = None):
    """
    機械学習の予測結果をKDEを使って可視化する関数

    Args:
        pred_values (np.array): 予測値 (n_samples, n_features)
        true_values (np.array): 真値 (n_samples, n_features)
        feature_names (list): 特徴量名のリスト
        save_path (str): 保存パス
    """

    n_features = pred_values.shape[1]

    # デフォルトの特徴量名
    if feature_names is None:
        feature_names = [f'Feature_{i+1}' for i in range(n_features)]

    # データ数が多い場合はサンプリング
    if len(pred_values) > 10000:
        indices = np.random.choice(len(pred_values), 10000, replace=False)
        pred_sample = pred_values[indices]
        true_sample = true_values[indices]
    else:
        pred_sample = pred_values
        true_sample = true_values

    # プロット準備
    fig, axes = plt.subplots(1, n_features, figsize=(5*n_features, 5))
    if n_features == 1:
        axes = [axes]

    for i in range(n_features):
        # KDE計算
        x, y, z = calculate_gaussian_kde_2d(pred_sample[:, i], true_sample[:, i])

        # 散布図
        im = axes[i].scatter(x, y, c=z, s=30, cmap='plasma', alpha=0.8)

        # 理想線（y=x）を追加
        min_val = min(np.min(pred_sample[:, i]), np.min(true_sample[:, i]))
        max_val = max(np.max(pred_sample[:, i]), np.max(true_sample[:, i]))
        axes[i].plot([min_val, max_val], [min_val, max_val], 'r--',
                    linewidth=2, alpha=0.7, label='Perfect prediction')

        # RMSE計算・表示
        rmse = np.sqrt(np.mean((pred_sample[:, i] - true_sample[:, i])**2))
        axes[i].text(0.05, 0.95, f'RMSE = {rmse:.3f}',
                    transform=axes[i].transAxes, verticalalignment='top',
                    bbox=dict(boxstyle='round', facecolor='white', alpha=0.8))

        # 装飾
        axes[i].set_title(f'{feature_names[i]}')
        axes[i].set_xlabel('Predicted')
        axes[i].set_ylabel('True')
        axes[i].grid(True, alpha=0.3)
        axes[i].legend()

        # カラーバー
        plt.colorbar(im, ax=axes[i], label='Density')

    plt.tight_layout()

    if save_path:
        plt.savefig(save_path, dpi=300, bbox_inches='tight')

    plt.show()

# 使用例
# pred_values = your_predicted_values
# true_values = your_true_values
# plot_ml_results_with_kde(pred_values, true_values,
#                         feature_names=['Dipole_X', 'Dipole_Y', 'Dipole_Z'])

```

## 6. まとめ

Gaussian KDEはノンパラメトリックな密度推定のスタンダードな手法であり，今回軽く理論的なところと，実際の実装について触れた．実装の際はscipyの`gaussian_kde`クラスを使用することで簡単にKDEを計算できる．
