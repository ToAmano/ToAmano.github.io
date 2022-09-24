% fock-vertex.mp -- do not edit, generated automatically by diagram.tex
input feynmp
require_RCS_revision "1.30";
beginchar(1, 40*2.84526pt#, 25*2.84526pt#, 0);
"feynmf: 1";
LaTeX_unitlength:=2.84526pt;
subgraph (0, 0, w, h);
vinit;
pickup pencircle scaled thin;
vleft (__i);
vright (__o);
vconnect ("fermion", __i, __v1, __v2);
vconnect ("fermion", __v3, __o);
vconnect ("photon,left,tension=1/3", __v1, __v4);
vdot (__v1);
vpolygon ("default,filled=full", __v4, __v2, __v3);
vfreeze;
vdraw;
endsubgraph;
endchar;
% the end.
end.
endinput;
