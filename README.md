In this repository you will find a collection of Bash and Python scripts tailored for geometry optimization and vibrational harmonic frequency calculations within MOLPRO. These scripts are specifically designed for G4-like composite wave function theories (cWFTs) and we consider the most accurate ones for predicting frequencies.

To get started, follow these steps:

- Ensure you have a Unix or MacOS system available.

- Prepare a molecule.xyz file containing Cartesian coordinates of your molecule. The first line of this file should indicate the charge and multiplicity values.

- Run the provided script by executing the following command:

    bash

    ./hfreq.sh molecule.xyz

Please be aware that the hfreq.sh script utilizes a script called runmolpro-es for running Molpro. Customize this runmolpro-es script to suit your specific system configuration. If this is not feasible, you can alternatively modify the lines in hfreq.sh that reference runmolpro-es with the necessary commands to execute Molpro (e.g., molpro input.inp).
Overview of Energy Expressions

A concise overview follows of energy expressions for various cWFTs that we have reported based on our prior work:

G4-T':

    E = EHF/CBS + [(c1+1)Ecorr,MP2/def2QZVPPD' - c1Ecorr,MP2/def2TZVPPD'] + c2[Ec,CCSD(T)-EMP2]/def2-TZVP

G4-Tano-v1:

    E = EMP2/ano-pVQZ + [Ec,CCSD(T)-EMP2]/ano-pVTZ

G4-Tano-v2:

    E = EMP2/ano-pV5Z + [Ec,CCSD(T)-EMP2]/ano-pVTZ

G4-Tano-F12-v2:

    E = EMP2-F12/cc-pVQZ-F12 + [Ec,CCSD(T)-EMP2]/ano-pVTZ

Several examples are provided in this repository.

**References**

Semidalas E, Martin JML. Canonical and DLPNO-Based G4(MP2)XK-Inspired Composite Wave Function Methods Parametrized against Large and Chemically Diverse Training Sets: Are They More Accurate and/or Robust than Double-Hybrid DFT? J Chem Theory Comput. 2020;16(7):4238-4255. doi:10.1021/acs.jctc.0c00189

Semidalas E, Martin JML. Canonical and DLPNO-Based Composite Wavefunction Methods Parametrized against Large and Chemically Diverse Training Sets. 2: Correlation-Consistent Basis Sets, Core–Valence Correlation, and F12 Alternatives. J Chem Theory Comput. 2020;16(12):7507-7524. doi:10.1021/acs.jctc.0c01106

Semidalas E, Martin JML. Can G4-like Composite Ab Initio Methods Accurately Predict Vibrational Harmonic Frequencies? Mol Phys. 2023. doi:10.1080/00268976.2023.2263593 status: accepted.

Emmanouil Semidalas

email: emmanouil.semidalas@weizmann.ac.il
