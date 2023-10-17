function acf=get_ACF(xys,dt,param)               
 %%  compute the auto correlation function
     if nargin==0
        xys=get_trajfile;
     end
    if nargin<=1;
        dt=1;
    end
    if nargin<=2;
        param.showfig=1;
        param.saveres=1;
        param.markertype='bo';
        param.outfigurenum=303;
        param.tlag=1;
        param.dim=2;
    end
    
    acf=[];
    tlag=param.tlag;
    for k=1:length(xys); %Equals the number of cells 
        xy=xys{k}; %Some structure containing each cell's location
        dxy=xy(1+tlag:end,1:param.dim)-xy(1:end-tlag,1:param.dim);           
        M=length(dxy(:,1));       
        cef=[]; 
        tll=[];
        for k=0:M-1
            cef(k+1)=sum(sum(dxy(1:M-k,:).*dxy(1+k:M,:),2))/(M-k);  % using inner dot (taking vector)           
            tll(k+1)=k; % unit of time lag
        end 
        acf=[acf, cef(:)] ;  
    end    
    
    if param.showfig
       figure(param.outfigurenum);             
           m33=mean(acf,2);  % average profile of ACF      
           m33=m33/m33(3);  % normalization wrt to 2*dt        
           tll=tll(:); % unit of time lag
           cc0=tll>=2 & tll< 50  ; % set time lag range, get rid of first two points       
           m33=m33(cc0); 
           tll0=tll(cc0);              
           semilogy(tll0*dt,(m33),param.markertype,'linewidth',2); hold on;                  
           xlim([0 50])
           ylim([1e-3 1e0])
           bjff3;  
           hold on;    
    end
    
    if param.saveres
          [filename, pathname] = uiputfile( ...       
         {'*.xlsx',  'excel files (*.xlsx)'; ...
           '*.xls','excel file (*.xls)'}, ...             
           'output MSD to a excel file');               
        xlswrite([pathname,filename],[tll(:) acf],'individual ACF');
        xlswrite([pathname,filename],[tll(:) ,mean(acf,2)],'average ACF');
        %delete_extra_sheet(pathname,filename);
    end
    
    if nargout==0
        clear acf
    end
end
    
