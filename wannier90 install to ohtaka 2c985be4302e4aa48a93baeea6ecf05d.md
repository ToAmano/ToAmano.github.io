# wannier90 install to ohtaka

2022/5/18 wannier90をohtakaへinstall

# インストール手順

インストールの手順は単純だった．基本的はinstall.READMEに書いてある通り．

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

今回は`LIBDIR` をmodule load intelに対応する形に変更．ちなみにMKLROOTは自動でloadされていた．

```bash
echo ${MKLROOT}
/home/local/intel/compilers_and_libraries_2020.4.304/linux/mkl
```

LIBSのところは多分intel link advisorを利用しても良いと思う．

makeの実行

```bash
make all -j 4
```

## pw2wannier90.xのコンパイル

make allではpw2wannierはinstallできない．そこでpw2wannier90.xについてはQE付属のものを利用する．詳細はQEのinstallのページを参照．

↓ これをmakefileに追加しても失敗した．残念．

pw2wannier: objdir serialobjs
(cd $(ROOTDIR)/pwscf/v6.4 && $(MAKE) -f $(REALMAKEFILE) pw2wannier)