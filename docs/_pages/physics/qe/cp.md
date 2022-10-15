

# CP.xによるcar-parinello MDのやり方


## 



## visualize trajectory
<!-- https://www.researchgate.net/post/How_to_visualize_output_from_Car-Parrinello_MD_by_quantum_espresso -->



## 主要なinputパラメーター

&ELECTRONS

electron_maxstep | electron_dynamics | conv_thr | niter_cg_restart | efield | epol | emass | emass_cutoff | orthogonalization | ortho_eps | ortho_max | ortho_para | electron_damping | electron_velocities | electron_temperature | ekincw | fnosee | startingwfc | tcg | maxiter | passop | pre_state | n_inner | ninter_cold_restart | lambda_cold | grease | ampre

&IONS

ion_dynamics | ion_positions | ion_velocities | ion_damping | ion_radius | iesr | ion_nstepe | remove_rigid_rot | ion_temperature | tempw | fnosep | tolp | nhpcl | nhptyp | nhgrp | fnhscl | ndega | tranp | amprp | greasp

&WANNIER

wf_efield | wf_switch | sw_len | efx0 | efy0 | efz0 | efx1 | efy1 | efz1 | wfsd | wfdt | maxwfdt | nit | nsd | wf_q | wf_friction | nsteps | tolw | adapt | calwf | nwf | wffort | writev | exx_neigh | exx_dis_cutoff | exx_poisson_eps | exx_use_cube_domain | exx_ps_rcut_self | exx_ps_rcut_pair | exx_me_rcut_self | exx_me_rcut_pair



## error log

- ortho went bananas
    https://lists.quantum-espresso.org/pipermail/users/2009-April/012245.html
  


## 最初の収束計算をpw.xで実行する(restart_example)

- pw.xのprefixの指定方法（"prefix"_51のようにする）
- ガンマ点の指定は`K_POINTS gamma`とする
- it works only for Gamma point, of course
- it is no longer needed to set "wf_collect" to .t.
- the number of bands should be the same for CP and PW
- "prefix" for pw.x = "prefix"_"ndr" or "prefix_ndw" for cp.x

pw.xを実行した後，
```
rm -rf $TMP_DIR/cp_91.save/wfcm1.dat
```
としてwfcm1.datファイルを削除すること．


pw.xから出発するとうまくいかない．．． もしかすると最初にcpからスタートしないとダメかも．

```bash
# molecular dynamics calculation
cat >  sio2.cp.start.in << EOF
 &control
    calculation='cp',
    restart_mode='from_scratch',
    nstep=20, iprint=20, isave=20,
    dt=5.0,
    ndr=90, ndw=91,
    pseudo_dir='$PSEUDO_DIR/',
    outdir='$TMP_DIR/',
    disk_io='high',
 /
 &system
    ibrav=8, celldm(1)=9.28990, celldm(2)=1.73206, celldm(3)=1.09955,
    nat=18, ntyp=2, nbnd=48, nspin=1,
    ecutwfc=20.0, ecutrho=150.0,
    nr1b=16, nr2b=16, nr3b=16,
    qcutz=150., q2sigma=2.0, ecfixed=16.0,
 /
 &electrons
    electron_dynamics='damp', electron_damping=0.2,
    startingwfc='random', ampre=0.01,
    emass=700., emass_cutoff=3.,
 /
 &ions
    ion_dynamics='none',
    ion_radius(1)=1.0, ion_radius(2)=1.0,
 /
ATOMIC_SPECIES
   O  16.00 O.pz-rrkjus.UPF
  Si  28.00 Si.pz-vbc.UPF
ATOMIC_POSITIONS bohr
 O  3.18829368  14.83237039   1.22882961
 O  7.83231469   6.78704039   1.22882961
 O  2.07443467   5.99537992   4.73758250
 O  6.72031366  14.04231898   4.73758250
 O  3.96307134  11.26989826   7.87860582
 O  8.60802134   3.22295920   7.87860582
 O  3.96307134   4.81915267   9.14625133
 O  8.60802134  12.86448267   9.14625133
 O  3.18736469   1.25668055   5.58029607
 O  7.83324368   9.30201055   5.58029607
 O  2.07536366  10.09206195   2.07358613
 O  6.71938467   2.04673195   2.07358613
Si  0.28891589   8.04533000   3.40456284
Si  4.93386589   0.00000000   3.40456284
Si  2.13389003  12.27717358  -0.04188031
Si  6.77884003   4.23184358  -0.04188031
Si  2.13389003   3.81348642   6.85202747
Si  6.77884003  11.85881642   6.85202747
EOF
$ECHO "  Starting the cp.x calculation (with fixed ions)...\c"
$CP_COMMAND -input sio2.cp.start.in > sio2.cp.start.out
$ECHO " done"
```

