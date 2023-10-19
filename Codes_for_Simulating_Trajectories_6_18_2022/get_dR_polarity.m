function [outdxy,out4]=get_dR_polarity(xys,tlag,param)
%% 4.

% initiating..
    if nargin==0;
        xys=get_trajfile;    
    end
    if isempty(xys)
        xys=get_trajfile;
    end
    if nargin <=1;
        tlag=1;
    end
    if nargin <=2 % set the bin size        
        param.showfig=1;
        param.saveres=1;
        param.markertype='bo';
        param.dim=2;
        param.outfigurenum1=305;
        param.outfigurenum2=306;
    end
    
 % main process   
     outdxy=[];  %Rotated vector wrt to mean
     out4=[];    %Some angles in degrees 
     for k=1:length(xys);  
            xy=xys{k};             
            dxy=xy(1+tlag:end,1:param.dim)-xy(1:end-tlag,1:param.dim) ;   
            % How to identify the major axis of trajectories
            xyr=[xy(:,1)-mean(xy(:,1)),xy(:,2)-mean(xy(:,2))];%Value wrt mean of observed data
            if param.dim==3
                xyr=[xyr, xy(:,3)-mean(xy(:,3))];
            end
            
            [~,~,rm]=svd(dxy(:,1:param.dim));      % obtain the rotational matrix  
%             [~,~,rm]=svd([xyr(:,1),xyr(:,2)]);      % obtain the rotational matrix  
            dxyr=dxy(:,1:param.dim)*rm;   % rotate the vector
         
            % only quantify the first two axis
            [thr,~]=cart2pol(dxyr(:,1),dxyr(:,2)) ;
            thr=thr/pi*180; %In degrees
            thr(thr<0)=thr(thr<0)+360; %Converts negative to positive angles
            
            xyr=xyr*rm;            
            outdxy=[outdxy; dxyr];  %Rotated vector wrt to mean                   
            out4=[out4,thr(:)] ;    %Some angles in degrees
     end     
                       
     
    if param.showfig
    figure(param.outfigurenum1);
%         bino=linspace(0,360,20);
%         bino=bino(1:end-1);
        [c1,c2]=hist(out4(:),20);
        c1=c1/sum(c1)/(c2(2)-c2(1));       
        c2=c2/180*pi;
        cx=c1.*cos(c2); % x component of probability
        cy=c1.*sin(c2); % y component of probability

%         plot(c2,c1,'linestyle',ltpp{ltp},'color',cid2(ddt,:),'linewidth',2); hold on;    
%       Plotting the angles
        plot(cx([1:end,1]),cy([1:end,1]),param.markertype,'linewidth',2); hold on;         

        axis equal;
        xlim([-0.007 0.007]);
        ylim([-0.007 0.007]);
        set(gca,'xtick',[-0.01 0 0.01])
        set(gca,'ytick',[-0.01 0 0.01])
        bjff3;
        axis off;
        hold on;
        
   figure(param.outfigurenum2);
        [ang,rho]=cart2pol(outdxy(:,1),outdxy(:,2));
        [angpoint]=linspace(-pi,pi,25);
        
        angstep=angpoint(2:end)/2+angpoint(1:end-1)/2;
        angrho=zeros(length(angstep),3);
        for kaa=1:length(angpoint)-1
            cc=ang >= angpoint(kaa) & ang < angpoint(kaa+1);
            angrho(kaa,:)=[angstep(kaa),mean(rho(cc)),median(rho(cc))];
        end
        axx=angrho(:,2).*cos(angrho(:,1))/mean(angrho(:,2));
        ayy=angrho(:,2).*sin(angrho(:,1))/mean(angrho(:,2));        
        aid0=[1:length(axx) 1];
        plot(axx(aid0),ayy(aid0),param.markertype); bjff3;
        axis equal;
        xlim([-1.5 1.5]);
        ylim([-1.5 1.5]);
        axis off
        hold on;
    end
     
        if param.saveres
         [filename, pathname] = uiputfile( ...       
             {'*.xlsx',  'excel files (*.xlsx)'; ...
               '*.xls','excel file (*.xls)'}, ...             
               'dr_pdf.xlsx','save displacement pdf');                
            xlswrite([pathname,filename],[cx(:) cy(:)],'angular frequency');
            xlswrite([pathname,filename],[axx(:) ayy(:)],'v(orientation)');
            delete_extra_sheet(pathname,filename);
        end
        if nargout==0
            clear
        end
         
end