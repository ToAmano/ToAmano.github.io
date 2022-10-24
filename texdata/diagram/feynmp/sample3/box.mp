% box.mp -- do not edit, generated automatically by sample3.tex
input feynmp
require_RCS_revision "1.30";
beginchar(1, 40*2.84526pt#, 20*2.84526pt#, 0);
"feynmf: 1";
LaTeX_unitlength:=2.84526pt;
subgraph (0, 0, w, h);
vinit;
pickup pencircle scaled thin;
vbottom (__i1, __d1, __o1);
vtop (__i2, __d2, __o2);
vconnect ("fermion", __i1, __v1, __v2, __o1);
vconnect ("fermion", __o2, __v4, __v3, __i2);
vconnect ("photon,tension=0", __v1, __v3);
vconnect ("photon,tension=0", __v2, __v4);
vfreeze;
vdraw;
endsubgraph;
endchar;
% the end.
end.
endinput;
