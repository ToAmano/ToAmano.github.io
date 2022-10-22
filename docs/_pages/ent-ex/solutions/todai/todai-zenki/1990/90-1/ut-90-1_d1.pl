open(FHNDL,">./ut-90-1_d1.dta");
require 'emath.pl';
$xl=(-.2);$xr=(1.2);$trueymax=1.2;$trueymin=-.2;for($x=($xr+$xl)/2;$xr-$xl>0.0001;$x=($xr+$xl)/2){$y=($x)*($x); if ($y<$trueymax && $y>$trueymin){$xr=$x;}else {$xl=$x;}}; printf FHNDL"%f\n",$xr; $x=$xr;$y=($x)*($x); printf FHNDL"(%f,%f)\n",$x,$y;
close(FHNDL);
