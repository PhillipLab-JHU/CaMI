function [cell_N]=get_HO(xy_N,N)

n_tot=size(xy_N,1)/N; dt=4; %n_tot=Total number of cells; dt = actual time difference b/w two time points
clear i; 

xys=cell(n_tot,1); % xys is empty cell and will contain X, Y coordinates of the trajectory
% xy_N has the format: Cell Number | Time point | X | Y

% N=number of time points of the trajectory per cell
for i=1:n_tot
    xys{i}=xy_N(1+N*(i-1):N+N*(i-1),3:4);
end
%param is a structure 
param.showfig=0;
param.saveres=0;
param.markertype='g-';
param.outfigurenum=301;
param.dim=2;

% MSD = Mean Squared Displacement:
[speed,msd]=get_MSD(xys,dt,param);
%Done with MSD .... Param 1

param.tlag=1;    
param.outfigurenum=302;

% Auto-correlation function:
acf=get_ACF(xys,dt,param);
%Done with ACF .... Param 2


%%% DONE %%%%

  param.dxmax=50;
  param.binn=70;  
  param.outfigurenum=303;
  
  for tl=[2 20] % set tlag for PDF distribution calculation
      %2 and 20 are MSD10 and MSD100
    [feq,bin]=get_dR_PDF(xys,tl,param);
  end
%Done with dR_PDF ... Param 3: Plotted for 2 points %%%%

%%%%% DONE %%%%%%%

  tlag=1; 
  param.outfigurenum1=304;
  param.outfigurenum2=305;
[outdxy,out4]=get_dR_polarity(xys,tlag,param);
%Done with dR_polarity .... Param 4, 5

%%%%%% DONE %%%%%%%

param.binnum=6; % bin number between 0~180 degree
param.outfigurenum=306;
param.markertype='b-';
   tloi=[1:5:30];
    [dthout]=get_dtheta_PDF(xys,tloi,param);   
%Done with dtheta_PDF .... Param 6

        param.showfig=0;
        param.saveres=0;
        param.dim=2;
        param.outfigurenum=311;
        
        tlag=1;
        [outp]=fit_APRW(xys,dt,tlag,param);
        % fitting APRW model with the data to extract other HO parameters
     
     pos=1;
     data_p=outp(:,1:5);
     data_np=outp(:,6:10);
     
        %Each pos is some 'dt_needed'
     Pp(:,pos)=data_p(:,1); %No. of rows= n_tot
     Sp(:,pos)=data_p(:,2);
     Dp(:,pos)=(Sp(:,pos).^2).*Pp(:,pos)/4;
     
     Pnp(:,pos)=data_np(:,1);
     Snp(:,pos)=data_np(:,2);
     Dnp(:,pos)=(Snp(:,pos).^2).*Pnp(:,pos)/4;
     
     Dtot(:,pos)=Dp(:,pos)+Dnp(:,pos); %Total diffusivity
     phi(:,pos)=Dp(:,pos)./Dnp(:,pos);  %Anisotropy
     
     % Assuming dt=5min, but can be used to extract any msd(tau):
     % Example: msd(1,:)'=MSD(dt); msd(2,:)'=MSD(2*dt) and so on.
     MSD4=msd(1,:)';
     MSD20=msd(5,:)';
     MSD100=msd(20,:)';
        %Default tlag=1
        %[outp]=fit_PRW(xys,dt,param);
        
        %Clustering plot
        %Input: zecm (Rows: Cells, Columns: Parameters)
%clear all;
% C1=[1 2]; %input all parameters here
% %Ci is the i-th cell, the elements are all possible parameters
% C2=[4 5];
% C3=[8 9];

% Get Raw HO parameters:
cell_N(:,:)=[speed' MSD4 MSD20 Pp Pnp Dp Dnp Dtot phi];
%cell_M(:,:)=[zscore(MSD6) zscore(MSD60) zscore(Pp) zscore(Pnp) zscore(Dp) zscore(Dnp) zscore(Dtot) zscore(phi)];

% zscore normalize the log of raw HO parameters:
cell_N_M(:,:)=[zscore(log(MSD4)) zscore(log(MSD20)) zscore(log(Pp)) zscore(log(Pnp)) zscore(log(Dp)) zscore(log(Dnp)) zscore(log(Dtot)) zscore(log(phi))];

end