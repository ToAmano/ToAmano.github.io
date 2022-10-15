open(FHNDL,">./ut-78-3.d11");
require 'emath.pl';
for($x=1.189453;$x>0;$x+=-0.1){printf FHNDL"(%f,%f)",$x,1.5*($x)**2-1};$x=0;printf FHNDL"(%f,%f)",$x,1.5*($x)**2-1;
close(FHNDL);
