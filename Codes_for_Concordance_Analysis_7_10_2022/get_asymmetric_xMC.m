function [x_MC_reshape]=get_asymmetric_xMC(datx,daty,t_needed,n_tot,N,MC_factor)
    
    LB=floor(t_needed); %Lower Bound
    UB=ceil(t_needed);  %Upper Bound
    
    %Because MC depends on both 'x' and 'y', we need both datasets
    %datx_reshape=reshape(datx,N,n_tot); 
    %daty_reshape=reshape(daty,N,n_tot);
    
    datx_reshape=reshape(datx,size(datx,1)/n_tot,n_tot); 
    daty_reshape=reshape(daty,size(datx,1)/n_tot,n_tot);
    
for i=1:n_tot %Individual columns
    %1point Interpolation data:
    %x_t(1:size(t_needed,1),i)=(LB==UB).*datx_reshape(LB(1:end,1),i)+(LB~=UB).*((UB(1:end,1)-t_needed(1:end,1)).*datx_reshape(LB(1:end,1),i)+(t_needed(1:end,1)-LB(1:end,1)).*datx_reshape(UB(1:end,1),i));
    %y_t(1:size(t_needed,1),i)=(LB==UB).*daty_reshape(LB(1:end,1),i)+(LB~=UB).*((UB(1:end,1)-t_needed(1:end,1)).*daty_reshape(LB(1:end,1),i)+(t_needed(1:end,1)-LB(1:end,1)).*daty_reshape(UB(1:end,1),i));
    
    %Asymmetric MC on the interpolation data:
    for j=1:size(t_needed,1)
        x_t_hr(j,i)=(LB(j,1)==UB(j,1)).*datx_reshape(LB(j,1),i)+(LB(j,1)~=UB(j,1)).*((UB(j,1)-t_needed(j,1)).*datx_reshape(LB(j,1),i)+(t_needed(j,1)-LB(j,1)).*datx_reshape(UB(j,1),i));
        y_t_hr(j,i)=(LB(j,1)==UB(j,1)).*daty_reshape(LB(j,1),i)+(LB(j,1)~=UB(j,1)).*((UB(j,1)-t_needed(j,1)).*daty_reshape(LB(j,1),i)+(t_needed(j,1)-LB(j,1)).*daty_reshape(UB(j,1),i));
        %VALIDATED UPTO THIS POINT
        delta_lx=((datx_reshape(UB(j,1),i)-datx_reshape(LB(j,1),i)))^2;
        delta_ly=((daty_reshape(UB(j,1),i)-daty_reshape(LB(j,1),i)))^2;
        delta_l=sqrt(delta_lx+delta_ly); %Needed for Scaling of the MC estimate
        
        if (LB(j,1)==UB(j,1)) || delta_l==0 %Points are merged
            x_MC(j,i)=x_t_hr(j,i); %No perturbation needed
            %if displacement in 'x' is more than or equal to displacement in 'y'
        elseif abs(datx_reshape(UB(j,1),i)-datx_reshape(LB(j,1),i))>=abs(daty_reshape(UB(j,1),i)-daty_reshape(LB(j,1),i))
            delta_x=sqrt((datx_reshape(UB(j,1),i)-datx_reshape(LB(j,1),i)).^2)/MC_factor; %Absolute MC perturbation
            delta_lx=((datx_reshape(UB(j,1),i)-datx_reshape(LB(j,1),i)))^2;
            delta_ly=((daty_reshape(UB(j,1),i)-daty_reshape(LB(j,1),i)))^2;
            delta_l=sqrt(delta_lx+delta_ly); %Needed for Scaling of the MC estimate
            
            %VALIDATE WITH actual (delta_l/2) calculations
            
            %Employ perturbation: START
            %Choose based on whichever point x_t_hr is closer to
            d_UB=sqrt((datx_reshape(UB(j,1),i)-x_t_hr(j,i))^2+(daty_reshape(UB(j,1),i)-y_t_hr(j,i))^2);
            d_LB=sqrt((datx_reshape(LB(j,1),i)-x_t_hr(j,i))^2+(daty_reshape(LB(j,1),i)-y_t_hr(j,i))^2);
            %If it is closer to the UB
            if d_LB>=d_UB
                delta_lx_prime=((datx_reshape(UB(j,1),i)-x_t_hr(j,i)))^2;
                delta_ly_prime=((daty_reshape(UB(j,1),i)-y_t_hr(j,i)))^2;
                delta_l_prime=sqrt(delta_lx_prime+delta_ly_prime);
                delta_x_prime=delta_x*delta_l_prime/(delta_l/2);
            else %If it is closer to LB
                delta_lx_prime=((datx_reshape(LB(j,1),i)-x_t_hr(j,i)))^2;
                delta_ly_prime=((daty_reshape(LB(j,1),i)-y_t_hr(j,i)))^2;
                delta_l_prime=sqrt(delta_lx_prime+delta_ly_prime);
                delta_x_prime=delta_x*delta_l_prime/(delta_l/2);
            end
            %End of the perturbation
            %The LOGIC condition takes care of the sign of the perturbation
            
            %VALIDATE with actual SIGN of 'delta_x'
            x_MC(j,i)=x_t_hr(j,i)+delta_x_prime*(datx_reshape(UB(j,1),i)>=datx_reshape(LB(j,1),i))-delta_x_prime*(datx_reshape(UB(j,1),i)<datx_reshape(LB(j,1),i));
        else 
            %In case the movement in 'y' is more than movement in 'x', no
            %need to employ perturbation in 'x'
            x_MC(j,i)=x_t_hr(j,i);
        end        
    end
end
x_t_hr_reshape=reshape(x_t_hr,size(t_needed,1)*n_tot,1);
x_MC_reshape=reshape(x_MC,size(t_needed,1)*n_tot,1);
end