gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
 F          0.0000000000        0.0000000000        0.0927702149
 H          0.0000000000        0.0000000000       -0.8253852149
}
MASS,ISO
MASS,PRINT

basis={
include ano-pV5Z.mbas
}
hf
mp2
{freq,analytic,print=3;noproject}

