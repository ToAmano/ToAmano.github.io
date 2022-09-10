# AiiDA  workfunction workflow

workfunctionとworkflowを利用していくつかのジョブをつなげることができる．

参考文献

[ 公式 calcfunction](https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/calculations/concepts.html)
[ 公式 usage](https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/workflows/usage.html#topics-workflows-usage-workchains)
[ プロセス関数](https://aiida.readthedocs.io/projects/aiida-core/en/latest/topics/processes/functions.html#topics-processes-functions)

## workfunction

workfunctionはcalcfunctionのように通常のpythonの関数として実装されているが，機能としては大きく異なる．例としてフィボナッチ数列f(3)を計算する例をかんがえてみよう．このとき我々はf(0)=1,f(1)=1をもとにして，

```markdown
# f(3)の計算
1. f(2)=f(1)+f(0)を計算する．
2. f(3)=f(2)+f(1)を計算する．
```

の二つのステップで計算を行う．このときf(2)とf(3)の計算という個々の計算をcalcfunction，これらステップ1とステップ2を合わせてworkfunctionと呼ぶ．すなわちcalcfunctionとは個々の計算のことであり，workfunctionとは個々の計算のまとまりのことと考えればよい．これをコードとして簡単に描いたのが以下である．

```python
# 論理コード
@calcfunction
def calc_f2(f1,f0):
    return f2

@calcfunction
def calc_f3(f2,f1):
    return f2

@workfunction
def work_f3(f0,f1):
    f2=calc_f2(f0,f1)
    f3=calc_f3(f1,f2)
    return f3
```

AiiDA内ではこの二つは厳密に使い分けられており，実際に以下のような決定的な違いがある．

1. calcfunctionは実際の計算を行い，入力ノードから**新しい出力ノードを作成**する．
1. workfunctionは計算同士のつながりを記述し，**新しいノードを作成することはできない**．

実際にworkfunctionで新しいノードを作成する以下のようなコードはエラーで止まってしまう．

```python
@workfunction
def illegal_workfunction(x, y):
    return Int(x + y)
```

このようにわざわざ二つの機能を厳密に分ける意味は最初のうちはわかりにくいが，論理的な出自を表すこの並列的でありながら異なるワークフロー層を追加することで、計算の詳細をすべて無視することができるようになる．


In addition to the orchestration role that the work function can fullfill, it can also be used as a filter or selection function. Imagine that you want to write a process function that takes a set of input integer nodes and returns the one with the highest value. We cannot employ the calcfunction for this, because it would have to return one of its input nodes, which is explicitly forbidden. However, for the workfunction, returning existing nodes, even one of its inputs, is perfectly fine. An example implementation might look like the following:

