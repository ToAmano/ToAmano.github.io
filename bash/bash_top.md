# bash/zsh


## zshの設定ファイル
[zshの外部プラグインまとめ - Qiita](https://qiita.com/mollifier/items/1220c0eeaa93e82f8afc)


[シェル出力に色をつける](https://fhiyo.github.io/2017/11/14/colorize-terminal-output.html)


## 設定ファイルの読み込み
```bash
source file_name

. file_name
```
環境変数とは，変数の中でもbashで`export`されたものを指す．


## 権限
権限には3種類，Read, Write, eXecuteがある．権限はuser,group,othersに対して割り当てられる．

権限の確認には`ls -l`が使える．1+3*3=10個の数字が出てくるが，ファイル種別(d:ディレクトリ，f:ファイル，など）+所有者権限3つ+所有グループ権限3つ+その他に対する権限3つになっている．


`chmod`で権限を変更するやり方は数字によるものと英字によるものがある．

英語でRWXを使用する方法場合
```bash
# UserにX権限を追加
chmod u+x test.sh

# User, Group, Others, Allの4つが使える．
```

一方数字でchmod 644などとするのは，所有者，所有グループ，その他に対する権限を6,4,4で割り当てることを表す．この数字は1:x,2:w,4:rとして足し算で計算する．例えば6=2+4より6=wr．7=1+2+4より7=wrx．


## ディレクトリの容量表示
```bash
# -dで深さ指定
# -hでわかりやすく表示
du -h -d 1 
```

## termの種類
 termの種類は環境変数$termに入っている．
```bash
echo $TERM
#xtermやlinuxなどと帰ってくる．
```

## ファイル，ディレクトリを見つけるfindコマンド
```bash
# find 探すdir -name "file name"
find /test -name "libpmi.so"

# 探すdirの深さは -maxdepthや-mindepthで指定可能．
```

## zero-padding
ワイルドカード展開（ブレース展開）を使う方法が一番楽だが，bash4以上のversionにしか入っていない．
```bash
for i in {001..010}
do 
   echo $i
done
```

## マシンスペックの確認
<!-- https://qiita.com/DaisukeMiyamoto/items/98ef077ddf44b5727c29 -->
```bash
#CPU
cat /proc/cpuinfo

#Memory
cat /proc/meminfo
sudo dmidecode -t memory

#マザーボード
sudo dmidecode -t baseboard

#グラフィック
lspci | grep VGA

#ディスク
df
sudo parted -l
lsblk
ls -la /dev/disk/by-uuid
lspci | grep Ethernet

#カーネルversion
uname -a

#distribution version
lsb_release -r
cat /etc/redhat-release
cat /etc/lsb-release
```


## 自分の環境で使えるシェルの一覧
```bash
cat /etc/shells
```


## ディレクトリ内のファイルの数
```bash
ls -1 | wc -l
```

## 文字コードを調べる
```bash
#https://qiita.com/pugiemonn/items/106749351991037fb606
file --mime hoge.php
```

## あるポート番号のプロセスの確認
```bash
lsof -i -P | grep 8080
```