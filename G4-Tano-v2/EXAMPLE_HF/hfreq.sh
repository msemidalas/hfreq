#!/bin/bash
read -p 'Enter filename (Cartesian Coordinates should be used with charge and spin multiplicity specified on first line, e.g. h2.xyz): ' myfilename
#Remove 'xyz' file extension:
myfilename="${myfilename%.*}"
echo "$myfilename"

splice_geometry() {
  tail -n +2 "$myfilename".xyz >> "$myfilename".opt.com
}

split_first_line() {
  local line="$1"
  read charge multiplicity <<<"$line"
}

while IFS= read -r line; do
    if [ -z "$charge" ] && [ -z "$multiplicity" ]; then
        split_first_line "$line"
    else
        echo "$line"
    fi
done < "$myfilename"

echo "Charge: $charge"
echo "Multiplicity: $multiplicity"

cat << EOF > $myfilename'.opt.com' 
***, geometry optimization 
gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
GTHRESH, OPTSTEP=1d-5, OPTGRAD=1d-5, ENERGY=1d-11
noorient
charge=$charge
multiplicity=$multiplicity
geomtyp=xyz
geom={
EOF

splice_geometry

cat << EOF >> $myfilename'.opt.com' 
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
EOF


################################
# MP2/ano-pV5Z force constants #

cat << EOF > "$myfilename".MP2.anopV5Z.com
gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
}
MASS,ISO
MASS,PRINT

basis={
include ano-pV5Z.mbas
}
hf
mp2
{freq,analytic,print=3;noproject}

EOF

################################
# MP2/ano-pVTZ force constants #

cat << EOF > "$myfilename".MP2.anopVTZ.com
gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
}
MASS,ISO
MASS,PRINT

basis={
include ano-pVTZ.mbas
}
hf
mp2
{freq,analytic,print=3;noproject}
EOF

####################################
# CCSD(T)/ano-pVTZ force constants #

cat << EOF > "$myfilename".CCSDt.anopVTZ.com
gthresh,energy=1d-12,gradient=1d-6,twoint=1d-18,prefac=1d-20
noorient
charge=0
multiplicity=1
geomtyp=xyz
geom={
}
MASS,ISO
MASS,PRINT

basis={
include ano-pVTZ.mbas
}
hf
ccsd(t)
{freq,print=3;noproject}
EOF

# Geometry Optimization #
echo 'Geometry optimization is running'
runmolpro-es "$myfilename".opt.com 8 1 1500

optgeomfilename="${myfilename}.opt.out"
output_file_geom="${optgeomfilename}.optimizedgeom.xyz"

awk '/Current geometry \(xyz format, in Angstrom\)/ { inside = 1; batch = ""; next }
     inside { batch = batch $0 "\n"; if (/^\s*\*\*\*/) { inside = 0; last_batch = batch } }
     END { print last_batch }' "$optgeomfilename" > tmp && mv tmp "$output_file_geom"
grep '[a-zA-Z]' "$output_file_geom" > tmp && mv tmp "$output_file_geom"
sed -i '/CCSD(T)/d' "$output_file_geom"

echo 'Optimized geometry was extracted'

awk -v geomfile="$output_file_geom" '/geom={/ { print; while ((getline < geomfile) > 0) print; close(geomfile); next } 1' "$myfilename.MP2.anopV5Z.com" > tmp && mv tmp "$myfilename.MP2.anopV5Z.com"
awk -v geomfile="$output_file_geom" '/geom={/ { print; while ((getline < geomfile) > 0) print; close(geomfile); next } 1' "$myfilename.MP2.anopVTZ.com" > tmp && mv tmp "$myfilename.MP2.anopVTZ.com"
awk -v geomfile="$output_file_geom" '/geom={/ { print; while ((getline < geomfile) > 0) print; close(geomfile); next } 1' "$myfilename.CCSDt.anopVTZ.com" > tmp && mv tmp "$myfilename.CCSDt.anopVTZ.com"

# Submit jobs#
echo 'Force constants will be calculated'
./runmolpro-es "$myfilename".MP2.anopV5Z.com 8 1 1500
./runmolpro-es "$myfilename".MP2.anopVTZ.com 8 1 1500
./runmolpro-es "$myfilename".CCSDt.anopVTZ.com 8 1 1500

python3 convert_hessian_MOLPRO_to_Psi4.py "$myfilename".CCSDt.anopVTZ.out
python3 convert_hessian_MOLPRO_to_Psi4.py "$myfilename".MP2.anopVTZ.out
python3 convert_hessian_MOLPRO_to_Psi4.py "$myfilename".MP2.anopV5Z.out

python3 hessian_G4-anoT-mp2_anopV5Z.py "$myfilename"

cat << EOF > "$myfilename".CCSDt.anopVTZ.com

EOF

splice_geom_for_freq() {
cat "$myfilename".opt.out.optimizedgeom.xyz >> "$myfilename".freq.in
}

cat > "$myfilename".freq.in << "EOF"
import math
set_memory(15000000000)
mymol = psi4.geometry("""
EOF
splice_geom_for_freq

cat >> "$myfilename".freq.in << EOF
  symmetry c1
""")

hessian=np.loadtxt("${myfilename}_hessCBS")
molrec = mymol.to_schema(dtype='psi4')
print("MOLRECORD")
print(molrec)
print("Geometry of the molecule is:\n")
geom = np.array(molrec['geom']).reshape((-1, 3))
print(geom)
m = np.array(molrec['mass'])
print("MASS")
print(m)

irrep_labels = mymol.irrep_labels()
projtrans = True
projrot = False
wfn = psi4.core.Wavefunction.build(mymol, "STO-3G")  # dummy, obviously. only used for SALCs
basisset = wfn.basisset()
vibinfo, vibtext = qcdb.vib.harmonic_analysis(hessian, geom, m, basisset, irrep_labels, project_trans=projtrans, project_rot=projrot)
print(vibinfo)
print(vibtext)
EOF

psi4 "$myfilename".freq.in > "$myfilename".freq.out 
echo 'Harmonic frequency calculation terminated'
python3 readoutputfreq.py "$myfilename".freq.out
