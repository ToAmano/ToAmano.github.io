
# workchain

[公式 how to write workflow](https://aiida.readthedocs.io/projects/aiida-core/en/latest/howto/write_workflows.html#how-to-write-workflows)
[公式 how to write error resistant workflow](https://aiida.readthedocs.io/projects/aiida-core/en/latest/howto/workchains_restart.html#how-to-restart-workchain)

自動的に出所を保持するワークフローを書くために、いかに簡単にワークファンクションを使用できるかを示しましたが、ワークファンクションは完璧ではなく、欠点もあることを告白する時が来ました。足し算と掛け算の単純な例では、関数を実行する時間は非常に短いです。しかし、もっとコストのかかる計算を実行するとします。例えば、スケジューラーに提出される実際のCalcJobを実行し、長い時間実行する可能性があると想像してください。もし、連鎖のどこかで、何らかの理由でワークフローが中断されると、すべての進捗が失われます。単に作業関数を連結することによって、いわば'チェックポイント'がありません。

しかし、心配はご無用です。この問題に取り組むために、AiiDAはワークチェーンという概念を定義しています。その名の通り、ワークフローの複数の論理ステップを連鎖させ、それらのステップが正常に完了した時点で、ステップ間の進捗を保存できるようにするための仕組みです。したがって、ワークチェーンは、より高価で複雑な計算を伴うワークフローの部分に適したソリューションと言えます。ワークチェーンを定義するために、AiiDA はWorkChain クラスを提供します。

ワークチェーンの主要な属性は、define() メソッドで設定されるプロセス仕様で定義されます。ここで注意しなければならないのは、ワークチェーンが受け取る入力、その論理的なアウトライン、そして生成するアウトプットを定義していることです。アウトラインの各ステップは、ワークチェーンのクラスメソッドとして実装されています。addステップは、add計算関数を呼び出して最初の2つの整数を加算し、その合計を一時的にコンテキストに格納する。アウトラインの次のステップであるmultiplyは、最初のアウトラインステップで計算され、コンテキストに格納された合計を取り、3番目の入力整数でmultiply計算関数を呼び出す。最後に、結果ステップでは、前のステップで生成された積を取り、ワークチェーンの出力として記録する。このワークチェーンを実行したときの出自は以下のようになる。

## workchainの要素

workchainクラスは以下の要素によって構成されている．

1. define
2. inputs
3. outputs
4. outline
5. exitcode

6. context

outlineがworkchainで一番核心の部分で，文字通りworkchainで実行するべき作業を一覧表示したもの．ここに示されたメソッドを順番に実行していく．この際，間の結果はcontextというものに保持しておくことができる．

入力は、spec.input() メソッドで指定します。input() メソッドの最初の引数は、入力のラベルを指定する文字列で、例えば 'x' などです。valid_type キーワード引数では、入力に必要なノードタイプを指定します。その他のキーワード引数で、開発者が入力のデフォルトを設定したり、入力をデータベースに保存しないことを示したりできます。詳細については、プロセスのトピックのセクションを参照してください。

spec.outline() メソッドを使用して指定する、ワークフローのアウトラインまたはロジック。ワークフローのアウトラインは、WorkChain クラスのメソッドから構築されます。MultiplyAddWorkChainの場合、アウトラインは単純な線形ステップのシーケンスですが、より複雑なワークフローを定義するために、実際のロジックをアウトラインに直接含めることが可能です。詳しくは、ワークチェーンのアウトラインのセクションを参照してください。

出力は、spec.output()メソッドで指定します。このメソッドは、input() メソッドと使い方が非常に似ています。

spec.exit_code() メソッドで指定する、ワークチェーンの終了コード。終了コードは、ワークチェーンの既知の故障モードをユーザーに明確に伝えるために使用される。第1引数と第2引数には、失敗した場合のワークチェーンのexit_status（400）と、開発者が終了コード（ERROR_NEGATIVE_NUMBER）を参照するために使用する文字列を定義する。message キーワード引数を使用して、説明的な終了メッセージを提供することができます。MultiplyAddWorkChainについては、最終結果が負の数でないことを要求しており、これはアウトラインのvalidate_resultステップでチェックされる。





## その他

これは、ワークフロー・プロセスには新しいノードを作成する能力がないためで、この例ではデータの出自が失われている。

新しいワークチェーンを実装するには、WorkChainをサブクラスとする新しいクラスを作成するだけです。新しいクラスには任意の有効なPythonクラス名を付けることができますが、それが何を参照しているかが常にすぐにわかるように、WorkChainで終わるようにすることが慣習になっています。新しいワークチェーンクラスを作成した後、最初に実装する最も重要なメソッドは define() メソッドです。これはクラスメソッドで、開発者はワークチェーンの特性を定義することができます。たとえば、どのような入力を受け、どのような出力を生成し、どのような潜在的な終了コードを返すことができるか、そしてこれらをすべて達成するための論理的なアウトラインを定義することができます。

ここで、AddAndMultiplyWorkChain をワークチェーンの実際の名前に置き換えます。classmethodデコレーターは、このメソッドがクラスメソッド1であり、インスタンスメソッドではないことを示します。2行目はメソッドのシグネチャで、クラス自身のclsと、ProcessSpecのインスタンスとなるspecを受け取ることを指定しています。これは、ワークチェーンの入力、出力、その他の関連プロパティを定義するために使用するオブジェクトである。最後の3行目は非常に重要で、親クラス（この場合はWorkChainクラス）のdefineメソッドを呼び出すことになるからです。



## ifやwhileなどの論理構造を用いる場合

```python
from aiida.engine import if_, while_, return_

spec.outline(
    cls.intialize_to_zero,
    while_(cls.n_is_less_than_hundred)(
        if_(cls.n_is_multitple_of_three)(
            cls.report_fizz,
        ).elif_(cls.n_is_multiple_of_five)(
            cls.report_buzz,
        ).elif_(cls.n_is_multiple_of_three_and_five)(
            cls.report_fizz_buzz,
        ).else_(
            cls.report_n,
        )
    ),
    cls.increment_n_by_one,
)


def initialize_to_zero(self):
    self.ctx.n = 0

def n_is_less_than_hundred(self):
    return self.ctx.n < 100

def n_is_multiple_of_three(self):
    return self.ctx.n % 3 == 0

def n_is_multiple_of_five(self):
    return self.ctx.n % 5 == 0

def n_is_multiple_of_three_and_five(self):
    return self.ctx.n % 3 == 0 and self.ctx.n % 5 == 0

def increment_n_by_one(self):
    self.ctx.n += 1

```

## contextにデータを保持する


## workchainから外部関数を起動する場合

```python
def submit_sub_process(self)
    node = self.submit(SomeProcess, **inputs)  # Here we use `self.submit` and not `submit` from `aiida.engine`
    return ToContext(sub_process=node)
```

## 他のworkchainを(Exposing inputs and outputs)



## workflowに関連するverdiコマンド

```bash
verdi process status 186
```

## QEのworkchainについて

特にQEでworkchainを自作する場合，既にQEで便利なクラス作ってくれてあるのでこれを活用するのが良い．別ページにまとめたのでそちらを参照．

[QE workchain](aiida_qe_workchain.md)