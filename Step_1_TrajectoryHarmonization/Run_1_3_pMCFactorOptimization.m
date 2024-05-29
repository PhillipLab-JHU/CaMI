clear all; close all; clc;
%%
load HT1080_2D_Scr.mat;
data = HT1080_2D_Scr;
%%
[HT1080_2D_2min]=get_nonMultiples(data,2,239,2,0); % data points every 2 min
[HT1080_2D_4min]=get_nonMultiples(HT1080_2D_2min,2,239,4,0); % data points every 4 min
[HT1080_2D_8min]=get_nonMultiples(HT1080_2D_2min,2,239,8,0); % data points every 8 min

for mc = [1 2 2.01 3]
    traj_pmc = get_nonMultiples_OptimizeMC(HT1080_2D_8min, 8, 60, 4, 1, mc);
    cd('get_HO');
    traj_pmc_ho = get_HO(traj_pmc,119);
    writematrix(traj_pmc_ho, "../outputs/Run_1_3_HO_mc_" + mc + ".csv")
    cd ..
end

cd('get_HO');
% ground-truth:
traj_original_ho = get_HO(HT1080_2D_4min,120);
writematrix(traj_original_ho, "../outputs/Run_1_3_HO_original.csv")
cd ..

traj_interp = get_nonMultiples(HT1080_2D_8min, 8, 60, 4, 0);
cd('get_HO');
traj_interp_ho = get_HO(traj_interp,119);
writematrix(traj_interp_ho, "../outputs/Run_1_3_HO_interp.csv")
cd ..

%% Plot MSD functions 
colors = {'#4280BB',
            '#9673B4',
             '#926458',
             '#8B8B8B',
             '#CDCECE',};
close all;
traj_pmc_1 = get_nonMultiples_OptimizeMC(HT1080_2D_8min, 8, 60, 4, 1, 1);
traj_pmc_2 = get_nonMultiples_OptimizeMC(HT1080_2D_8min, 8, 60, 4, 1, 2);
traj_pmc_3 = get_nonMultiples_OptimizeMC(HT1080_2D_8min, 8, 60, 4, 1, 3);

cd('get_HO')
param.dim=2;
param.saveres=false;
param.showfig=true;
param.markertype='o-';
param.outfigurenum=1;

c=1;xys = {};
for i = 1:119:length(traj_interp)
    xys{c} = traj_interp(i:i+118,3:4);
    c = c+1;
end
param.MarkerEdgeColor = colors{2};
param.MarkerFaceColor = colors{2};
MSD_interp = get_MSD(xys,2,param);

c=1;xys = {};
for i = 1:119:length(traj_pmc_1)
    xys{c} = traj_pmc_1(i:i+118,3:4);
    c = c+1;
end
param.MarkerEdgeColor = colors{3};
param.MarkerFaceColor = colors{3};
MSD_pmc_1 = get_MSD(xys,2,param);

c=1;xys = {};
for i = 1:119:length(traj_pmc_2)
    xys{c} = traj_pmc_2(i:i+118,3:4);
    c = c+1;
end
param.MarkerEdgeColor = colors{4};
param.MarkerFaceColor = colors{4};
MSD_pmc_2 = get_MSD(xys,2,param);

c=1;xys = {};
for i = 1:119:length(traj_pmc_3)
    xys{c} = traj_pmc_3(i:i+118,3:4);
    c = c+1;
end
param.MarkerEdgeColor = colors{5};
param.MarkerFaceColor = colors{5};
MSD_pmc_3 = get_MSD(xys,2,param);

xys = {};
c=1;
for i = 1:120:length(HT1080_2D_4min)
    xys{c} = HT1080_2D_4min(i:i+119,3:4);
    c = c+1;
end
param.MarkerEdgeColor = colors{1};
param.MarkerFaceColor = colors{1};
MSD_original = get_MSD(xys,2,param);
cd ..
% legend(["original","interpolation","PMC-1","PMC-2","PMC-3"]);