function [simxy]=sim_PRW(outp,dt,param)
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
     [outp,~,~]=xlsread(xlsfile,'PRW fitting');
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
    Nmax=param.Nmax;
    dim=param.dim;
    ss=param.ss;
    for k=1:length(outp(:,1))     
         P=outp(k,1);
         S=outp(k,2);
         SE=outp(k,3);            
         parfor repeat=1:3;                                                                        
                [xyss0]=sim_tj_prw([P,S,SE],dt,Nmax,dim);
                xyss0=[ones(size(xyss0(:,1)))*k*ss+repeat [1:length(xyss0(:,1))]' xyss0];
                xys00 =[xys00;xyss0]; % for output to excel
                simxy = [simxy; {xyss0}]; % for output variable
         end          
    end
     
    if param.showfig; % show fitting resultt;
       
    end
    
    if param.saveres % save the fitted results;
        [filename, pathname] = uiputfile( ...       
         {'*.xlsx',  'excel files (*.xlsx)'; ...
           '*.xls','excel file (*.xls)'}, ...             
           'save simulated trajectory data','sim_traj_PRW');               
        xlswrite([pathname,filename],xys00,'sim_traj_PRW');                 
        %delete_extra_sheet(pathname,filename);
 
    end    
    if nargout==0
        clear
    end
end
    