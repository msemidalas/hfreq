import os
import numpy as np
import math
import sys

### Constants ##########
chfcbs = math.exp(-1.63)
c2 = 0.56618
c3 = 1.04382
########################
print('Enter name of molecule, example: python3 hess.py h2o\n')
filename = sys.argv[1]

### Read Hessian Matrices ###
hessHF_Hi = np.loadtxt("%s.HF.def2QZVPPDprime.out.Psi4hessian" % filename,skiprows=0)
hessHF_Lo = np.loadtxt("%s.HF.def2TZVPPDprime.out.Psi4hessian" % filename,skiprows=0)
hessE2_Hi = np.loadtxt("%s.MP2.def2QZVPPDprime.out.Psi4hessian" % filename,skiprows=0)
hessE2_Lo = np.loadtxt("%s.MP2.def2TZVPPDprime.out.Psi4hessian" % filename,skiprows=0)
hessE2_small = np.loadtxt("%s.MP2.def2TZVP.out.Psi4hessian" % filename,skiprows=0)
hessCCSDt_small = np.loadtxt("%s.CCSDt.def2TZVP.out.Psi4hessian" % filename,skiprows=0)
### Operations ###
hessHFCBS = (hessHF_Hi - hessHF_Lo*chfcbs)/(1-chfcbs)
hessE2corr_Hi = (hessE2_Hi - hessHF_Hi)
hessE2corr_Lo = (hessE2_Lo - hessHF_Lo)
hessE2CBS=hessE2corr_Hi + c2*(hessE2corr_Hi - hessE2corr_Lo)
hessECCSDt_MP2 = c3*(hessCCSDt_small - hessE2_small)
hessCBS = hessHFCBS + hessE2CBS + hessECCSDt_MP2
print(hessCBS)
##################
output_filename = filename + "_hessCBS"
np.savetxt(output_filename, hessCBS, fmt="%.10f")

print("Hessian saved in", output_filename)

