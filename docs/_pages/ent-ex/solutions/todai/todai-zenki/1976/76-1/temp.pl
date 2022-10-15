open(FHNDL,">./ut-76-1.d3");
require 'emath.pl';
$oldx=$x=2;$oldy=(($x)-3)**2;$orgdx=$dx=.05;printf FHNDL"(%f,%f)",$x,$oldy;
for($x=2;$x<3;$x+=.05){printf FHNDL"(%f,%f)",$x,(($x)-3)**2};$x=3;printf FHNDL"(%f,%f)",$x,(($x)-3)**2; 
close(FHNDL);
