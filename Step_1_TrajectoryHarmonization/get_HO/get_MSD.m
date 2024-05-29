function [speed,msd]=get_MSD(xys,dt,param)
%% 2. calculate the MSD from trajectories   
% input:
% xys,
% dt : time step size
% output: 
%   MSD

%When no input file is provided, then nargin=0
if nargin==0; 
    xys=get_trajfile; %Outputs the cell location in correct time order
end
if nargin<=1;
    dt=1;
end
if nargin<=2;
    param.showfig=1;
    param.saveres=1;
    param.markertype='bo';
    param.outfigurenum=301;
    param.dim=2;
end

% main program
    Nc=length(xys); %Number of cells, here Nc=58
    [Nt,dim]=size(xys{1});  %Number of time and x,y location
    
    msd=zeros(Nt-1,Nc); 
    speed = zeros(1,Nc);
    msdz=0; %There is no 'z' movement
     for k=1:Nc;  %Looping through each cell
        xy=xys{k};     
        
        % Calculate speed:
        start = xy(1,:);
        dist_list = [];
        for j=2:length(xy)
            next = xy(j,:);
            dist = sqrt(sum((next - start).^2));
            dist_list = [dist_list dist];
            start = next;
        end
        speed(k) = mean(dist_list) / dt; 
        
        msdx=ezmsd1d_v1(xy(:,1));
        msdy=ezmsd1d_v1(xy(:,2));     
        if dim==3
            msdz=ezmsd1d_v1(xy(:,3));
        end
        msd0=msdx+msdy+msdz; 
        msd(:,k)=msd0(:);     % output the msd        
     end
     meanMSD=mean(msd,2); %Mean MSD per cell
     tii=[1:length(meanMSD)]'*dt; %Mapping to actual time (min)
     
     
     
     % output the msd data to the excel file
     if param.saveres
     [filename, pathname] = uiputfile( ...       
         {'*.xlsx',  'excel files (*.xlsx)'; ...
           '*.xls','excel file (*.xls)'}, ...             
           'save MSD');        
        
        xlswrite([pathname,filename],[tii,msd],'individual msd');
        xlswrite([pathname,filename],[tii,meanMSD],'average msd');
        
        delete_extra_sheet(pathname,filename)
     end
          
     %%% plot #1: ensemble average msd
     if param.showfig
        figure(param.outfigurenum);            
            loglog(tii,meanMSD,param.markertype,"Color", param.MarkerEdgeColor,"MarkerEdgeColor", param.MarkerEdgeColor,'MarkerSize',3,"linewidth",0.25);   
                bjff3;
                xlim([1 1e3])
                set(gca,'xtick',10.^[0:3]);
                ylim([1 1e4])
                set(gca,'ytick',10.^[0:4]);
              hold on
     end
     if nargout==0
         clear 
     end
end