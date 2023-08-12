***, geometry optimization 
gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
GTHRESH, OPTSTEP=1d-5, OPTGRAD=1d-5, ENERGY=1d-11
noorient
charge=
multiplicity=
geomtyp=xyz
geom={
H        0.000000    0.000000    1.666650 
C        0.000000    0.000000    0.603250 
C        0.000000    0.000000   -0.603250 
H        0.000000    0.000000   -1.666650 
}
MASS,ISO
MASS,PRINT
label1

basis={
include ano-pV5Z.mbas
}
hf
mp2
e2=energy

basis={
include ano-pVTZ.mbas
}
hf
mp2
emp2=energy
ccsd(t)
ehlc=(energy-emp2)
etotal=e2+ehlc
show,e*

optg,startcmd=label1,variable=etotal
