%% HT1080 4min datasets: Loss of Information
m_cell=[55 59 71];
data=HT1080_2D_Scr;
[HT1080_2D_2min]=get_nonMultiples(data,2,239,2); %data points every 4 min
[HT1080_2D_4min]=get_nonMultiples(HT1080_2D_2min,2,239,4);
[HT1080_2D_6min]=get_nonMultiples(HT1080_2D_2min,2,239,6);
[HT1080_2D_8min]=get_nonMultiples(HT1080_2D_2min,2,239,8);
[HT1080_2D_10min]=get_nonMultiples(HT1080_2D_2min,2,239,10);
[HT1080_2D_12min]=get_nonMultiples(HT1080_2D_2min,2,239,12);
clear i;
tnumb=6; cidk=jet(tnumb);

%% Calculate the Concordance here:
n_tot=75;
[Area_2min_Actual_2]=(get_area_combined_2(HT1080_2D_2min,239,n_tot))';
[Area_4min_Actual_2]=(get_area_combined_2(HT1080_2D_4min,120,n_tot))';
[Area_6min_Actual_2]=(get_area_combined_2(HT1080_2D_6min,80,n_tot))';
[Area_8min_Actual_2]=(get_area_combined_2(HT1080_2D_8min,60,n_tot))';
[Area_10min_Actual_2]=(get_area_combined_2(HT1080_2D_10min,48,n_tot))';
[Area_12min_Actual_2]=(get_area_combined_2(HT1080_2D_12min,40,n_tot))';

y_plot=[];
y_plot=[mean(mean(Area_2min_Actual_2)) mean(mean(Area_4min_Actual_2)) mean(mean(Area_6min_Actual_2)) mean(mean(Area_8min_Actual_2)) mean(mean(Area_10min_Actual_2)) mean(mean(Area_12min_Actual_2))];
figure(1)
bar(y_plot);
xlabel('Increasing time intervals');
ylabel('Concordance');
set(gca,'XTick',[]);

