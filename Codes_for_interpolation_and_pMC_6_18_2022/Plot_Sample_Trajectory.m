% 1. 'HT1080_2D_Scr' is provided with the code. Please directly load this data into the MATLAB Command Window.
% 2. Once the above variable is loaded, please Copy+Paste the code provided below.

%% Plot Original trajectory %%
data=[]; data=HT1080_2D_Scr; % HT1080_2D_Scr sample data is provided with the codes. The Reviewer just needs to load this MATLAB datafile. Time interval = 2min
clear i; i=1; tnumb=3; cidk=hsv(tnumb); % Change 'tnumb' to get a different color
m_cell=[55]; % Which cell to plot. Here, 55th cell was chosen. An array is used in case we want to plot multiple cells
i_cell=m_cell(1,i);
figure(1)
HT1080_2D_2min = [];
[HT1080_2D_2min]=get_nonMultiples(data,2,239,2); %data points every 2 min = Original Trajectory which has N=239 timepoints | dt_needed=dt_actual=2min
clear x; clear y;
x=HT1080_2D_2min(:,3); y=HT1080_2D_2min(:,4); N=239; % N=no. of time points of the original trajectory
plot(x(1+N*(i_cell-1):N+N*(i_cell-1))-x(1+N*(i_cell-1)),y(1+N*(i_cell-1):N+N*(i_cell-1))-y(1+N*(i_cell-1)),'-o','color',cidk(3,:),'MarkerSize',6,'Linewidth',3);
set(gca,'fontsize',22, 'fontname', 'times new roman');
legend('2 min')
hold on

%% Plot pseudo Monte Carlo/ Interpolation modified trajectory 1 %%
clear i; i=1; tnumb=4; cidk=hsv(tnumb); %Change 'tnumb' to get a different color
HT1080_2D_4min = [];
[HT1080_2D_4min]=get_nonMultiples(data,2,239,4); %data points every 4 min. Original Trajectory has N=239 timepoints | dt_needed=4min, dt_actual=2min
clear x; clear y;
x=HT1080_2D_4min(:,3); y=HT1080_2D_4min(:,4); N=120; % N=no. of time points of the modified trajectory
plot(x(1+N*(i_cell-1):N+N*(i_cell-1))-x(1+N*(i_cell-1)),y(1+N*(i_cell-1):N+N*(i_cell-1))-y(1+N*(i_cell-1)),'-o','color',cidk(3,:),'MarkerSize',6,'Linewidth',3);
set(gca,'fontsize',22, 'fontname', 'times new roman');

hold on

%% Plot pseudo Monte Carlo/ Interpolation modified trajectory 2 %%
clear i; i=1; tnumb=5; cidk=hsv(tnumb); %Change 'tnumb' to get a different color
HT1080_2D_5min = [];
[HT1080_2D_5min]=get_nonMultiples(data,2,239,5); %data points every 5 min. Original Trajectory has N=239 timepoints | dt_needed=5min, dt_actual=2min
clear x; clear y;
x=HT1080_2D_5min(:,3); y=HT1080_2D_5min(:,4); N=96; % N=no. of time points of the modified trajectory
plot(x(1+N*(i_cell-1):N+N*(i_cell-1))-x(1+N*(i_cell-1)),y(1+N*(i_cell-1):N+N*(i_cell-1))-y(1+N*(i_cell-1)),'-o','color',cidk(3,:),'MarkerSize',6,'Linewidth',3);
set(gca,'fontsize',22, 'fontname', 'times new roman');
legend('2 min','4 min','5 min')