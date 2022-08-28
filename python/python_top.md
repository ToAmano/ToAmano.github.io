# python

## anacondaのinstall

[公式ページ](https://www.anaconda.com/products/distribution)からgraphical installerまたはcommand line installerをダウンロードできる．
<!-- https://repo.anaconda.com/archive/Anaconda3-2022.05-MacOSX-arm64.sh -->

```bash
# コマンドラインインストーラの場合はダウンロード後，以下を実行．
bash /path/to/Anaconda3-2022.05-MacOSX-arm64.sh
```

PATHの設定が自動的に.zshrcに書き込まれているので必要に応じて書き直すべし．

<!--export PATH=~/anaconda3/bin:$PATH -->

## 仮想環境の構築

pythonを使う場合，プロジェクトごとに仮想環境を作成し，そこにプロジェクトごとにpythonと必要なパッケージをインストールしていくのが主流．例えばプロジェクトごとに違うバージョンのpythonが使いたい時にも，仮想環境をコマンド一つで切り替えれられるのでとても便利．


## 計算科学で使えるパッケージ

0. [seekpath](https://seekpath.readthedocs.io/en/latest/maindoc.html)

    Kpathを探したい場合．パッケージ自体を使うことも可能だが，以下に示す他のパッケージでもエンジンとして利用されておりそちらを使う方が便利だと思う．

1. [pymatgen](pymatgen.md)


2. [ase](ase.md)



## その他

自作モジュールのパッケージ化．CLIも含めることができる．
<!-- https://gist.github.com/3panda/7508508a89bd1ea1990217142eaf3c9c  -->
<!-- https://qtatsu.hatenablog.com/entry/2021/01/03/171032 -->

docstring
<!-- https://qiita.com/simonritchie/items/49e0813508cad4876b5a -->


コーディングスタイル
<!-- https://peps.python.org/pep-0008/#imports -->