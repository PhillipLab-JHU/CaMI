In general, the relevant datatsets to run HaLo are shared in the MATLAB data file 'General_Datasets_needed_to_run_HaLo.mat'. All of the code to harmonize trajectories, compute higher order parameters, run k-means clsutering, and predict motility pattern using a SVM classifier was developed in Matlab. The data required for these codes are in "General_Datasets_needed_to_run_HaLO.mat.zip". The interpoalted trajectories, higher order parameters, and derived motility parameters are included in the folder "CaMI_Curated_Data".

Some general variables are explained as follows:
1) 'cell' or 'cell_2_5hrs': raw Higher order parameters calculated for N=24753 and N=74253 cells for 8hrs datasets and 2.5hrs datasets respectively.
The order of the Higher Order parameters = [MSD10, MSD100, Pp, Pnp, Dp, Dnp, Dtot, phi].

2) 'cell_M' or 'cell_M_2_5hrs': Zscore and Log normalized Higher order parameters calculated for N=24753 and N=74253 cells for 8hrs datasets and 2.5hrs datasets respectively
The order of the Higher Order parameters = zscore(log([MSD10, MSD100, Pp, Pnp, Dp, Dnp, Dtot, phi])).

3) 'global_actual_8hrs_mod' or 'global_actual_2_5hrs_mod': Contains raw trajectories converted to 5min time intervals for 8hrs and 2.5hrs datasets respectively and other details as shown below.
FORMAT: Biological Condition No. | Cell Number | Time Point | X | Y

4) 'xy_N_8hrs' or 'xy_N_2_5hrs': Contains raw trajectories converted to 5min time intervals for 8hrs and 2.5hrs datasets respectively and other details as shown below.
FORMAT: Cell Number | Time Point | X | Y

5) 'xys' or 'xys_2_5hrs': Contains raw trajectories converted to 5min time intervals for 8hrs and 2.5hrs datasets respectively and other details as shown below in 'cell' data structure format
FORMAT: Cell Number | Time Point | X | Y (Exactly same information as variables of Part 4 except data is stored in 'cell' data structure format)

6) 'trainedModel.predictFcn.mat' or 'trainedModel_2_5hrs.mat'; = Linear SVM trained model used to do classification for 8hrs and 2.5hrs respectively

The specific datasets needed to run the specific codes are detailed in the Code explanations below:

# 1a) Trajectory interpolation. 
FOLDER = 'Codes_for_interpolation_and_pMC_6_18_2022'.
Run get_nonMultiples.m (associated functions = get_asymmetric_xMC.m, get_asymmetric_yMC.m) | MC_Factor = Very high --> Simple Interpolation

>> [xy_t_hr_MC]=get_nonMultiples(d,dt_actual,N,dt_needed): 
	- Function that takes in inputs and outputs [xy_t_hr_MC] which is the trajectories adjusted for 'dt_needed' using either Pseudo Monte Carlo technique or Simple interpolation.

	- Change MC_factor as follows: MC_factor=2.01 for Pseudo Monte Carlo technique; MC_factor=1e20 for Simple interpolation

	- INPUTS to the function 'get_nonMultiples' :
	1. d = Raw Trajectories of the order: Cell Number | Time Point | X | Y
	2. dt_actual = Actual time difference between two time points of the Raw Trajectories
	3. N = No. of time points in the raw trajectories per cell
	4. dt_needed = Time difference we need to calculate the Trajectories for either using Interpolation or pseudo Monte Carlo

	- OUTPUTS to the function 'get_nonMultiples' :
	1. xy_t_hr_MC = Time interval adjusted (adjusted from 'dt_actual' to 'dt_needed') Trajectories of the order: Cell Number | Time Point | X | Y


>> [x_MC_reshape]=get_asymmetric_xMC(datx,daty,t_needed,n_tot,N,MC_factor)
	- Function that takes in inputs and outputs [x_MC_reshape] which is the trajectories adjusted for 'dt_needed' using either Pseudo Monte Carlo technique or Simple interpolation.
	
	- INPUTS to the function 'get_asymmetric_xMC'
	1. datx = 'x' coordinates of the original trajectory
	2. daty = 'y' coordinates of the original trajectory
	3. t_needed = time points needed for the Monte Carlo estimation of the original trajectory. This is NOT the same as time points of the original trajectory
	4. n_tot = Total number of cells
	5. N = Total number of time points in the original trajectory
	6. MC_factor = Monte Carlo factor

	- OUTPUTS to the function 'get_asymmetric_xMC'
	1. x_MC_reshape = 'x' coordinates of the MC_factor adjusted trajectory

>> [y_MC_reshape]=get_asymmetric_yMC(datx,daty,t_needed,n_tot,N,MC_factor)
	- Function that takes in inputs and outputs [y_MC_reshape] which is the trajectories adjusted for 'dt_needed' using either Pseudo Monte Carlo technique or Simple interpolation.

	- INPUTS to the function 'get_asymmetric_yMC'
	1. datx = 'x' coordinates of the original trajectory
	2. daty = 'y' coordinates of the original trajectory
	3. t_needed = time points needed for the Monte Carlo estimation of the original trajectory. This is NOT the same as time points of the original trajectory
	4. n_tot = Total number of cells
	5. N = Total number of time points in the original trajectory
	6. MC_factor = Monte Carlo factor

	- OUTPUTS to the function 'get_asymmetric_yMC'
	1. y_MC_reshape = 'y' coordinates of the MC_factor adjusted trajectory

