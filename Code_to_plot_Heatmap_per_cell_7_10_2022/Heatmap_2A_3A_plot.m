%% For 8hrs:
o1=[1 21 4 25 10 17 24 5 16 12 14 13 3 6 7 15 8 18 2 19 22 9 11 20 23];
o_HO=[];
o_HO=[2 7 1 5 6 4 3 8];
clear i; clear bin1;
Heatmap_Fig3_8hrs=[];
for bin1=1:max(o1)
    temp_bin=Storage(o1(1,bin1)).Bin';
    Heatmap_Fig3_8hrs=[Heatmap_Fig3_8hrs; cell_M(temp_bin,:)];
    temp_bin=[];
end
figure(1)
imagesc(((Heatmap_Fig3_8hrs(:,o_HO))),[-1 1]); colormap(cmapWB_Blue_White_Red(100)); bjff3;
set(gca,'YTick',[]); set(gca,'XTick',[]);
title('Heatmap 8hrs dataset');
colorbar;

%% For 2.5hrs: 
g4=[5 14 7]; g2=[1 9 15 10]; g1=[2 12 4 3 8 11 16]; g3=[6 13 17];
o1=[]; o1=[g4,g2,g1,g3];
o_HO=[];
o_HO=[1 2 7 4 6 3 5 8];
clear i; clear bin1;
Heatmap_Fig2_2_5hrs=[];
for bin1=1:max(o1)
    temp_bin=Storage_2_5hrs(o1(1,bin1)).Bin';
    Heatmap_Fig2_2_5hrs=[Heatmap_Fig2_2_5hrs; cell_M_2_5hrs(temp_bin,:)];
    temp_bin=[];
end

figure(2)
imagesc(((Heatmap_Fig2_2_5hrs(:,o_HO))),[-1 1]); colormap(cmapWB_Blue_White_Red(100)); bjff3;
set(gca,'YTick',[]); set(gca,'XTick',[]);
title('Heatmap 2.5hrs dataset');
colorbar;