%% Function to get N=30, dt=5min from N_new and dt=5min
function [d_30]=get_N_dt(d,N_new)
d2=d(:,1);
d3=d(:,2);
x=d(:,3);
y=d(:,4);

d2_r=reshape(d2,N_new,size(d2,1)/N_new);
d3_r=reshape(d3,N_new,size(d2,1)/N_new);
x_r=reshape(x,N_new,size(d2,1)/N_new);
y_r=reshape(y,N_new,size(d2,1)/N_new);

d2_r1=reshape(d2_r(1:30,:),30*size(d2,1)/N_new,1);
d3_r1=reshape(d3_r(1:30,:),30*size(d2,1)/N_new,1);
x_r1=reshape(x_r(1:30,:),30*size(d2,1)/N_new,1);
y_r1=reshape(y_r(1:30,:),30*size(d2,1)/N_new,1);

d_30=[d2_r1, d3_r1, x_r1, y_r1];

end