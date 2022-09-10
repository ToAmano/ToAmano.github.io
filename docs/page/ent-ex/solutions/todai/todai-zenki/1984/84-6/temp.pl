open(FHNDL,">./ut-84-6.d18");
require 'emath.pl';
for($x=2;$x>1;$x+=-0.1){printf FHNDL"(%f,%f)",$x,2*(($x)-1)**2+2};$x=1;printf FHNDL"(%f,%f)",$x,2*(($x)-1)**2+2;
close(FHNDL);
