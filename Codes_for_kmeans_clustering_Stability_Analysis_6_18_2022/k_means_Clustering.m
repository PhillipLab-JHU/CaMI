% Code to perform k-means clustering
%When performing k-means clustering, follow these best practices:

%Compare k-means clustering solutions for different values of k to determine 
%an optimal number of clusters for your data.

%Evaluate clustering solutions by examining silhouette plots and silhouette values. 
%You can also use the evalclusters function to evaluate clustering solutions based on criteria such as gap values, silhouette values, Davies-Bouldin index values, and Calinski-Harabasz index values.

%Replicate clustering from different randomly selected centroids and return 
%the solution with the lowest total sum of distances among all the replicates.

%Choose the number of clusters:
n_clust=25;

% Using MATLAB's inbuilt kmeans clustering. cell_M: zscore normalized log
% of 8 HO parameters. It is important to zscore and log of 8 HO parameters
% as just raw HO parameters may lead to inaccurate clustering with low
% cluster prediction accuracies
[idx,C,sumdist,D] = kmeans(cell_M,n_clust,'Distance','correlation','Display','final','MaxIter',1000);

% Plot out the Silhouette values for the n_clusters
figure(2)
[silh,h] = silhouette(cell_M,idx,'correlation'); set(gca,'YTick',[]);
% Calculate average Silhouette value per cell. NOTE: sum(silh) sums over all the cells:
Sum_Silh=sum(silh)/max(size(cell_M))
%max(size(cell_M))=n_tot



 %% Plot the inertia
% cell(:,:)=[MSD10 MSD100 Pp Pnp Dp Dnp Dtot phi];
% C: Centroids of all clusters having the dimension [n_clust X 8], where 8
% corresponds to 8 HO parameters
C_MSD10=C(:,1); C_MSD100=C(:,2); C_Pp=C(:,3); C_Pnp=C(:,4);
C_Dp=C(:,5); C_Dnp=C(:,6); C_Dtot=C(:,7); C_phi=C(:,8);
%d=(C_MSD10(:,1)-cell_M(temp_bin,1))
clear bin; cell_count=0;
d_MSD10=0; d_MSD100=0; d_Pp=0; d_Pnp=0;
d_Dp=0; d_Dnp=0; d_Dtot=0; d_phi=0;
%figure(2);
for bin=1:max(idx) %max(idx) is the number of bins
    clear temp_bin; clear i;
    temp_bin=find(idx==bin);
    %subplot(4,4,bin)
    d_MSD10=d_MSD10+sum((C_MSD10(bin,1)-cell_M(temp_bin,1)).^2);
    d_MSD100=d_MSD100+sum((C_MSD100(bin,1)-cell_M(temp_bin,2)).^2);
    d_Pp=d_Pp+sum((C_Pp(bin,1)-cell_M(temp_bin,3)).^2);
    d_Pnp=d_Pnp+sum((C_Pnp(bin,1)-cell_M(temp_bin,4)).^2);
    d_Dp=d_Dp+sum((C_Dp(bin,1)-cell_M(temp_bin,5)).^2);
    d_Dnp=d_Dnp+sum((C_Dnp(bin,1)-cell_M(temp_bin,6)).^2);
    d_Dtot=d_Dtot+sum((C_Dtot(bin,1)-cell_M(temp_bin,7)).^2);
    d_phi=d_phi+sum((C_phi(bin,1)-cell_M(temp_bin,8)).^2);   
end
d=d_MSD10+d_MSD100+d_Pp+d_Pnp+d_Dp+d_Dnp+d_Dtot+d_phi;
% Normalize the summation of distances with number of cells and number of
% clusters
d=d./max(size(cell_M))./n_clust;

