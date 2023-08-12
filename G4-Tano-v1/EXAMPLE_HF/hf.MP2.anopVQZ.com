gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
 F          0.0000000000        0.0000000000        0.0927016595
 H          0.0000000000        0.0000000000       -0.8253166595
}
MASS,ISO
MASS,PRINT

basis={
include ano-pVQZ.mbas
}
hf
mp2
{freq,analytic,print=3;noproject}

