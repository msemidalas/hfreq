gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
 B          0.0000000000       -0.0000114383        0.0000000000
 H          0.0000000000        1.1887488537        0.0000000000
 H          1.0294693386       -0.5943687076        0.0000000000
 H         -1.0294693386       -0.5943687076        0.0000000000
}
MASS,ISO
MASS,PRINT

basis,def2-TZVP
hf
ccsd(t)
{freq,analytical,print=3;noproject}
