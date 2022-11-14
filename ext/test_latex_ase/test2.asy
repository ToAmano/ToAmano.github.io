settings.outformat = "pdf";
settings.render=16;
settings.prc = false;
unitsize(1cm);
import three;

// if(!settings.multipleView) settings.batchView=false;
// settings.tex="pdflatex";
// settings.inlinetex=true;
// deletepreamble();
// defaultfilename="rutile_axis-1";
// if(settings.render < 0) settings.render=4;
// settings.outformat="";
// settings.inlineimage=true;
// settings.embed=true;
// settings.toolbar=false;
viewportmargin=(2,2);


import three;
settings.render=8;
settings.prc=false;
// unitsize(1cm);
size(4cm);

// the camera position
currentprojection = orthographic((3,1,0.5));

//
material sphereCcolor = material(diffusepen=gray, specularpen=white); //material1
material O_color = material(diffusepen=red, specularpen=white); //material1
material cylcolor = material(diffusepen=gray, emissivepen=gray);//material2

// cylinder raduis
real cylRadius = 0.1;
// point radius
real sphereRadius = 0.3;

// draw rod(line)
void drawRod(triple a, triple b) {
surface rod = extrude(scale(cylRadius)*unitcircle, axis=length(b-a)*Z);
triple orthovector = cross(Z, b-a);
if (length(orthovector) > .01) {
real angle = aCos(dot(Z, b-a) / length(b-a));
rod = rotate(angle, orthovector) * rod;
}
draw(shift(a)*rod, surfacepen=cylcolor);
}

// draw carbon(point)
void drawCarbon(triple center) {
draw(shift(center)*scale3(sphereRadius)*unitsphere, surfacepen=sphereCcolor);
}

// draw arrow
void drawArray(triple center, triple end) {
draw(center--end, green, Arrow3);
}


// draw carbon(point)
void drawOCarbon(triple center) {
draw(shift(center)*scale3(sphereRadius)*unitsphere, surfacepen=O_color);
}



//%label("$f$", (a[1]*0.5+b[1]*0.5)+(0.1,0) );
//%label("$p$", ptP, S);
//%label("$f(p)$", ptFp, S);
//%label("$X$", (a[0]+a[2])*0.5+(a[0]-a[2])*0.33+(a[1]-a[3])*0.45 );
//%label("$Y$", (b[0]+b[2])*0.5+(b[0]-b[2])*0.15+(b[1]-b[3])*0.45 );

// variable
real u = 0.304*4;
real c = 0.644*4;

// triple : an ordered triple of real components (x,y,z)
// corner and center (Ti)
triple Ti_a = (0,0,0);
triple Ti_b = (4,0,0);
triple Ti_c = (0,4,0);
triple Ti_d = (4,4,0);
triple Ti_e = (0,0,c);
triple Ti_f = (4,0,c);
triple Ti_g = (0,4,c);
triple Ti_h = (4,4,c);
triple Ti_i = (2,2,c/2);
// O
triple O_a = (2-u,2+u,c/2);
triple O_b = (2+u,2-u,c/2);
triple O_c = (u,u,0);
triple O_d = (4-u,4-u,0);
triple O_e = (u,u,c);
triple O_f = (4-u,4-u,c);

// outside crystal, we need x,y,z axis
triple Origin = (-2,-2,-2);
triple X = (-1,-2,-2);
triple Y = (-2,-1,-2);
triple Z = (-2,-2,-1);



// lines
drawRod(Ti_a,O_c);
drawRod(Ti_d,O_d);
drawRod(Ti_c,O_a);
drawRod(Ti_b,O_b);

drawRod(Ti_e,O_e);
drawRod(Ti_h,O_f);
drawRod(Ti_g,O_a);
drawRod(Ti_f,O_b);



drawRod(Ti_i,O_a);
drawRod(Ti_i,O_b);
drawRod(Ti_i,O_c);
drawRod(Ti_i,O_d);
drawRod(Ti_i,O_e);
drawRod(Ti_i,O_f);



// points
drawCarbon(Ti_a);
drawCarbon(Ti_b);
drawCarbon(Ti_c);
drawCarbon(Ti_d);
drawCarbon(Ti_e);
drawCarbon(Ti_f);
drawCarbon(Ti_g);
drawCarbon(Ti_h);
drawCarbon(Ti_i);
drawOCarbon(O_a);
drawOCarbon(O_b);
drawOCarbon(O_c);
drawOCarbon(O_d);
drawOCarbon(O_e);
drawOCarbon(O_f);



// Frame
material framecolor = material(diffusepen=black); // material3
void drawFrame(triple a, triple b) {
surface rod = extrude(scale(.1*cylRadius)*unitcircle, axis=length(b-a)*Z);
triple orthovector = cross(Z, b-a);
if (length(orthovector) > .01) {
real angle = aCos(dot(Z, b-a) / length(b-a));
rod = rotate(angle, orthovector) * rod;
}
draw(shift(a)*rod, surfacepen=framecolor);
draw(shift(b)*scale3(cylRadius)*unitsphere, surfacepen=framecolor);
}
drawFrame(Ti_a,Ti_b);
drawFrame(Ti_a,Ti_c);
drawFrame(Ti_b,Ti_d);
drawFrame(Ti_c,Ti_d);

drawFrame(Ti_a,Ti_e);
drawFrame(Ti_b,Ti_f);
drawFrame(Ti_c,Ti_g);
drawFrame(Ti_d,Ti_h);


drawFrame(Ti_e,Ti_f);
drawFrame(Ti_e,Ti_g);
drawFrame(Ti_f,Ti_h);
drawFrame(Ti_g,Ti_h);


// axis arrows
drawArray(Origin, X);
//drawArray(Origin, Y);
//drawArray(Origin, Z);


size(113.81102pt,0,keepAspect=true);