import os
import numpy as np
import math
import sys

#print('Enter name of molecule, example: python3 hess.py h2o\n')
filename = sys.argv[1]

### Read Hessian Matrices ###
hessE2_hi = np.loadtxt("%s.MP2F12.VQZF12.out.Psi4hessian" % filename,skiprows=0)
hessE2_small = np.loadtxt("%s.MP2.anopVTZ.out.Psi4hessian" % filename,skiprows=0)
hessCCSDt_small = np.loadtxt("%s.CCSDt.anopVTZ.out.Psi4hessian" % filename,skiprows=0)

### Operations ###
hessCBS = hessE2_hi + (hessCCSDt_small - hessE2_small)

##################
output_filename = filename + "_hessCBS"
np.savetxt(output_filename, hessCBS, fmt="%.10f")

print("Hessian saved in", output_filename)
