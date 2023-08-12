gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
 O          0.0000000000        0.0000000000        0.1172810075
 H          0.0000000000        0.7568536819       -0.4709065037
 H          0.0000000000       -0.7568536819       -0.4709065037
}
MASS,ISO
MASS,PRINT

basis,def2-TZVPPD,h=def2-TZVPP
hf
mp2
{freq,analytic,print=3;noproject}

