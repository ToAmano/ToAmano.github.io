---
layout: single
title:  "wannier90 installation"
date:   2022-09-04 10:03:40 +0900
categories: wannier90 intel
---



## 日付：2022/5/18
## 

## 状況
Quantum Espresso v7.0に付属してくるWannier90をIntel Compilerでinstallしたが，実行時にforttlから警告文が出るのでWannier90だけ別途インストールした．

## 環境


# インストール手順

インストールはmakeを利用して行う．基本的はinstall.READMEに書いてある通り．

```bash
cp ./config/make.inc.ifort ./make.inc
```

make.incは以下．

```bash
#=====================================================
# For Linux with intel version 11/12 on 64bit machines
#=====================================================
F90 = ifort
COMMS=mpi
MPIF90=mpiifort
FCOPTS=-O2
LDOPTS=-O2

#========================================================
# Intel mkl libraries. Set LIBPATH if not in default path
#========================================================

# original
# LIBDIR = /opt/intel/mkl/lib/intel64
#
# modify here for module intel/mkl
LIBDIR = ${MKLROOT}/lib/intel64
LIBS   =  -L$(LIBDIR) -lmkl_core -lmkl_intel_lp64 -lmkl_sequential -lpthread

#=======================
# ATLAS Blas and LAPACK
#=======================
#LIBDIR = /usr/local/lib
#LIBS = -L$(LIBDIR)  -llapack -lf77blas -lcblas -latlas
```

環境にあわせて`LIBDIR` を変更する．

```bash
echo ${MKLROOT}
/home/local/intel/compilers_and_libraries_2020.4.304/linux/mkl
```

LIBSのところは多分intel link advisorを利用しても良いと思う．

makeの実行

```bash
make all -j 4
```

## 注意：pw2wannier90.xについて
make allではpw2wannierはinstallできない．そこでpw2wannier90.xについてはQE付属のものを利用する．詳細はQEのinstallのページを参照．
