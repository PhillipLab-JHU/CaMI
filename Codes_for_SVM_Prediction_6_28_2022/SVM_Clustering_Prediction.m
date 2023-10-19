
% Once we have a Trained SVM Model such as 'trainedModel.predictFcn', we
% can use it do prediction on new datasets:

% For 8hrs datasets:
%N=95; dt=5; % N = Number of time points per cell; dt= time intervals of the trajectories

% For 2.5hrs datasets:
%N=30; dt=5; % N = Number of time points per cell; dt= time intervals of the trajectories


% Then extract the raw HO parameters extracted from principal dataset of
% n=74253 cells (for 2.5hrs data) OR, n=24753 cells (for 8hrs data)
%load('C:\Users\Jude Phillip\Documents\MATLAB\My_Codes\Datasets_For_Paper\cell.mat');
clear i; cell_M_data=[]; clear cell_i;
cell_temp=cell;

% Critical: It is important to normalize the HO parameters of the cell
% we want to predict the cluster of along with the principal dataset

% cell_data is the HO matrix of the cells we want to predict the cluster of
% It is important for the cells we want to predict the cluster of to have
% the same N and dt as the principal dataset, otherwise we can have
% erroneuos predictions

% Use xy_N='data_CTRL_DMEM_5min_N_30.mat' provided along with the codes. Put N=30 as this is a 2.5hrs dataset
clear cell_data;

%% Case 1: 
[cell_data]=get_HO(data_CTRL_DMEM_5min_N_30,30);

%% Case 2: 
%[cell_data]=get_HO(data_IL6_IL8_5min_N_30,30);

%% Start of Cluster prediction:
for i=1:max(size(cell_data,1))
    
    % Normalizing one cell at a time:
    cell_i=zscore(log([cell_temp; cell_data(i,:)]));
    cell_M_data=[cell_M_data; cell_i(end,:)]; %Final Normalized H.O.Parameter Matrix
    clear cell_i;
end
% Predict the cluster using Linear SVM (un-ordered):
% Call the trained model and extract the clusters in the variable 'YPred'
%load('C:\Users\Jude Phillip\Documents\MATLAB\My_Codes\Datasets_For_Paper\trainedModel.mat');
clear YPred;
YPred = trainedModel_2_5hrs.predictFcn(cell_M_data);

%% Plot out a barplot of the classification: 

clear i; clear Y; 
Y=double(YPred); clear occur_count;
for i=1:17
    occur_count(i,1)=size(find(Y==o1_2_5hrs(i,1)),1);
    %occur_count(i,1)=size(find(Y==i),1);
end
occur_count=occur_count./size(Y,1); %Normalization
S=-sum(occur_count.*log(occur_count+1e-18)); %Entropy
bar(occur_count); set(gca,'fontsize', 18, 'fontname', 'times new roman'); %ylabel('Control');
ylim([0 0.6])

