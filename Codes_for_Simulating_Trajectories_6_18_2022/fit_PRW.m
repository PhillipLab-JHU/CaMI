function [outp]=fit_PRW(xys,dt,param)
% analysis of anisotrpoic of P & S system 
% Investigating the whether P & S are anisotropic parameters
   if nargin==0;
        xys=get_trajfile;
    end
    if isempty(xys)
         xys=get_trajfile;
    end
    if nargin<=1;
        dt=2; 
    end    
    if nargin<=2;
        param.showfig=1;
        param.saveres=1;
        param.dim=2;
        param.outfigurenum=310;
    end
     outp=[];      
     for k=1:length(xys);  
            xy=xys{k};                         
            msd=ezmsd0(xy(:,1:param.dim)); % get msd            
            [p0,s0,se0,gof0]=msd2pse0(msd,dt,param.dim);                             
            outp=[outp;[p0,s0,se0,gof0.rsquare, gof0.rmse]];            
     end     
    if param.showfig; % show fitting resultt;
        figure(param.outfigurenum);
        [count,bin]=hist([outp(:,4)],linspace(0,1.05,20));
        bar(bin,count/sum(count),'b')
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
       
        xlswrite([pathname,filename],outp(:,1:5),'PRW fitting');   
        %delete_extra_sheet(pathname,filename);
    end    
    if nargout==0
        clear
    end
end