gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
 H          0.0000000000        0.0000000000        0.7204855536
 H          0.0000000000        0.0000000000       -0.0204855536
}
MASS,ISO
MASS,PRINT

basis,def2-QZVPPD,h=def2-QZVPP
hf
mp2
{freq,analytic,print=3;noproject}

