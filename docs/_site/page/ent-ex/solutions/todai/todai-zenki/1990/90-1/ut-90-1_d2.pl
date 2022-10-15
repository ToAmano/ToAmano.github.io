open(FHNDL,">./ut-90-1_d2.dta");
require 'emath.pl';
$xl=(0.5);$xr=(1.2);$trueymax=1.2;$trueymin=-.2;for($x=($xr+$xl)/2;$xr-$xl>0.0001;$x=($xr+$xl)/2){$y=($x)*($x); if ($y<$trueymax && $y>$trueymin){$xl=$x;}else {$xr=$x;}}printf FHNDL"%f\n",$xl; $x=$xl;$y=($x)*($x); printf FHNDL"(%f,%f)\n",$x,$y;
close(FHNDL);
