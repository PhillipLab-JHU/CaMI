
%% Simulate trajectories for 2.5hrs datasets:
tic;
param.showfig=1;
param.saveres=1;
param.dim=2;
param.outfigurenum=311;
dt=5;  %Time interval of the trajectory
tlag=1;
[outp]=fit_APRW(xys_2_5hrs(1),dt,tlag,param);
param.showfig=0;
param.saveres=0;
%param.Nmax=95; Number of points. For 8hr movies, = 95
param.Nmax=30; % Number of points. For 2.5hr movies, = 30
param.ss=100;
param.dim=2;
[simxy]=sim_APRW(outp,dt,param);

clear i; N=30; n_tot=size(xys,1); %N=95;  
sim_xys=cell(n_tot,1); % Empty cell assignment
for i=1:size(xys,1)
    sim_xy_full(1+N*(i-1):N+N*(i-1),:)=simxy{i};
    sim_xys{i}=sim_xy_full(1+N*(i-1):N+N*(i-1),3:4);
end
%Save the .mat file simxy --> Simulated Trajectories


%% ---------------------------------------------------- %%
%%%%%%%%%%%%%%% START OF HIGHER ORDER PARAMETER CALCULATION %%%%%%%%%%%%%%%%%%%%%%%%

%Case 1: For 8hrs datasets
%N=95;
%Case 2: For 2.5hrs datasets
%N=30; 
 
dt=5;
%param is a structure 
param.showfig=0;
param.saveres=0;
param.markertype='g-';
param.outfigurenum=301;
param.dim=2;

msd=get_MSD(sim_xys,dt,param);
%Done with MSD .... Param 1

param.tlag=1;    
param.outfigurenum=302;
    
acf=get_ACF(sim_xys,dt,param);
%Done with ACF .... Param 2


%%% DONE %%%%

  param.dxmax=50;
  param.binn=70;  
  param.outfigurenum=303;
  
  for tl=[2 20] % set tlag for PDF distribution calculation
      %2 and 20 are MSD10 and MSD100
    [feq,bin]=get_dR_PDF(sim_xys,tl,param);
  end
%Done with dR_PDF ... Param 3: Plotted for 2 points %%%%

%%%%% DONE %%%%%%%

  tlag=1; 
  param.outfigurenum1=304;
  param.outfigurenum2=305;
[outdxy,out4]=get_dR_polarity(sim_xys,tlag,param);
%Done with dR_polarity .... Param 4, 5

%%%%%% DONE %%%%%%%

param.binnum=6; % bin number between 0~180 degree
param.outfigurenum=306;
param.markertype='b-';
   tloi=[1:5:30];
    [dthout]=get_dtheta_PDF(sim_xys,tloi,param);   
%Done with dtheta_PDF .... Param 6


        param.showfig=0;
        param.saveres=0;
        param.dim=2;
        param.outfigurenum=311;
        
        tlag=1;
        [outp]=fit_APRW(sim_xys,dt,tlag,param);
     
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
     
     MSD10=msd(2,:)';
     MSD50=msd(10,:)';
     MSD100=msd(20,:)';
        %Default tlag=1


sim_cell(:,:)=[MSD10 MSD100 Pp Pnp Dp Dnp Dtot phi];
%cell_M(:,:)=[zscore(MSD6) zscore(MSD60) zscore(Pp) zscore(Pnp) zscore(Dp) zscore(Dnp) zscore(Dtot) zscore(phi)];
sim_cell_M(:,:)=[zscore(log(MSD10)) zscore(log(MSD100)) zscore(log(Pp)) zscore(log(Pnp)) zscore(log(Dp)) zscore(log(Dnp)) zscore(log(Dtot)) zscore(log(phi))];
toc;

