open(FHNDL,">./ut-83-6.d10");
require 'emath.pl';
for($x=0.707520;$x>-0.707520;$x+=-0.1){printf FHNDL"(%f,%f)",$x,0.5};$x=-0.707520;printf FHNDL"(%f,%f)",$x,0.5;
close(FHNDL);
