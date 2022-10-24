% 4vertex.mp -- do not edit, generated automatically by diagram.tex
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
vpolygonn ("shaded", __z, 4);
vconnect ("dbl_plain_arrow", __l2, __z3);
vconnect ("dbl_plain_arrow", __l1, __z4);
vconnect ("dbl_plain_arrow", __z1, __r1);
vconnect ("dbl_plain_arrow", __z2, __r2);
vfreeze;
vdraw;
vvertexn ("d.siz=2thick,d.sh=circle", __z, 4);
vfreeze;
vdraw;
endsubgraph;
endchar;
% the end.
end.
endinput;
