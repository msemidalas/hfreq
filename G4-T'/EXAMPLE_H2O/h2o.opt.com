***, geometry optimization 
gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
GTHRESH, OPTSTEP=1d-5, OPTGRAD=1d-5, ENERGY=1d-11
noorient
charge=
multiplicity=
geomtyp=xyz
geom={
O          0.0000000000        0.0000000000        0.1172810078
H          0.0000000000        0.7568536811       -0.4709065039
H          0.0000000000       -0.7568536811       -0.4709065039
}
MASS,ISO
MASS,PRINT
label1

basis,def2-TZVPPD,h=def2-TZVPP
hf
enerhflow=energy
mp2
e2low=energy-enerhflow
basis,def2-QZVPPD,h=def2-QZVPP
hf
enerhfhi=energy
mp2
e2hi=energy-enerhfhi
basis,def2-TZVP
hf
ccsd(t)
ehlc=1.04609*(energy-emp2)
cue=exp(-1.63d0)
ehfcbs=(enerhfhi-enerhflow*cue)/(1d0-cue)
e2cbs=e2hi+0.56618*(e2hi-e2low)
etotal=ehfcbs+e2cbs+ehlc

optg,startcmd=label1,variable=etotal
