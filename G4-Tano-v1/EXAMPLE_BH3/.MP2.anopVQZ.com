gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={

}
MASS,ISO
MASS,PRINT

basis={
include ano-pVQZ.mbas
}
hf
mp2
{freq,analytic,print=3;noproject}

