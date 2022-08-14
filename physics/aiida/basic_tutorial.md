# [AiiDA Basic tutorial](https://aiida.readthedocs.io/projects/aiida-core/en/v2.0.3/intro/tutorial.html#tutorial-basic)

AiiDAはpython上で動くが，python上の簡単な計算のみならず，他の言語で書かれた外部コードの実行や，計算機サーバー上での計算にも対応している．

## python上での簡単な計算の場合

pythonでの簡単な計算でAiiDAのワークフローを体験する．ここではjupyter notebookを利用する．
最初におまじないを書く．

```python
from aiida import load_profile, engine, orm, plugins
from aiida.storage.sqlite_temp import SqliteTempBackend

%load_ext aiida

profile = load_profile(
    SqliteTempBackend.create_profile(
        'myprofile',
        sandbox_path='_sandbox',
        options={
            'warnings.development_version': False,
            'runner.poll.interval': 1
        },
        debug=False
    ),
    allow_switch=True
)
profile
```

AiiDAでは，計算のインプットや計算の手順，計算結果が全てnodeと呼ばれる量で扱われ，このnodeたちがdirected acyclic graph上に表され，保存される．


今回は掛け算をする単純なプログラムを使ってみる．

```python
from aiida import engine

@engine.calcfunction
def multiply(x, y):
    return x * y
```
