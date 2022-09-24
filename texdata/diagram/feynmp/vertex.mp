% vertex.mp -- do not edit, generated automatically by diagram.tex
input feynmp
require_RCS_revision "1.30";
beginchar(1, 40*2.84526pt#, 40*2.84526pt#, 0);
"feynmf: 1";
LaTeX_unitlength:=2.84526pt;
subgraph (0, 0, w, h);
vinit;
pickup pencircle scaled thin;
pickup pencircle scaled thick;
vleftn (__l, 2);
vrightn (__r, 2);
vrpolygonn ("shaded,label=$\Gamma $", __G, 4);
vpolygonn ("empty,label=$K$", __K, 4);
vconnect ("fermion", __l1, __G1);
vconnect ("fermion", __l2, __G2);
vconnect ("fermion", __K1, __r1);
vconnect ("fermion", __K2, __r2);
vconnect ("fermion,left=.5,tension=.5", __G3, __K3);
vconnect ("fermion,right=.5,tension=.5", __G4, __K4);
vfreeze;
vdraw;
endsubgraph;
endchar;
% the end.
end.
endinput;
