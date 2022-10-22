open(FHNDL,">./ut-73-4.d16");
require 'emath.pl';
for($x=0;$x>-0.5;$x+=-0.1){printf FHNDL"(%f,%f)",$x,-1+1/(2+2*($x))};$x=-0.5;printf FHNDL"(%f,%f)",$x,-1+1/(2+2*($x));
close(FHNDL);
