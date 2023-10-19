function [outp]=fit_APRW(xys,dt,tlag,param)
% analysis of anisotrpoic of P & S system 
% Investigating the whether P & S are anisotropic parameters
   if nargin==0;
        xys=get_trajfile;
    end
    if isempty(xys)
         xys=get_trajfile;
    end
    if nargin<=1;
        dt=3; 
    end
    if nargin<=2;
        tlag=1;
    end
    if nargin<=3;
        param.showfig=1;
        param.saveres=1;
        param.dim=2;
        param.outfigurenum=311;
    end
     outp=[]; 
     
     for k=1:length(xys);   %Iterate over all cells
         %  xys is a structure that contains all cells xys(k) is 'kth' cell
            xy=xys{k};  %Get a single cell
            xy=xy(:,1:param.dim);    %For the single cell        
            dxy=xy(1+tlag:end,:)-xy(1:end-tlag,:) ;   %Instantaneous velocity
            % identify the major axis of trajectories
            xyr=xy-ones(size(xy(:,1)))*mean(xy); %For a single cell
%             xyr=[xy(:,1)-mean(xy(:,1)),xy(:,2)-mean(xy(:,2))];                 
            [~,~,rm]=svd(dxy);      % obtain the rotational matrix  
%             [~,~,rm]=svd([xyr(:,1),xyr(:,2)]);      % obtain the rotational matrix                          
            xyr=xyr*rm; % rotate the x-y for a single cell        
            
%             for ki=1:length(xyr(1,:))
                %Get general MSD for all possible 'tau'
               msdp1=ezmsd0(xyr(:,1)); %Primary axis of the single cell
               msdnp1=ezmsd0(xyr(:,2)); %Secondary axis of the single cell
               
               if param.dim==3
                   msdnp1=msdnp1+ezmsd0(xyr(:,2));
               end
               
               [p,s,se,gof]=msd2pse0(msdp1+1e-30,dt,1);  % fit msd using PRW\ Primary Axis
               [p2,s2,se2,gof2]=msd2pse0(msdnp1+1e-30,dt,param.dim-1);  % fit msd using PRW\ Secondary Axis
               outpi=[[p,s,se,gof.rsquare,gof.rmse],[p2,s2,se2,gof2.rsquare,gof2.rmse]];
%             end            
            outp=[outp;outpi];            
     end     

    if param.showfig; % show fitting resultt;        
         figure(param.outfigurenum);        
        for k=1:param.dim;               
            [count,bin]=hist(outp(:,(k-1)*5+4),linspace(0,1.05,20));
            subplot(param.dim,1,k)
            bar(bin,count/sum(count),'b');
        end
        % show histogram of aprw model fitting
    end
    if param.saveres % save the fitted results;
        [filename, pathname] = uiputfile( ...       
         {'*.xlsx',  'excel files (*.xlsx)'; ...
           '*.xls','excel file (*.xls)'}, ...             
           'save MSD','MSDres');               
       test=dir([pathname,filename]);
       if ~isempty(test) % delete exisiting excel file
           delete([pathname,filename]);
       end       
        xlswrite([pathname,filename],outp(:,1:5),'APRW fitting-p');
        xlswrite([pathname,filename],outp(:,6:10),'APRW fitting-np');
        
        %delete_extra_sheet(pathname,filename)
    end
    
    if nargout==0
        clear
    end
end
    