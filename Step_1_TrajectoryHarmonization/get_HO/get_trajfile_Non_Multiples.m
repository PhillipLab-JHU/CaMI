% get_trajfile_Time_Invariance_Modified

function [xys]=get_trajfile_Non_Multiples(xy_t_hr) %t hrs into consideration and col-th possibility
       
        num=xy_t_hr(:,:);
        ui=unique(num(:,1)); %Number of cells
        tlength=zeros(size(ui));%Zeros with No. of cells
        xys=cell(size(ui)); %Empty Matrix containing individual cell data
        for k = 1:length(ui); %1 to Number of cells (should be equal to n_tot)
            col=num(:,1)==ui(k);
            tlength(k)=sum(col); % length of trajectories
            xytemp=num(col,1:end);
            [~,sid]=sort(xytemp(:,2),'ascend'); % ensure the time elapse in right order
            xytemp=xytemp(sid,3:end); % only obtain the trajectory locations.
            xys{k}=xytemp ;   % trajectories of cells.  
        end
        % END of cell generation for use in APRW Code
        
        %xlswrite(strcat(pathname,filename),xy_hr(:,1:4),strcat(num2str(col),'th'));
        %clear xy_t_hr;  %Because it is for 1 cell, it does not matter
 
end