>> [xy_t_hr_reshape]=get_interpolate(dat,t_needed,n_tot,N)
	- Function that takes in inputs and outputs [xy_t_hr_reshape] which is the trajectories/ time points adjusted for 'dt_needed' using Simple interpolation.


>> Sample Trajectory to analyze the code: 

	After making sure the functions have been added to the MATLAB path, and loading the variable 'HT1080_2D_Scr.mat', please run the code: 'Plot_Sample_Trajectory.m'. 
	- This will plot 3 trajectories at 2min, 4min and 5min time intervals using pseudo Monte Carlo. The plot is labelled.


# 1b) Concordance analysis.
FOLDER = 'Codes_for_Concordance_Analysis_7_10_2022'. It is important to load all the functions and variables provided in this folder and FOLDER = 'Codes_for_interpolation_and_pMC_6_18_2022'.
>> This code calculates and plots the Concordance between same trajectory but at different time intervals. 'get_area_combined_2.m' is the function used to calculate the area. 
>> The methodology is explained in the Materials and Methods section of the paper
>> Sample data = 'HT1080_2D_Scr.mat'. HT1080 cells moving on 2d glass substrates.

# 2) Compute higher order parameters for each trajecotry.
FOLDER = "Codes_for_calculating_HO_parameters_6_18_2022"

Run get_HO.m (associated functions = get_MSD.m, get_ACF.m, get_dR_PDF.m, get_dR_polarity, get_dtheta_PDF.m, fit_APRW.m)
%% All explanations are present in "Statistical analysis of cell migration in 3D using the anisotropic persistent random walk model", P. Wu et.al. (Nature Protocols, 2015) 

>> Run the Main function: [cell_N]=get_HO(xy_N,N)
	INPUTS to the function:
	- xy_N: x,y coordinates of the trajectory we want to calculate the Higher Order parameters for.
		'xy_N.mat' has been provided in the folder by the authors. It consists of 2 variables:
		- 'xy_N_8hrs.mat'  & 'xy_N_2_5hrs.mat'
		
	- N: Number of time points of each cell of the trajectory we want to calculate the Higher Order parameters for

	OUTPUTS to the function:
	- cell_N: Higher order parameters of all the cell we fed the trajectory in. The order of output of the Higher Order parameters = [MSD10, MSD100, Pp, Pnp, Dp, Dnp, Dtot, phi].
		  cell_N will have order = number of cells X 8; where no. of rows = no. of cells; no. of columns = 8 Higher order parameters

	Example: 
	- [cell_N]=get_HO(xy_N_8hrs,95) % Gives the higher order parameters of all the cells of 8hrs trajectories. N=95 time points. Time interval=5min
	- [cell_N]=get_HO(xy_N_2_5hrs,30) % Gives the higher order parameters of all the cells of 2.5hrs trajectories. N=30 time points. Time interval=5min



# 3) k-means clustering.
FOLDER = 'Codes_for_kmeans_clustering_Stability_Analysis_6_18_2022'.
Run k_means_Clustering.m or, k_means_Clustering_2_5hrs_dataset.m

>> Code that takes in zscore and log normalized Higher Order parameters of each cell and output the clusters of the cells.

	- Load  zscore and log normalized Higher Order parameters 'cell_M' or 'cell_M_2_5hrs' directly into the command window depending on whether we want clustering of 8hrs datatset or 2.5hrs datasets

>> [idx,C,sumdist,D] = kmeans(cell_M,n_clust,'Distance','correlation','Display','final','MaxIter',1000); %MATLAB code to perform k-means clustering

	- 'idx' contains cluster indices of each cell
	- 'C' centroids of each cluster --> will be a composed of 8 higher order parameters
	- 'sumdist' returns the within-cluster sums of cell-to-cluster centroid distances --> not used for the analysis
	- 'D' returns distances from each cell to centroids of all clusters
	- 'cell_M' or 'cell_M_2_5hrs' matrix containing zscore and log normalized Higher Order parameters of each cell for 8hrs and 2.5hrs trajectories 
	- 'correlation' Distance used as the distance metric in the clustering 
	- 'MaxIter' --> maximum iteration of 1000 is found to be suitable for our clustering analysis

>> [silh,h] = silhouette(cell_M,idx,'correlation'); % Plot out the Silhouette values for the 'n_clusters'. The cluster ID of the cell is obtained from 'idx'

>> Sum_Silh=sum(silh)/max(size(cell_M)) % Calculate average Silhouette value per cell. NOTE: sum(silh) sums over all the cells:

>> Lastly, calculate 'Inertia' for the given clustering

