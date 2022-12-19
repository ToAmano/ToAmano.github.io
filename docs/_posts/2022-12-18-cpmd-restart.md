---
layout: single
title:  "CPMD.xでのリスタート計算のやり方""
date:   2022-12-18 09:00:00 +0900
categories: physics
tags:
 - linux
 - CPMD
---

## CPMD.xのリスタート計算

第一原理MDのコードであるCPMD.xでは，度々リスタート計算がやりたくなる．例えば座標の最適化を行った後にMD計算をやりたいときや，長時間の計算をやりたいがjobの時間制限によって何回かに計算を分割しないといけない時など．こういう場合にどのようにリスタート計算の設定を行えば良いかについて，最低限のところをマニュアルに沿って簡単にまとめた．

!! :: TODO :: 将来的にはこのポストをページの方へ移植する．


## リスタート計算のオプション

そもそもリスタート計算用に，CPMDは各計算の結果を`RESTART.x`というバイナリファイルに保存する．`x`には数字が入り，`1`から順にカウントアップしていく方式だが，デフォルト設定では`RESTART.1`のみが作成され，これが上書きされていく．また，`LATEST`というテキストファイルには最新の`RESTART.x`ファイルの名前が記述されている．リスタート計算する際には`RESTART.x`から波動関数や原子座標など自分の望む情報をロードして計算を再開することになる．リスタート計算のオプションは`&CPMD`セクションの`RESTART`オプション（マニュアルP99）で指定される．以下のように複数のパラメータがあり，これらを組み合わせて指定する．


- WAVEFUNCTION :: 電子の波動関数
- OCCUPATION   :: 電子の占有状態（free energy functionalで有用らしい？よくわからない）
- COORDINATES  :: 原子座標
- VELOCITIES   :: 原子の速度
- CELL         :: 格子定数
- GEOFILE :: `RESTART.x`からではなく，座標と速度を`GEOMETRY`ファイルから読み込む場合に使用する．
- ACCUMULATORS :: 前回計算のaccumulatorパラメータを引き継ぐ．タイムステップなど．
- HESSIAN      :: 構造最適化に使うヘッセ行列．
- NOSEE        :: 電子のNose-Hoover．
- NOSEP        :: 原子のNose-Hoover．
- NOSEC        :: 格子定数のNose-Hoover．
- LATEST       :: LATESTに格納された`RESTART.x`から計算を再開．

他にもいくつかあるが，使ったことがないので割愛．


## いくつかのシチュエーションでのオプションの指定方法

- 波動関数最適化の再計算
  これはあまり必要ないシチュエーションかもしれないが，波動関数と座標を前回から引き継ぐので
  ```
  RESTART WAVEFUNCTION COORDINATES
  ```
  とする．


- 構造最適化の再計算
  この場合，`HESSIAN`を指定することで前回の計算のヘッセ行列から再スタートできる．
  ```
  RESTART WAVEFUNCTION COORDINATES HESSIAN
  ```

- MD計算を行う場合
  最低限，波動関数，座標，速度をひきつぐ必要があるので
  ```
  RESTART WAVEFUNCTION COORDINATES VELOCITIES
  ```
  の指定が必要．場合によっては座標緩和後の計算で速度はいらない場合もあるかもしれない．
  
  追加で`ACCUMULATORS`を指定するとタイムステップなどが前の計算から一つづきになってくれるので一本の長いトラジェクトリを得たい場合にはこれも指定する．
  ```
  RESTART WAVEFUNCTION COORDINATES VELOCITIES ACCUMULATORS
  ```
  Nose-Hooverサーモスタットを使う場合，サーモスタットのパラメータ（NOSEE，NOSEP，NOSEC）も引き継がないといけない．
  ```
  RESTART WAVEFUNCTION COORDINATES VELOCITIES ACCUMULATORS NOSEE NOSEP NOSEC
  ```
  

## その他有用なオプション

- `RESTART.x`ファイル（や他のトラジェクトリファイル）のディレクトリは`&CPMD`セクションの`FILEPATH`オプションで指定できる．
- `STORE`で何ステップごとに`RESTART.x`に情報を書き込むかを指定できる．
- `RESTFILE`でいくつの`RESTART`ファイルを作成するか決められる．例えば`RESTFILE 4`なら`RESTART.1`から`RESTART.4`まで作成され，それ以上については上書きされる．


## 注意

リスタート計算すると，trajectory系のファイル以外は上書きされて前回の計算の結果はなくなってしまう．一方で`TRAJECTORY`や`ENERGY`などのtrajectory系のファイルは前回の結果の後ろからデータが追加されていく．このようにファイルによって挙動が違う．


## 参考

CPMD v.4.3マニュアル P99,P138
