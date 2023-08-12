gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
 F          0.0000000000        0.0000000000        0.0926208203
 H          0.0000000000        0.0000000000       -0.8252358203
}
MASS,ISO
MASS,PRINT

basis,vqz-f12
df-hf
df-mp2-f12,ansatz=3*C(FIX,HY1),cabs=0,cabs_singles=0,ri_basis=optri
{freq,print=3;noproject}

