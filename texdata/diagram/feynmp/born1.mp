% born1.mp -- do not edit, generated automatically by diagram.tex
input feynmp
require_RCS_revision "1.30";
beginchar(1, 40*2.84526pt#, 25*2.84526pt#, 0);
"feynmf: 1";
LaTeX_unitlength:=2.84526pt;
subgraph (0, 0, w, h);
vinit;
pickup pencircle scaled thin;
vtop (__i1, __o1);
vbottom (__i, __o);
vconnect ("fermion", __i, __v1, __v2, __o);
vconnect ("phantom", __i1, __p1);
vconnect ("phantom", __o1, __p2);
vconnect ("fermion,left,tension=0.8", __p1, __p2);
vconnect ("fermion,left,tension=0.8", __p2, __p1);
vconnect ("photon", __v1, __p1);
vconnect ("photon", __p2, __v2);
vdot (__v1, __v2, __p1, __p2);
vfreeze;
vdraw;
endsubgraph;
endchar;
% the end.
end.
endinput;
