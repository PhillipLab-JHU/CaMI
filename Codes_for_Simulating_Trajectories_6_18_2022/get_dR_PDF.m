function [feq,bin]=get_dR_PDF(xys,tlag0,param)
%% 3. calculate the displacement pdf   
        if nargin==0
            xys=get_trajfile;    
        end
        if isempty(xys)
            xys=get_trajfile;    
        end
       if nargin <=1
           tlag0=1;
       end
        if  nargin <=2 % set the bin size
            param.dxmax=50;
            param.binn=70;            
            param.showfig=1;
            param.saveres=1;
            param.dim=2;
            param.outfigurenum=302;
            param.markertype='bo';
        end
        dxyout=[];
         for k=1:length(xys);  
                xy=xys{k};         
                %Difference of locations
                dxy=xy(1+tlag0:end,1:param.dim)-xy(1:end-tlag0,1:param.dim) ;  
                dxyout=[dxyout,dxy];             
         end     
            binw=param.dxmax/param.binn;  %Bin width
            bin=linspace(binw/2,param.dxmax,param.binn); %All Bins
            [feq,bin]=hist(abs(dxyout(:)),bin);
            cc=feq>=0; % highlight all.
            feq=feq/sum(feq)/binw;          
            bin=bin(cc);
            feq=feq(cc);
            bin=bin(:);
            feq=feq(:);    
            
            if param.saveres
             [filename, pathname] = uiputfile( ...       
                 {'*.xlsx',  'excel files (*.xlsx)'; ...
                   '*.xls','excel file (*.xls)'}, ...             
                   'dr_pdf.xlsx','save displacement pdf');                
                xlswrite([pathname,filename],[bin feq],'pdf data');
                xlswrite([pathname,filename],[dxyout],'displacement data');
                %delete_extra_sheet(pathname,filename)
             end
            if param.showfig
                figure(param.outfigurenum); 
                semilogy(bin,feq,param.markertype,'linewidth',2); 
                xlim([0 60])
                bjff3;      
                hold on;
            end
            if nargout==0
                clear
            end
    
end