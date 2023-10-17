function show_traj(xys)
%% 1. Plot all trajectoreis 
if nargin==0
     xys=get_trajfile;
end

figure(); 
    Nc=length(xys); % number of cell trajectories 
    cidk=jet((Nc));
    %cidk=jet((Nc)); % generate different colors for different trajectoreis. 
      for k=1:Nc;  
         xy=xys{k};             
         xy=[xy(:,1)-xy(1,1), xy(:,2)-xy(1,2)];           
         plot(xy(:,1),xy(:,2),'-','color',cidk(k,:),'linewidth',2); hold on;     
      end
    axis equal
    xlim([-400 400]);
    ylim([-400 400]);
      set(gca,'xtick',[],'ytick',[]);
   bjff3;
end 
