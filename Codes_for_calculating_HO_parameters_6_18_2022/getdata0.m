% readdata from excel files.

% In this program, be sure to check frame number "maxN in getdata0.m" based on 2D or 3D
% data. For theta distribution, the graph changes based on time lag
% choosen. So make sure to change time lag "ddt in get_theta0.m". Also, the
% graph becomes noisy when you consider higher time lags (example- 1h) for theta
% distribution. To smoothen the graphs, you can change bin number in "binum
% in gettheta0.m"
clc;clear;close all

cph=pwd;
fd=uigetdir;
% fd='2D\arp23 2d\36499';
cd(fd);
a=dir('*.xls*');
tstep=3; % min/frame
out=[];
maxN=200; %%%%%%%%%%%%%%%%%%change frame number for 2D/3D
for k=1:length(a);
    num=xlsread(a(k).name);
    out=[out;num];
end
cd(cph);
xyt=out;
gettj0; % get trajectory figure
%getmsd0; % get msd

msdout=mout;
PSout=[];
% fit msd to persistent random walk model
for kk=1:length(mout(1,:));
    [P,S,SE,gof]=msd2ps(mout(:,kk),tstep);
    PSout=[PSout; [P S SE gof.rsquare]];
    
end
    [P,S,SE,gof]=msd2ps(mean(mout,2),tstep);
    PSoutm= [P S SE gof.rsquare];
    
% get dtheta distribution;
%%%%%%%%%%%%%%%%%% bin number for output figure, change this to change bin number
%ddt=30; % frame lag step. % for reduce the time steps.
get_theta0;

getP1S1P2S2;

Dtotal=Dp+Ds; % Dtotal

% velocity10h=sqrt(mout(300,:))./600;
% velocity2h=sqrt(mout(60,:))./120;
% velocity5h=sqrt(mout(150,:))./300;
% velocity15h=sqrt(mout(450,:))./900;
% velocity10h=transpose(velocity10h);
% velocity2h=transpose(velocity2h); 
% velocity5h=transpose(velocity5h); 
% velocity15h=transpose(velocity15h);