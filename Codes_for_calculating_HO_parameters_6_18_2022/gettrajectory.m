% get autocorrelaciton of dx,dy
figure(30);

txy=xyt;
Nc=find(txy(:,2)==1); 

N=length(Nc); % total sample size
Nc(2)=500;
fnum=Nc(2)-Nc(1); % getframe number


Nmax=25;
rss=randn(N,1); % random shuffle; 
[crap,rss]=sort(rss);

gg=ceil(sqrt(Nmax)) ;
[xgg,ygg]=meshgrid(1:gg,1:gg);
pss=200; % spacing the trajectory
xgg=xgg*pss; ygg=ygg*pss;



for k=1:Nmax
    kk=rss(k);
    xid=Nc(kk):Nc(kk+1)-1 ;
    xy=txy(xid,3:4) ;
        
%     [xy]=sim_tj;
    
    nx=xy(:,1)-mean(xy(:,1))+xgg(k);
    ny=xy(:,2)-mean(xy(:,2))+ygg(k);        
    
    figure(30);
    plot(nx,ny,'b-','linewidth',2);
    hold on;
end
hold off;
axis equal
set(gca,'xtick',[],'ytick',[]);
xlim([0 pss*(gg+1)])
ylim([0 pss*(gg+1)])
    
dt=2; % min/frame;



bjff3

disp(' done !!');