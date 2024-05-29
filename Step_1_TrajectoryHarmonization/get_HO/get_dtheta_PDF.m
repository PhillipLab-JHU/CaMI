function [dthout]=get_dtheta_PDF(xys,tloi,param)
 %% 5. calculate angle displacement PDF.     
    if nargin==0;
        xys=get_trajfile;    
    end    
    if isempty(xys)
        xys=get_trajfile;
    end
    if nargin <=1
        tloi=[1 10 40];
    end
    if nargin <=2
        param.showfig=1;
        param.saveres=1;
        param.markertype='-';
        param.outfigurenum=304;
        param.dim=2;
        param.binnum=6; % bin number between 0~180 degree
       
    end
    
    dthout=cell(size(tloi));
     for k=1:length(xys);  
         xy=xys{k}; 
         for kt=1:length(tloi);         
             xytemp0=xy(1:tloi(kt):end,1:param.dim);
             dxyt=xytemp0(2:end,1:param.dim)-xytemp0(1:end-1,1:param.dim);
%             [~,dr]=cart2pol(dxyt(:,1),dxyt(:,2)) ; 
            dr=sqrt(sum(dxyt(:,1:param.dim).^2,2));
        % using inner dot to compute angle, check points
                dth00=acos(sum(dxyt(2:end,1:param.dim).*dxyt(1:end-1,1:param.dim),2)./ (dr(2:end).*dr(1:end-1)));
                dth00=dth00/pi*180; % convert to degree     
            dthout{kt}=[dthout{kt};dth00(:)];
         end  
     end         
         
        cid=jet(length(tloi));
        outc1=[];
        for kktt=1:length(tloi)
            out1=dthout{kktt}; 
            bino=param.binnum;
            [c1,c2]=hist(abs(out1(:)),bino);
            c1=c1/sum(c1)/(c2(2)-c2(1)); % compute the probably of occurrence     
            outc1=[outc1,c1(:)];
             if param.showfig      
                  figure(param.outfigurenum);
                 plot(c2,c1,param.markertype,'color',cid(kktt,:),'linewidth',2); hold on;         
                ylim([0 1/180*2]);
                xlim([0 180]);
                set(gca,'xtick',[0:4]*45);
                bjff3; 
                hold on               
             end
             
        end     
     
     
     if param.saveres
        
         [filename, pathname] = uiputfile( ...       
             {'*.xlsx',  'excel files (*.xlsx)'; ...
               '*.xls','excel file (*.xls)'}, ...             
               '*.xlsx','dtheta_PDF');                            
            xlswrite([pathname,filename],[c2(:) outc1],'dtheta_PDF','A2');
            xlswrite([pathname,filename],[tloi(:)'],'dtheta_PDF','B1');
            xlswrite([pathname,filename],{'bin'},'dtheta_PDF','A1');
            
          %  delete_extra_sheet(pathname,filename);
%             xlswrite([pathname,filename],[axx(:) ayy(:)],'v(orientation)');
        
     end
     if nargout==0
         clear
     end

end