```bash
#
# Total energy self consistent run
#
cat >  sio2.pw.restart.in << EOF
 &control
    calculation='scf',
    restart_mode='restart',
    prefix = 'cp_91'
    pseudo_dir='$PSEUDO_DIR/',
    outdir='$TMP_DIR/',
 /
 &system
    ibrav=8, celldm(1)=9.28990, celldm(2)=1.73206, celldm(3)=1.09955,
    nat=18, ntyp=2, nbnd=48, nspin=1,
    ecutwfc=20.0, ecutrho=150.0,
    qcutz=150., q2sigma=2.0, ecfixed=16.0,
 /
 &electrons
    mixing_beta = 0.3
    startingpot='file', startingwfc='file'
 /
ATOMIC_SPECIES
   O  16.00 O.pz-rrkjus.UPF
  Si  28.00 Si.pz-vbc.UPF
ATOMIC_POSITIONS (bohr)
 O  3.18829368  14.83237039   1.22882961
 O  7.83231469   6.78704039   1.22882961
 O  2.07443467   5.99537992   4.73758250
 O  6.72031366  14.04231898   4.73758250
 O  3.96307134  11.26989826   7.87860582
 O  8.60802134   3.22295920   7.87860582
 O  3.96307134   4.81915267   9.14625133
 O  8.60802134  12.86448267   9.14625133
 O  3.18736469   1.25668055   5.58029607
 O  7.83324368   9.30201055   5.58029607
 O  2.07536366  10.09206195   2.07358613
 O  6.71938467   2.04673195   2.07358613
Si  0.28891589   8.04533000   3.40456284
Si  4.93386589   0.00000000   3.40456284
Si  2.13389003  12.27717358  -0.04188031
Si  6.77884003   4.23184358  -0.04188031
Si  2.13389003   3.81348642   6.85202747
Si  6.77884003  11.85881642   6.85202747
K_POINTS (gamma)
EOF
$ECHO "  continuing SCF calculation with pw.x...\c"
$PW_COMMAND -input sio2.pw.restart.in > sio2.pw.restart.out
$ECHO " done"


rm -rf $TMP_DIR/cp_91.save/wfcm1.dat
# molecular dynamics calculation
cat > sio2.cp.restart.in << EOF
 &control
    calculation='cp',
    restart_mode='reset_counters',
    nstep=50, iprint=50, isave=50,
    dt=15.0,
    ndr=91, ndw=92,
    pseudo_dir='$PSEUDO_DIR/',
    outdir='$TMP_DIR/',
 /
 &system
    ibrav=8, celldm(1)=9.28990, celldm(2)=1.73206, celldm(3)=1.09955,
    nat=18, ntyp=2, nbnd=48, nspin=1,
    ecutwfc=20.0, ecutrho=150.0,
    nr1b=16, nr2b=16, nr3b=16,
    qcutz=150., q2sigma=2.0, ecfixed=16.0,
 /
 &electrons
    electron_dynamics='damp', electron_damping=0.2,
    emass=700., emass_cutoff=3.,
 /
 &ions
    ion_dynamics='none',
    ion_radius(1)=1.0, ion_radius(2)=1.0,
 /
ATOMIC_SPECIES
   O  16.00 O.pz-rrkjus.UPF
  Si  28.00 Si.pz-vbc.UPF
ATOMIC_POSITIONS bohr
 O  3.18829368  14.83237039   1.22882961
 O  7.83231469   6.78704039   1.22882961
 O  2.07443467   5.99537992   4.73758250
 O  6.72031366  14.04231898   4.73758250
 O  3.96307134  11.26989826   7.87860582
 O  8.60802134   3.22295920   7.87860582
 O  3.96307134   4.81915267   9.14625133
 O  8.60802134  12.86448267   9.14625133
 O  3.18736469   1.25668055   5.58029607
 O  7.83324368   9.30201055   5.58029607
 O  2.07536366  10.09206195   2.07358613
 O  6.71938467   2.04673195   2.07358613
Si  0.28891589   8.04533000   3.40456284
Si  4.93386589   0.00000000   3.40456284
Si  2.13389003  12.27717358  -0.04188031
Si  6.77884003   4.23184358  -0.04188031
Si  2.13389003   3.81348642   6.85202747
Si  6.77884003  11.85881642   6.85202747
EOF
$ECHO "  restarting calculation with cp.x ...\c"
$CP_COMMAND -input sio2.cp.restart.in > sio2.cp.restart.out
$ECHO " done"

$ECHO
$ECHO "$EXAMPLE_DIR : done"
```