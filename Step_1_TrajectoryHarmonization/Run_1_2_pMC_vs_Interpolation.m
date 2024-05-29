clear all; close all; clc;
%% Code to recapitulate Figure 1B - symmetric interpolation:
load HT1080_2D_Scr.mat;
% isolate example trajectory in dataset:
n_tot=1;
traj = HT1080_2D_Scr(HT1080_2D_Scr(:,1) == 55,:);

% generate 8m trajectory to attempt symmetric interpolation / pMC method on:
traj_8m = get_nonMultiples(traj,2,239,8,0);
% ground-truth:
traj_4m = get_nonMultiples(traj,2,239,4,0);

% attempt estimating groundtruth
traj_4m_symm_interp = get_nonMultiples(traj_8m,8,60,4,0); % simple interpolation
traj_4m_symm_MC_interp = get_nonMultiples(traj_8m,8,60,4,1); % pMC interpolation

figure;
plot(traj_4m(:,3), traj_4m(:,4), 'b.-');
hold on;
plot(traj_4m_symm_interp(:,3), traj_4m_symm_interp(:,4), 'r.-');
hold on;
plot(traj_4m_symm_MC_interp(:,3), traj_4m_symm_MC_interp(:,4), 'g.-');
hold on;
legend(["original","interpolation","pmc"]);

% perform for all trajectories:
data=HT1080_2D_Scr;
[HT1080_2D_2min]=get_nonMultiples(data,2,239,2,0); %data points every 2 min
[HT1080_2D_8min]=get_nonMultiples(HT1080_2D_2min,2,239,8,0);
[HT1080_2D_4min]=get_nonMultiples(HT1080_2D_2min,2,239,4,0);

n_tot=75;
% Symmetric interpolation/pMC:
traj_interp_symm = get_nonMultiples(HT1080_2D_8min,8,60, 4, 0);
traj_MC_symm = get_nonMultiples(HT1080_2D_8min,8, 60, 4, 1);
% Calculate concordances:
figure;
[Area_4min_Actual_2]=(get_area_combined_2(HT1080_2D_4min,120,n_tot))';
[Area_4min_interp_symm]=(get_area_combined_2(traj_interp_symm,119,n_tot))';
[Area_4min_MC_symm]=(get_area_combined_2(traj_MC_symm,119,n_tot))';
concordance_symm =[sum(Area_4min_Actual_2)' sum(Area_4min_interp_symm)' sum(Area_4min_MC_symm)'];
boxplot(concordance_symm);
% output data
writematrix(traj_4m,"outputs/run_1_2-traj_4m.csv");
writematrix(traj_4m_symm_interp,"outputs/run_1_2-traj_4m_symm_interp.csv");
writematrix(traj_4m_symm_MC_interp,"outputs/run_1_2-traj_4m_symm_MC_interp.csv");
writematrix(concordance_symm,"outputs/run_1_2-concordance_symm.csv");
%% Code to recapitulate Figure 1C - asymmetric interpolation:
load HT1080_2D_Scr.mat;
% isolate example trajectory in dataset:
n_tot=1;
traj = HT1080_2D_Scr(HT1080_2D_Scr(:,1) == 55,:);

% generate 8m trajectory to attempt asymmetric interpolation / pMC method on:
traj_8m = get_nonMultiples(traj,2,239,8,0);
% ground-truth:
traj_6m = get_nonMultiples(traj,2,239,6,0);

% attempt estimating groundtruth
traj_6m_asymm_interp = get_nonMultiples(traj_8m,8,60,6,0); % simple interpolation
traj_6m_asymm_MC = get_nonMultiples(traj_8m,8,60,6,1); % pMC interpolation

figure;
plot(traj_6m(:,3), traj_6m(:,4), 'b.-');
hold on;
plot(traj_6m_asymm_interp(:,3), traj_6m_asymm_interp(:,4), 'r.-');
hold on;
plot(traj_6m_asymm_MC(:,3), traj_6m_asymm_MC(:,4), 'g.-');
hold on;
legend(["original","interpolation","pmc"]);

% perform for all trajectories:
data=HT1080_2D_Scr;
[HT1080_2D_2min]=get_nonMultiples(data,2,239,2,0); %data points every 2 min
[HT1080_2D_8min]=get_nonMultiples(HT1080_2D_2min,2,239,8,0);
[HT1080_2D_6min]=get_nonMultiples(HT1080_2D_2min,2,239,6,0);

n_tot=75;
% Asymmetric interpolation/pMC:
traj_interp_asymm = get_nonMultiples(HT1080_2D_8min,8,60, 6, 0);
traj_MC_asymm = get_nonMultiples(HT1080_2D_8min,8, 60, 6, 1);
% Calculate concordances:
figure;
[Area_6min_Actual_2]=(get_area_combined_2(HT1080_2D_6min,80,n_tot))';
[Area_6min_interp_asymm]=(get_area_combined_2(traj_interp_asymm,79,n_tot))';
[Area_6min_MC_asymm]=(get_area_combined_2(traj_MC_asymm,79,n_tot))';
concordance_asymm =[sum(Area_6min_Actual_2)' sum(Area_6min_interp_asymm)' sum(Area_6min_MC_asymm)'];
boxplot(concordance_asymm);
% output data
writematrix(traj_6m,"outputs/run_1_2-traj_6m.csv");
writematrix(traj_6m_asymm_interp,"outputs/run_1_2-traj_6m_asymm_interp.csv");
writematrix(traj_6m_asymm_MC,"outputs/run_1_2-traj_6m_asymm_MC.csv");
writematrix(concordance_asymm,"outputs/run_1_2-concordance_asymm.csv");