open(FHNDL,">./ut-78-2.d11");
require 'emath.pl';
$x=(3);printf FHNDL"(%s,%f)",'3',($x)**4/10+4*($x)**3/10-7*($x)**2/10-22*($x)/10+24/10;
close(FHNDL);
