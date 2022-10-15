open(FHNDL,">./ut-90-1_d3.dta");
require 'emath.pl';
$oldx=$x=0.5;$oldy=($x)*($x);$orgdx=$dx=.05;printf FHNDL"(%f,%f)",$x,$oldy;
for($x=0.5;$x<0.84999;$x+=.05){printf FHNDL"(%f,%f)",$x,($x)*($x)};$x=0.84999;printf FHNDL"(%f,%f)",$x,($x)*($x);
close(FHNDL);
