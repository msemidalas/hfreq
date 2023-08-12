gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
 B          0.0000000000       -0.0000107308        0.0000000000
 H          0.0000000000        1.1897675832        0.0000000000
 H          1.0303502879       -0.5948784262        0.0000000000
 H         -1.0303502879       -0.5948784262        0.0000000000
}
MASS,ISO
MASS,PRINT

basis={
include ano-pVTZ.mbas
}
hf
mp2
{freq,analytic,print=3;noproject}
