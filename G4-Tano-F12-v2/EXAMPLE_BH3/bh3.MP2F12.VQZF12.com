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

basis,vqz-f12
df-hf
df-mp2-f12,ansatz=3*C(FIX,HY1),cabs=0,cabs_singles=0,ri_basis=optri
{freq,print=3;noproject}

