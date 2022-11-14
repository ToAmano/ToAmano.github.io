

## 富岳へのCPMDのinstall


### 1: モジュールのload

```
spack load fujitsu-fftw@1.1.0%fj@4.8.0 arch=linux-rhel8-a64fx
spack load fujitsu-mpi@head%fj@4.8.0 arch=linux-rhel8-a64fx

# libxcも必要
spack load libxc@4.3.4%fj@4.8.0 arch=linux-rhel8-a64fx
```

libxcについてはpathを明示する．

```
export LIBXC_INCLUDE=`spack location -i libxc@4.3.4`/include
```

### 2: configure

CPMDのトップディレクトリで`./configure.sh`を実行すると`FUGAKU-MPI`と`FUGAKU-MPI-FFTW`という設定が出てくる．今回はFUGAKU-MPI-FFTWを試す．

```
# インストールするディレクトリを作成(option)
mkdir bin/fugau_mpi_fftw

# configureを実行
./configure.sh -SRC=$PWD -DEST=./bin/fugaku_mpi_fftw FUGAKU-MPI-FFTW

# ディレクトリに移動
cd bin/fugaku_mpi_fftw

# MakefileのFFLAGSを以下のように修正(libxcのパスの指定)
FFLAGS = -Kfast,openmp,SVE -X03 -fi -Nlst=t -Kocl -Koptmsg=2 \
           -I${LIBDIR}/libxc/include -I${SRCDIR} -I${OBJDIR} -I${LIBXC_INCLUDE}
		   
# make
make
```

以上で完了．compileには30-1時間程度かかった．
