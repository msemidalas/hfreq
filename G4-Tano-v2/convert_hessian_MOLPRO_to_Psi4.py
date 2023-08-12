import pandas as pd
import numpy as np
import re
import sys
import os
#########################################################
# READ HESSIAN FROM MOLPRO OUTPUT FILE
#print('Enter name of MOLPRO output file, example: python3 hessian_MOLPRO16_to_Psi4.py h2o_HFdef2TZVPPD.log\n')
filename = sys.argv[1]
start_line = 'Force Constants (Second Derivatives of the Energy)'
end_line = 'Atomic Masses'

content = ''

with open(filename, 'r') as file:
    read_content = False
    for line in file:
        if start_line in line:
            read_content = True
        elif end_line in line:
            break
        elif read_content:
            content += line

lines = content.strip().split('\n')
filtered_lines = [line.strip() for line in lines if '.' in line]
filtered_content = '\n'.join(filtered_lines)
filtered_content = re.sub(r'(\s)\s+', r'\1', filtered_content)

#######################################################3
# CONVERT HESSIAN FROM MOLPRO TO PSI4 FORMAT
lines = filtered_content.strip().split('\n')

output_table = []
current_group = None

for line in lines:
    line = line.strip()
    fields = line.split(' ')
    group = fields[0]
    values = fields[1:]

    if group != current_group:
        output_row = [group] + values
        output_table.append(output_row)
        current_group = group
    else:
        output_table[-1][1:] += values

for row in output_table:
    row[1:] = [float(value) for value in row[1:]]

output_df = pd.DataFrame(output_table)

output_str = output_df.to_string(index=False, header=False, na_rep="")
#print(output_df)

group_dict = {}
for row in output_table:
    group = row[0]
    if group not in group_dict:
        group_dict[group] = row[1:]
    else:
        group_dict[group] += row[1:]

final_output = [[group] + values for group, values in group_dict.items()]

for row in final_output:
    row[1:] = [str(value) if value is not None else 'None' for value in row[1:]]

output_df = pd.DataFrame(final_output)

########################################
num_columns = output_df.shape[1]
num_rows = output_df.shape[0]

# CREATE LOWER (L) DIAGONAL MATRIX
combined_df = output_df.copy()
combined_df = combined_df.apply(pd.to_numeric, errors='coerce')
combined_df = combined_df.iloc[:, 1:]
combined_df = combined_df.fillna(0)

# CREATE UPPER DIAGONAL MATRIX BY TRANSPOSING L MATRIX
COMBINED_DF_TR = combined_df.transpose()
# REINDEX COLUMN/ROWS TO MATCH INDICES WITH L MATRIX
new_column_indices = range(1,num_columns)
COMBINED_DF_TR = COMBINED_DF_TR.set_axis(new_column_indices, axis=1, copy=False)
new_row_indices = range(0, num_rows)
COMBINED_DF_TR = COMBINED_DF_TR.set_index(pd.Index(new_row_indices))
np.fill_diagonal(combined_df.values, 0)
combined_df = combined_df + COMBINED_DF_TR
combined_str = combined_df.to_string(index=False, header=False, na_rep="")
current_directory = os.path.basename(os.getcwd())
combined_df.to_csv('%s.Psi4hessian' % (filename), sep=' ', header=False, index=False, float_format='%.10f')
