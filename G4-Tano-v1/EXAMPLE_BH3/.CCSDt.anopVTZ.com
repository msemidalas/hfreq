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
include ano-pVTZ.mbas
}
hf
ccsd(t)
{freq,print=3;noproject}
