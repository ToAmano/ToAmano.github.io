

# VASPでの第一原理MD計算のやり方

## 入力/出力ファイル
[VASPのマニュアル](https://www.vasp.at/wiki/index.php/Category:Molecular_dynamics)も確認してください．

標準的な分子動力学計算の入力ファイルは、INCARにいくつかMD用のフラグが必要なことを除けば他の計算方法と同じです。しかし、POSCARファイルには、構造データに加えて、初期速度を別のブロックとして含めることができます。また、原子位置の拘束を行うかどうかの入力も可能です。

拘束分子動力学とバイアス分子動力学（Constrained molecular dynamics, Metadynamics and Biased molecular dynamics）には、ICONSTファイルという追加の入力ファイルが必要です。このファイルは集団変数を指定する。(ICONST)ファイルは、幾何学的パラメータのモニタリング(Monitoring geometric parameters)にも必要である。

主な出力ファイルである`OUTCAR`と`OSZICAR`の他に、`XDATCAR`が重要な出力ファイルです。これはMDの軌跡を含んでいます。分子動力学計算のもう一つの重要な出力ファイルは `REPORT` ファイルです。このファイルには様々な重要な情報が含まれており、特に`ICONST`ファイルを使用した計算では重要です。



## 出力ファイルの活用
MD計算で得られたXDATCARを利用する前に，計算が正常に行われているか確認することが必要である．OUTCARやREPORTファイルからこれらの情報を抽出して計算をモニタリングすることが可能である．

1. エネルギーの変化

```bash
# extract energy from OUTCAR 
grep "free  energy" OUTCAR|awk ' {print $5}' > energy.dat

# visualizing by gnuplot
gnuplot -e "set terminal jpeg; set xlabel 'N_{step}'; set ylabel 'Total energy (eV/cell)';set style data lines; plot 'energy.dat'" > energy.jpg
```

2. 温度の変化

```bash
# extract temperature from REPORT
grep " tmprt>" REPORT|awk ' {print $2, $3}' > temperature.dat
```
