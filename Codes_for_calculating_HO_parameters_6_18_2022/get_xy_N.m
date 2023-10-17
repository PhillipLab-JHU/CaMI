function [xy_N]=get_xy_N(xy_new,N)
clear i; clear d; clear xy_N;
xy_N=[];
for i=1:size(xy_new,1)/30
    d(:,:)=xy_new(1+30*(i-1):30+30*(i-1),:);
    d_N(:,:)=d(1:N,:);
    xy_N=[xy_N;d_N];
    clear d; clear d_N;
end
end