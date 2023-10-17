function [simxy]=sim_APRW(outp,dt,param)
% analysis of anisotrpoic of P & S system 
% Investigating the whether P & S are anisotropic parameters
   if nargin==0;
        [filename, pathname] = uigetfile( ...
          {'*.xlsx;*.xls;*.mat','fitting parameter files (*.xlsx,*.xls,*.mat,)';
       '*.xlsx',  'excel files (*.xlsx)'; ...
       '*.xls','excel file (*.xls)'; ...
       '*.mat','MAT-files (*.mat)'; ...  
       '*.*',  'All Files (*.*)'}, ...
       'select fitting parameters');
     xlsfile=[pathname,filename];
     
     [outp1,~,~]=xlsread(xlsfile,'APRW fitting-p');
     [outp2,~,~]=xlsread(xlsfile,'APRW fitting-np');
     outp=[outp1,outp2];
     
     try 
        [outp3,~,~]=xlsread(xlsfile,'APRW fitting-np2');
        outp=[outp,outp3];      
     catch         
     end
     
    end
    
    if nargin<=1;
        dt=2; 
    end    
    if nargin<=2;
        param.showfig=1;
        param.saveres=1;
        param.Nmax=500;
        param.ss=100;
        param.dim=2;
    end                
    xys00=[];
    simxy={};
    ss=param.ss;
    Nmax=param.Nmax;
    for k=1:length(outp(:,1))     
         fres=[];
         for kd=1:param.dim
          fres= [fres;outp(k,[1:3]+((kd-1)*5))];
         end
         dim=param.dim;
         parfor repeat=1:1;                 
%                 [xyss0]=sim_tj_ou_ps_xy_v2(fres,fres2,dt,Nmax); 
                [xyss0]=sim_tj_aprw(fres,dt,Nmax,dim);
                xyss0=[ones(size(xyss0(:,1)))*k*ss+repeat [1:length(xyss0(:,1))]' xyss0];
                xys00 =[xys00;xyss0];
                simxy = [simxy; {xyss0}];
         end          
    end
     
    if param.showfig; % show fitting resultt;
     
    end
    
    if param.saveres % save the fitted results;
        [filename, pathname] = uiputfile( ...       
         {'*.xlsx',  'excel files (*.xlsx)'; ...
           '*.xls','excel file (*.xls)'}, ...             
           'save simulated trajectory data','sim_traj_APRW');               
        xlswrite([pathname,filename],xys00(1:475000,:),'sim_traj_APRW_1');                 
        xlswrite([pathname,filename],xys00(475001:950000,:),'sim_traj_APRW_2');
        xlswrite([pathname,filename],xys00(950001:end,:),'sim_traj_APRW_3');
        %delete_extra_sheet(pathname,filename);
 
    end    
    if nargout==0
        clear
    end
end
    