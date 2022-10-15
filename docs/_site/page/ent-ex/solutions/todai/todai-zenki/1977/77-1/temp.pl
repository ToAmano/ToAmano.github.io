open(FHNDL,">./ut-77-1.d8");
require 'emath.pl';
for($x=1/3;$x<1;$x+=0.05){printf FHNDL"(%f,%f)",$x,-1+3*($x);$x+=0.02;printf FHNDL"(%f,%f)\n",$x,-1+3*($x);$x-=0.02}
close(FHNDL);
