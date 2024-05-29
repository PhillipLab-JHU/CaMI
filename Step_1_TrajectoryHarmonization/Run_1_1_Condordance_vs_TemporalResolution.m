%% HT1080 4min datasets: Loss of Information

clear all; close all; clc;
% Load data.
load HT1080_2D_Scr.mat;
data=HT1080_2D_Scr;
% Degrade trajectory acquisition interval for each trajectory. The
% interpolation function simply takes existing multiples of the trajectory
% when estimating lower resolutions.
[HT1080_2D_2min]=get_nonMultiples(data,2,239,2,0); %data points every 2 min
[HT1080_2D_4min]=get_nonMultiples(HT1080_2D_2min,2,239,4,0);
[HT1080_2D_6min]=get_nonMultiples(HT1080_2D_2min,2,239,6,0);
[HT1080_2D_8min]=get_nonMultiples(HT1080_2D_2min,2,239,8,0);
[HT1080_2D_10min]=get_nonMultiples(HT1080_2D_2min,2,239,10,0);
[HT1080_2D_12min]=get_nonMultiples(HT1080_2D_2min,2,239,12,0);

figure;
plot(HT1080_2D_2min(HT1080_2D_2min(:,1) == 55,3), HT1080_2D_2min((HT1080_2D_2min(:,1) == 55),4),'.-','LineWidth',0.25,'MarkerSize',1); hold on;
plot(HT1080_2D_4min(HT1080_2D_4min(:,1) == 55,3), HT1080_2D_4min((HT1080_2D_4min(:,1) == 55),4),'.-','LineWidth',0.25); hold on;
plot(HT1080_2D_6min(HT1080_2D_6min(:,1) == 55,3), HT1080_2D_6min((HT1080_2D_6min(:,1) == 55),4),'.-','LineWidth',0.25); hold on;
plot(HT1080_2D_8min(HT1080_2D_8min(:,1) == 55,3), HT1080_2D_8min((HT1080_2D_8min(:,1) == 55),4),'.-','LineWidth',0.25); hold on;
plot(HT1080_2D_10min(HT1080_2D_10min(:,1) == 55,3), HT1080_2D_10min((HT1080_2D_10min(:,1) == 55),4),'.-','LineWidth',0.25); hold on;
plot(HT1080_2D_12min(HT1080_2D_12min(:,1) == 55,3), HT1080_2D_12min((HT1080_2D_12min(:,1) == 55),4),'.-','LineWidth',0.25); hold on;
legend(["original","4min","6min","8min","10min","12min"],'Location','eastoutside');
%% Calculate the Concordance here:
n_tot=75;
[Area_2min_Actual_2]=(get_area_combined_2(HT1080_2D_2min,239,n_tot))';
[Area_4min_Actual_2]=(get_area_combined_2(HT1080_2D_4min,120,n_tot))';
[Area_6min_Actual_2]=(get_area_combined_2(HT1080_2D_6min,80,n_tot))';
[Area_8min_Actual_2]=(get_area_combined_2(HT1080_2D_8min,60,n_tot))';
[Area_10min_Actual_2]=(get_area_combined_2(HT1080_2D_10min,48,n_tot))';
[Area_12min_Actual_2]=(get_area_combined_2(HT1080_2D_12min,40,n_tot))';

y_plot=[sum(Area_2min_Actual_2)' sum(Area_4min_Actual_2)' sum(Area_6min_Actual_2)' sum(Area_8min_Actual_2)' sum(Area_10min_Actual_2)' sum(Area_12min_Actual_2)'];
figure;
boxplot(y_plot);
xlabel('Increasing time intervals');
ylabel('Concordance');
set(gca,'XTick',[]);

%% ouput data for visualization
writematrix(HT1080_2D_2min,'outputs/run_1_1-HT1080_2D_2min.csv')
writematrix(HT1080_2D_4min,'outputs/run_1_1-HT1080_2D_4min.csv')
writematrix(HT1080_2D_6min,'outputs/run_1_1-HT1080_2D_6min.csv')
writematrix(HT1080_2D_8min,'outputs/run_1_1-HT1080_2D_8min.csv')
writematrix(HT1080_2D_10min,'outputs/run_1_1-HT1080_2D_10min.csv')
writematrix(HT1080_2D_12min,'outputs/run_1_1-HT1080_2D_12min.csv')
writematrix(y_plot,'outputs/run_1_1-concordances.csv')