c) FOLDER= 'Code_to_plot_Heatmap_per_cell_7_10_2022'. It is important to load all the variables and functions provided in this folder.
>> To plot the Heatmaps of Higher Order parameters of each cell, run the MATLAB code: 'Heatmap_2A_3A_plot.m'
	- This will plot the Higher order parameters of all cells, grouped together for each cell.

# 4) SVM prediction.
FOLDER = 'Codes_for_SVM_Prediction_6_28_2022'. It is important to load all functions in a MATLAB window
Run SVM_Clustering_Prediction.m (associated functions = trainedModel.predictFcn --> standard MATLAB training system)

>> 'trainedModel.predictFcn.mat'/ 'trainedModel_2_5hrs.mat'; = Linear SVM trained model used to do classification for 8hrs and 2.5hrs
>>  Load the MATLAB data file shared 'SVM_Prediction_variables'

>>  For 8hrs datasets we will use the following:
N=95; dt=5; % N = Number of time points per cell; dt= time intervals of the trajectories

    For 2.5hrs datasets we will use the following:
N=30; dt=5; % N = Number of time points per cell; dt= time intervals of the trajectories

>>  'cell_data' is the HO matrix of the cells we want to predict the cluster of
It is important for the cells we want to predict the cluster of to have the same N and dt as the principal dataset, otherwise we can have erroneuos predictions

>>  A Sample demonstration code of classification is in 'SVM_Clustering_Prediction.m':

	1.Before running the code: 
		a) load the HO parameters for 2.5hrs datasets, namely, 'cell_2_5hrs.mat' by loading 'General_Datasets_needed_to_run_HaLo.mat' provided
		b) Load the order of clusters as defined by the variable 'o1_2_5hrs'
		c) Load the sample datasets, namely, Monocytes under DMEM Ctrl and under the influence of IL6 & IL8 as defined by the variable 'Sample_Datasets_for_SVM_Prediction'
	2. Generate HO parameters for the trajectories we want to classify using 'get_HO.m' function provided earlier
		[cell_data]=get_HO(xy_N,N); 
		% Use xy_N='data_CTRL_DMEM_5min_N_30.mat' provided along with the codes. Put N=30 as this is a 2.5hrs dataset

	3. To classify the trajectories, either choose Case 1 (by commenting Case 2) or Case 2 (by commenting Case 1)
		%% Case 1: 
		%[cell_data]=get_HO(data_CTRL_DMEM_5min_N_30,30);

		%% Case 2: 
		[cell_data]=get_HO(data_IL6_IL8_5min_N_30,30);

	4. 'YPred' will give cluster prediction for the trajectories of the cells we want to classify
	5. Finally a bar plot will be generating showing the fraction of cells in each of the 17 clusters (since the sample datasets are of 2.5hrs time periods)


# 5) Simulate trajectories baed on APRW model.
FOLDER = 'Codes_for_Simulating_Trajectories_6_18_2022'. 
Run Simulate_APRW_v1_2_5hrs.m / Simulate_APRW_v1_8hrs.m (associated functions = fit_APRW.m, sim_APRW.m, get_MSD.m, get_ACF.m, get_dR_PDF.m, get_dR_polarity, get_dtheta_PDF.m)

%% All explanations are present in "Statistical analysis of cell migration in 3D using the anisotropic persistent random walk model", P. Wu et.al. (Nature Protocols, 2015) 

>> 'Simulate_APRW_v1_2_5hrs.m' / 'Simulate_APRW_v1_8hrs.m': Code to simulate trajectories from the higher order parameters of given trajectories. The code also calculates the Higher Order parameters
    of the simulated trajectories.

>> To simulate trajectories, directly load 'xys_2_5hrs.mat' or 'xys.mat' to the MATLAB Command Window for 2.5hrs & 8hrs dataset
>> Run the code 'Simulate_APRW_v1_2_5hrs.m' / 'Simulate_APRW_v1_8hrs.m'


# 6) Compute entropy for each trajectory. 
FOLDER = 'Codes_for_Entropy_Calculations_6_28_2022'. It is important to load all functions in a MATLAB window 
Run 'Entropy_Calculations.m' Code for Entropy calculations

>> INPUTS: 
	1) 'R_comb_group.mat' --> Contains the information of transition from states at time period T1:SGx to T2:SGy to T3:SGz to T:CGw (Provided with the code writeup)
				   Here, T1=T2=T3=2.5hrs and T=8hrs
	2) Load the test data 'cond_c_Ly12_vary_CN.mat'. Contains information on transition states for Ly12 cells moving in 5 different collagen concentrations (also shared with the code writeup)

	3) Run the following code: 'Entropy_Calculations.m'

>> OUTPUTS: 

	- Transition Entropies: S_1to2,S_2to3, S_3toC for all 5 collagen concentrations
	- State Entropies: S_T1, S_T2, S_T3, S_C for all 5 collagen concentrations
	- Conditional Transition Entropies: S_itojto1, S_itojto2, S_itojto3, S_itojto4 for all 5 collagen concentrations
		-Here we calculate Conditional Transition Entropies for cases where the 3rd state is given (such as SG1,SG2,SG3 and SG4)

	- All the above variables will be plotted in separate bar plots
