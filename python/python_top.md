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

