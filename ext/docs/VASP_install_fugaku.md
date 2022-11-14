

## make.incldeの作成

makefile.includeは[VASPのページ](https://www.vasp.at/wiki/index.php/Makefile.include.fujitsu_a64fx_omp) を参考にして，何箇所か改変してある．

```
# Default precompiler options
CPP_OPTIONS = -DHOST=\"FJ-A64FX\" \
              -DMPI -DMPI_BLOCK=8000 -Duse_collective \
              -DscaLAPACK \
              -DCACHE_SIZE=4000 \
              -Davoidalloc \
              -Dvasp6 \
              -Duse_bse_te \
              -Dtbdyn \
              -Dfock_dblbuf \
              -D_OPENMP

CPP         = cpp -P -traditional-cpp $(CPP_OPTIONS) $*$(FUFFIX) > $*$(SUFFIX)

# N.B.: to cross-compile for A64FX on X86_64 replace mpifrt, frt, fcc, and FCC
#       by mpifrtpx, frtpx, fccpx, and FCCpx, respectively.
FC          = mpifrtpx -Kopenmp,simd_nouse_multiple_structures -X03 -cpp
FCL         = mpifrtpx -Kopenmp,simd_nouse_multiple_structures      -cpp

FREE        = -ffree-form -ffree-line-length-none

FFLAGS      = -Koptmsg=2
OFLAG       = -Kfast
OFLAG_IN    = $(OFLAG)
DEBUG       = -O0 -g
OFLAG_1     = -O1
OFLAG_2     = -O2
OFLAG_3     = -Kfast


# amano
OBJECTS    = fftmpiw.o fftmpi_map.o  fftw3d.o  fft3dlib.o
OBJECTS_O1 += minimax_dependence.o fftw3d.o fftmpi.o fftmpiw.o
OBJECTS_O2 += fft3dlib.o

# OBJECTS     = zdotc.o fftmpiw.o fftmpi_map.o fft3dlib.o fftw3d.o
# OBJECTS_O1 += minimax_dependence.o fftw3d.o fftmpi.o fftmpiw.o
# OBJECTS_O2 += fft3dlib.o


# For what used to be vasp.5.lib
CPP_LIB     = $(CPP)
FC_LIB      = frtpx  -Ksimd_nouse_multiple_structures
CC_LIB      = fccpx -Nclang
CFLAGS_LIB  = -O3
FFLAGS_LIB  = $(OFLAG)
FREE_LIB    = $(FREE)

OBJECTS_LIB = linpack_double.o getshmem.o

# For the parser library
CXX_PARS    = FCCpx -Nclang
LLIBS       = -lstdc++
# add by me
LIBS       += parser
LLIBS      += -Lparser -lparser -lstdc++

##
## Customize as of this point! Of course you may change the preceding
## part of this file as well if you like, but it should rarely be
## necessary ...
##

# BLAS, LAPACK, and SCALAPACK (mandatory)
# add LIBDIR by amano
LIBDIR      =/opt/FJSVxtclanga/tcsds-latest/lib64/
LLIBS      += -L$(LIBDIR) -SSL2BLAMP -SCALAPACK

# HINT: Fujitsu maintains its own fftw fork on GitHub
#       (https://github.com/fujitsu/fftw3)
# FFTW       ?= /path/to/your/fujitsu/fftw3
FFTW       ?= /vol0004/apps/oss/spack-v0.17.0/opt/spack/linux-rhel8-a64fx/fj-4.8.0/fftw-3.3.10-ahea2x5vxlbduq4oxn2jiypicesfnvl2
# LIBS add by amano
TLIBS        = /opt/FJSVxtclanga/tcsds-latest/lib64
LLIBS      += -L$(FFTW)/lib:/opt/FJSVxtclanga/tcsds-latest/lib64  -lfftw3 -lfftw3_omp
INCS        = -I$(FFTW)/include

# HDF5-support (optional but strongly recommended)
#CPP_OPTIONS+= -DVASP_HDF5
#HDF5_ROOT  ?= /path/to/your/hdf5/installation
#LLIBS      += -L$(HDF5_ROOT)/lib -lhdf5_fortran
#INCS       += -I$(HDF5_ROOT)/include

# For the VASP-2-Wannier90 interface (optional)
#CPP_OPTIONS    += -DVASP2WANNIER90
#WANNIER90_ROOT ?= /path/to/your/wannier90/installation
#LLIBS          += -L$(WANNIER90_ROOT)/lib -lwannier
```




## 手順

```
# 1: vaspのトップディレクトリに移動
cd ~/src/vasp.5.4.4 (一例)

# 2: 必要なspackのロード
login6$ . /vol0004/apps/oss/spack/share/spack/setup-env.sh
login6$ spack load fujitsu-mpi@head%fj@4.8.0 arch=linux-rhel8-a64fx
login6$ spack load fujitsu-fftw@1.1.0%fj@4.8.0 arch=linux-rhel8-a64fx

# 一つ上のmakefileを作成して，makeを実行
# この時並列化（make -j 16 all）すると失敗するので並列数1で実行すること．時間は約1時間
make all
```
