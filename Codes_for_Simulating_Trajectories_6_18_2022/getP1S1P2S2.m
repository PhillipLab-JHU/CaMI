dt = 5; %time lag
P1S1out = [];
P2S2out = [];

for k=1:N
    kk=rss(k);
    xid=Nc(kk):Nc(kk+1)-1 ;
    
    xy=txy(xid,3:4) ;

    [P1,S1,P2,S2,SE1,SE2,gof1,gof2]=xy2aprwmodel(xy,dt);
    
    P1S1out = [P1S1out; [P1 S1*sqrt(2) SE1 gof1.rsquare]];
    P2S2out = [P2S2out; [P2 S2*sqrt(2) SE2 gof2.rsquare]];
    
end

Dp_APRW = (P1S1out(:,1).*P1S1out(:,2).^2)/4; %calculate diffusion in primary axis
Ds_APRW = (P2S2out(:,1).*P2S2out(:,2).^2)/4; %calculate diffusion in secondary axis

Anisotropy = Dp_APRW./Ds_APRW; % the ratio of Dp and Ds (long term diffusion ratio)

D_tot_APRW = Dp_APRW + Ds_APRW;