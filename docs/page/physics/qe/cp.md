

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
  
