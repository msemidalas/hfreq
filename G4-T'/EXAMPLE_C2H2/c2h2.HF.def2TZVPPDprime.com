gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
 H          0.0000000000        0.0000000000        1.6658381731
 C          0.0000000000        0.0000000000        0.6027502604
 C          0.0000000000        0.0000000000       -0.6027502604
 H          0.0000000000        0.0000000000       -1.6658381731
}
MASS,ISO
MASS,PRINT

basis,def2-TZVPPD,h=def2-TZVPP
hf
{freq,analytic,print=3;noproject}

