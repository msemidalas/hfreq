gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
 B         -0.0000000000       -0.0000107613        0.0000000000
 H          0.0000000000        1.1891811079        0.0000000000
 H          1.0298423809       -0.5945851733        0.0000000000
 H         -1.0298423809       -0.5945851733        0.0000000000
}
MASS,ISO
MASS,PRINT

basis={
include ano-pVTZ.mbas
}
hf
mp2
{freq,analytic,print=3;noproject}
