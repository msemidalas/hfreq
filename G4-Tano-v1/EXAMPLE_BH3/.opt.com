***, geometry optimization 
gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
GTHRESH, OPTSTEP=1d-5, OPTGRAD=1d-5, ENERGY=1d-11
noorient
charge=
multiplicity=
geomtyp=xyz
geom={
}
MASS,ISO
MASS,PRINT
label1

basis={
include ano-pVQZ.mbas
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
