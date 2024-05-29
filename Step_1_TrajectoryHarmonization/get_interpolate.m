function [xy_t_hr_reshape]=get_interpolate(dat,t_needed,n_tot,N)
    
    LB=floor(t_needed); %Lower Bound
    UB=ceil(t_needed);  %Upper Bound
    dat_reshape=reshape(dat,N,n_tot);
    
    
for i=1:n_tot %Individual columns
    %Interpolate between upper and lower bounds
    %for j=1:N
    %xy_t_hr(1,i)=dat_reshape(t_needed(1,1),i);
    
    xy_t_hr(1:size(t_needed,1),i)=(LB==UB).*dat_reshape(LB(1:end,1),i)+(LB~=UB).*((UB( 1:end,1)-t_needed(1:end,1)).*dat_reshape(LB(1:end,1),i)+(t_needed(1:end,1)-LB(1:end,1)).*dat_reshape(UB(1:end,1),i));

end

xy_t_hr_reshape=reshape(xy_t_hr,size(t_needed,1)*n_tot,1);

end