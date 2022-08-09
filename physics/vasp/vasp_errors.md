

## WARNING: PSMAXN for non-local potential too small

[My Community](https://www.vasp.at/forum/viewtopic.php?f=3&t=8370)

[PSMAXN for non-local potential too small](https://www.error.wiki/PSMAXN_for_non-local_potential_too_small)

解決策１：Lower your ENCUT a little bit (in my case from 900 to 870 eV) works.

解決策２：最も硬いPPをPOTCARの一番上に持ってくる．


## WARNING: grid for Broyden might be to small

これはADDGRID=TRUEにしたのが原因．


## ***internal error in SET_INDPW_FULL: insufficient memory (see wave.F safeguard)***

[VASP errors](https://dannyvanpoucke.be/vasp-errors-en/)

[My Community](https://35.234.103.250/forum/search.php?keywords=SET_INDPW_FULL)

[My Community](https://35.234.103.250/forum/viewtopic.php?f=3&t=17510&p=18502&hilit=SET_INDPW_FULL#p18502)


Trying to modify the accuracy settings, or other setting influencing memory usage seem not to resolve this problem. The solution was luckily provided by the [VASPmasters](https://www.vasp.at/index.php/the-vasp-team)
 : decrease the **SYMPREC**
 parameter in the INCAR file to a value of 1e-4. The problem apparently originated in a symmetry-breaking 5th
 digit in the Bravais matrix. In case the error occurs for **HSE06 calculations,** 
this can be due to a too small value of NPAR. Try setting **NPAR = #cores**
 such that NPAR * KPAR = Total number of cores in the calculation. Although tthis is a suggested setting, one may opt to use NPAR=1 as it speeds up calculations significantly.



## BRMIX: very serious problems **The old and the new charge density differ**

[The old and the new charge density differ](https://www.error.wiki/The_old_and_the_new_charge_density_differ)

[](https://www.researchgate.net/post/Anyone_familiar_with_this_error_in_VASP)

[VASP errors](https://dannyvanpoucke.be/vasp-errors-en/)

→ 一つはテトラヘドロン法に起因するエラーのようだ．ただし今回（ルチルTiO2）は関係ない．

もう一つは並列化に起因するエラーで，KPARとNCOREの設定で発生する可能性があるらしい．

- 1つのバンドを計算するコアの数が少ないとエラーが起こりうる．→ NCOREを増やす？（NCOREは1つのバンド計算に使われるCORE数であることに注意！！）
- もしも，「バンドの数/コア数」が小さすぎると（つまりあまりにコア数が多すぎると）この問題が起こることがあり得る．その場合はコア数を減らすことで対応できる可能性あり．



## WARNING in EDDIAG: sub space matrix is not hermitian

HSE06の構造緩和（ISIF=6）で発生

[My Community](https://www.vasp.at/forum/viewtopic.php?t=1192)



## WARNING: Sub-Space-Matrix is not hermitian in DAV

[https://www.error.wiki/Sub-Space-Matrix_is_not_hermitian](https://www.error.wiki/Sub-Space-Matrix_is_not_hermitian)
→ NCORE=16に設定したら治った．

DFPT計算でこのerrorが出る場合．
→ ohtakaでpre-installされているvaspではこのエラーが消せず，結局再インストールしたらうまくいくようになった．



## SCAN+DFPTはsupportされていない

vasp+dfptでの計算 → これはそもそもSCAN+DFPTがsupportされていない．

|      For optimal performance we recommend to set                            |
|        NCORE= 4 - approx SQRT( number of cores)                             |
|      NCORE specifies how many cores store one orbital (NPAR=cpu/NCORE).     |
|      This setting can  greatly improve the performance of VASP for DFT.     |
|      The default,   NCORE=1            might be grossly inefficient         |
|      on modern multi-core architectures or massively parallel machines.     |
|      Do your own testing !!!!                                               |
|      Unfortunately you need to use the default for GW and RPA calculations. |
|      (for HF NCORE is supported but not extensively tested yet)



## ERROR FEXCP: supplied Exchange-correletion table

ナフタレンのDFPT計算中に出現．

[ERROR FEXCP: supplied Exchange-correletion table is too small](https://www.error.wiki/ERROR_FEXCP:_supplied_Exchange-correletion_table_is_too_small)

によるとPOTCARを読み込んでいる時のエラーらしい．geometryが大丈夫か確認を．



## HSEで収束しない場合

[](https://www.researchgate.net/post/Can_anyone_help_with_the_following_issues_about_hse06_hybrid_functional_calculations_using_vasp_535)

ALGOをDからNへ変更する．



## ERROR: approximate vdW methods are not implemented for DF-PT. Use finite differences (IBRION=5|6) instead.



## One or more components of EFIELD_PEAD is too large for comfort@stdout.log

```
|      One or more components of EFIELD_PEAD is too large for comfort, in all |
|      probability you are too near to the onset of Zener tunneling.          |
|                                                                             |
|           e |E dot A_1| =  0.04602  >  1/10 E_g/N_1 =  0.03690              |
|           e |E dot A_2| =  0.00000  >  1/10 E_g/N_2 =  0.03690              |
|           e |E dot A_3| =  0.00000  >  1/10 E_g/N_3 =  0.02460              |
|                                                                             |
|      Possible SOLUTIONS:                                                    |
|       ) choose a smaller electric field                                     |
|       ) use a less dense grid of k-points
```


[EFIELD_PEAD](https://www.vasp.at/wiki/index.php/EFIELD_PEAD)