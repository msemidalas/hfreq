gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
 H          0.0000000000        0.0000000000        1.6666880410
 C          0.0000000000        0.0000000000        0.6035406980
 C          0.0000000000        0.0000000000       -0.6035406980
 H          0.0000000000        0.0000000000       -1.6666880410
}
MASS,ISO
MASS,PRINT

basis={
include ano-pVQZ.mbas
}
hf
mp2
{freq,analytic,print=3;noproject}

