% require the pre loaded dxy
% 1. wt/2. arp23, 3. cdc42,4. ck636, 5. coractin, 6. nwasp
% .
for kn=1
txy=xyt;
Nc=find(txy(:,2)==1); 

N=length(Nc); % total sample size
Nc(end+1)= length(txy(:,1))+1; % computation purpose
fnum=Nc(2)-Nc(1); % getframe number

tlag=1; % unit of frame
vout=[];mout=[];

for k=1:N
    try
    xid=Nc(k):Nc(k+1)-1 ;
    xy=txy(xid,3:4) ;
%     xy=sim_tj;
    dxy=xy(1+tlag:end,:)-xy(1:end-tlag,:) ;
    msdx=ezmsd1d_v1(xy(:,1));
    msdy=ezmsd1d_v1(xy(:,2));
    msdn=msdx+msdy;
    
    mout=[mout,msdn(1:maxN-1,:)];
    vout=[vout; dxy(1:maxN-1,:)];

    catch
    end
end

dt=2; % min/frame;
ti=(1:length(mout(:,1)))*dt;
cid={[0 0 1],[0 1 0],[1 0 0],[1 1 0],[0 1 1],[1 0 1]};

figure(kn);
loglog(ti',mout,'b-','linewidth',1);
    xlim([1 1000]) ;
    ylim([1 1e5]) ;
    set(gca,'xtick',[1 10 100 1000])
    set(gca,'ytick',[1 10 100 1000 1e4 1e5]);
    bjff3;
    
% figure(8);
%     mm=log10(mout(1,:));
%     bin=linspace(-1,3,25);
%     [c1]=hist(mm,bin); c1=c1/sum(c1);
%     
%     plot(bin,c1,'-','linewidth',2,'color',cid{kn});    hold on;
%     bjff3;

figure(7);
loglog(ti',mean(mout,2),'-','linewidth',2,'color',cid{kn}); hold on;
    xlim([1 1000]) ;
    ylim([1 1e5]) ;
    set(gca,'xtick',[1 10 100 1000])
    set(gca,'ytick',[1 10 100 1000 1e4 1e5])
%     temp=mean(mout,2);
%     tempidx=unique(round(logspace(log10(1),log10(length(temp)),10)));%
%     
%     loglog(ti(tempidx)',temp(tempidx),'ro');
    bjff3;
end    


% 

disp(' done !!');

velocity1h=sqrt(mout(20,:))./60;
velocity10h=sqrt(mout(300,:))./600;
velocity2h=sqrt(mout(60,:))./120;
velocity5h=sqrt(mout(150,:))./300;
velocity15h=sqrt(mout(450,:))./900;
velocity10h=transpose(velocity10h);
velocity2h=transpose(velocity2h); 
velocity1h=transpose(velocity1h);
velocity5h=transpose(velocity5h); 
velocity15h=transpose(velocity15h); % Velocity at 1H