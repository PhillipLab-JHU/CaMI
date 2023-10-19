1. st_XY_condition.csv -- contains time, XY coordinates, and biological condition number for each short-term trajectory.
The 'st_id' column maps each trajectory to rows in the higher order parameter dataframe (# 2).
Columns are organized follows:
['Biological Condition No.', 'Cell Number', 'Time Point', 'X', 'Y', 'st_id']

2. st_HO_params.csv -- contains raw higher order features, cluster #, sg class, tSNE coordinate, and condition data for each 2.5 hour trajectory.
The 'st_id' column maps each row of this data frame to each trajectory in st_XY_condition.csv.
Columns are organized as follows:
['MSD10', 'MSD100', 'Pp', 'Pnp', 'Dp', 'Dnp', 'Dtot', 'phi', 'st_id',
	  'cluster', 'sg', 'tSNE_x', 'tSNE_y', 'condition', 'condition_name','cell_type']

3. st_HO_params_scaled.csv -- contains Z-score and log-normalized higher order features, cluster #, sg class, tSNE coordinate, and condition data for each 2.5 hour trajectory.
The 'st_id' column maps each row of this data frame to each trajectory in st_XY_condition.csv.
Columns are organized as follows:
['MSD10', 'MSD100', 'Pp', 'Pnp', 'Dp', 'Dnp', 'Dtot', 'phi', 'st_id',
	  'cluster', 'sg', 'tSNE_x', 'tSNE_y', 'condition', 'condition_name','cell_type']

4. lt_XY_condition.csv -- contains time, XY coordinates, and biological condition number for each 8 hour trajectory.
The 'lt_id' column maps each trajectory to rows in the higher order parameter dataframe (# 5).
Columns are organized follows:
['Biological Condition No.', 'Cell Number', 'Time Point', 'X', 'Y', 'lt_id']

5. lt_HO_params.csv -- contains raw higher order features, cluster #, cg class, tSNE coordinate, and condition data for each 8 hour trajectory.
The 'lt_id' column maps each row of this data frame to each trajectory in lt_XY_condition.csv.
Columns are organized as follows:
['MSD10', 'MSD100', 'Pp', 'Pnp', 'Dp', 'Dnp', 'Dtot', 'phi', 'lt_id',
	  'cluster', 'cg', 'tSNE_x', 'tSNE_y', 'condition', 'condition_name','cell_type']

3. lt_HO_params_scaled.csv -- contains Z-score and log-normalized higher order features, cluster #, cg class, tSNE coordinate, and condition data for each 8 hour trajectory.
The 'lt_id' column maps each row of this data frame to each trajectory in lt_XY_condition.csv.
Columns are organized as follows:
['MSD10', 'MSD100', 'Pp', 'Pnp', 'Dp', 'Dnp', 'Dtot', 'phi', 'lt_id',
	  'cluster', 'cg', 'tSNE_x', 'tSNE_y', 'condition', 'condition_name','cell_type']



