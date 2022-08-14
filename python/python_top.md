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