open(FHNDL,">./ut-85-1.d9");
require 'emath.pl';
$oldx=$x=-0.499451;$oldy=1;$orgdx=$dx=.05;printf FHNDL"(%f,%f)",$x,$oldy;
for($x=-0.499451;$x<3.999451;$x+=.05){printf FHNDL"(%f,%f)",$x,1};$x=3.999451;printf FHNDL"(%f,%f)",$x,1; 
close(FHNDL);
