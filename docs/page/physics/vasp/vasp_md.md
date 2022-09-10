

# VASPでの第一原理MD計算のやり方

## 入力/出力ファイル
[VASPのマニュアル](https://www.vasp.at/wiki/index.php/Category:Molecular_dynamics)も確認してください．

標準的な分子動力学計算の入力ファイルは、INCARにいくつかMD用のフラグが必要なことを除けば他の計算方法と同じだが，POSCARファイルには、構造データに加えて、初期速度を別のブロックとして含めることができる．また、原子位置の拘束を行うかどうかの入力も可能である．

拘束分子動力学とバイアス分子動力学（Constrained molecular dynamics, Metadynamics and Biased molecular dynamics）には、ICONSTファイルという追加の入力ファイルが必要で，このファイルは集団変数を指定する．(ICONST)ファイルは、幾何学的パラメータのモニタリング(Monitoring geometric parameters)にも必要である．

主な出力ファイルである`OUTCAR`と`OSZICAR`の他に、MDトラジェクトリを含む`XDATCAR`が重要な出力ファイルである．分子動力学計算のもう一つの重要な出力ファイルは `REPORT` ファイルで，このファイルには様々な重要な情報が含まれており、特に`ICONST`ファイルを使用した計算では重要である．


## INCARファイルで必要な設定
[VASPのページ](https://www.vasp.at/wiki/index.php/Molecular_dynamics_calculations)も確認してください．

まず，MDを実行するにあたり欠かせない設定が以下の3つである．
1. IBRION=0 :: MD計算を実行
2. POTIM    :: MDの時間ステップをfs単位で指定.
3. NSW      :: 分子動力学計算で実行するステップ数 

追加でサーモスタットに関する項目の設定がある．
4. MDALGO   :: サーモスタットの種類の決定
5. TEBEG    :: サーモスタットを使用する場合、分子動力学計算を実行する温度をK単位で指定． 
6. ISIF     :: NVTアンサンブルまたはNpTアンサンブルを選択する場合に必要.



## 出力ファイルの活用
MD計算で得られたXDATCARを利用して真面目な計算をする前に，計算が正常に行われているか確認することが必要である．OUTCARやREPORTファイルからこれらの情報を抽出して計算をモニタリングすることが可能である．

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

# visualizing by gnuplot
gnuplot -e "set terminal jpeg; set xlabel 'N_{step}'; set ylabel 'Temperature (K)';set style data lines; plot 'temperature.dat' u 0:2" > temperature.jpg
```

3. MDトラジェクトリの可視化
XDATCARファイルの軌跡を可視化するには，XDATCARファイルを直接可視化する方法と，一旦他の形式に変換してから可視化する方法がある．XDATCARファイルを直接可視化する簡単な方法はVMDソフトウェアを利用する方法．
VMD → File → New Molecule → Filenameの指定．Determine file typeでは`VASP_XDATCAR5`を指定する．


もう一つの方法はpythonのASE環境を利用する方法である．この方法なら単に可視化するだけでなく，その後の後処理もできる．`ase.io.vasp.read_vasp_xdatcar`関数によって`XDATCAR`ファイルを読み込む．第一変数に`XDATCAR`ファイルを指定し，第二変数にどのステップ数の構造を取り出すかを指定する．`index=0`とした場合には全ての構造を取り出してくれるので，これによってMDステップの数のAtomオブジェクトがリストとして返ってきてでさまざまな処理が可能である．可視化する場合は，このリストを`ase.visualize.view`に渡せば良い．

```python
from ase.io.read import read_vasp_xdatcar
from ase.visualize import view
# atomsを読み込み．全ての構造を取り出すにはindex=0とする．
atoms=read_vasp_xdatcar("XDATCAR",index=0)
view(atoms)
```


## XDATCARファイルの他の形式への変換



## 参考文献
[XDATCARの可視化について](https://mattermodeling.stackexchange.com/questions/3589/how-can-i-visualize-the-trajectory-of-a-vasp-simulation)