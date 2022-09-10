open(FHNDL,">./ut-79-5.d8");
require 'emath.pl';
$oldx=$x=-1.999023;$oldy=($x);$orgdx=$dx=.05;printf FHNDL"(%f,%f)",$x,$oldy;
for($x=-1.999023;$x<1.999024;$x+=.05){printf FHNDL"(%f,%f)",$x,($x)};$x=1.999024;printf FHNDL"(%f,%f)",$x,($x); 
close(FHNDL);
