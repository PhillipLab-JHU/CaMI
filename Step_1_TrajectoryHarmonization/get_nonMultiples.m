%% Function to get_nonMultiples or Multiples:
%% INPUTS to the function 'get_nonMultiples' :
% 1. d = Raw Trajectories of the order: Cell Number | Time Point | X | Y
% 2. dt_actual = Actual time difference between two time points of the Raw Trajectories
% 3. N = No. of time points in the raw trajectories per cell
% 4. dt_needed = Time difference we need to calculate the Trajectories for
% 5. type = 0 if you want simple interpolation; 1 if you want pseudo
% montecarlo interpolation.
% either using Interpolation or pseudo Monte Carlo

function [xy_t_hr_MC]=get_nonMultiples(d,dt_actual,N,dt_needed,type)

%MC factor:
MC_factor = 0;
if type == 0
    MC_factor=1e20;  %If we just want to use simple interpolation
else
    MC_factor=2.01;   %If we want to use pseudo MC
end
% disp(MC_factor)

d2=d(:,1);
d3=d(:,2);
x=d(:,3);
y=d(:,4);

t_actual=[0:dt_actual:(N-1)*dt_actual]'; %Actual time points
%The indices of t_actual will be used for actual data points
n_tot=size(x,1)/N; %n_tot=Total number of cells in the given raw trajectories


% Reshaping the actual data for better tabular visualization and
% troubleshooting
d2_reshape=reshape(d2,N,n_tot); %Global definition of N and n_tot
d3_reshape=reshape(d3,N,n_tot);
x_reshape=reshape(x,N,n_tot);
y_reshape=reshape(y,N,n_tot);

%Multiples of dt_needed, 0,1,2,3....<=(N-1)*dt_actual
lambda=dt_needed./dt_actual;

if lambda==round(lambda) %If lambda is an integer
    
    dt_modified=dt_actual*lambda;
    t_needed=[1:lambda:N]';  %Take only those timepoints that are needed
    for i=1:n_tot
        xy_t_hr2(:,i)=d2_reshape(t_needed,i);
        xy_t_hr3(:,i)=d3_reshape(t_needed,i);
        xy_t_hr4(:,i)=x_reshape(t_needed,i);
        xy_t_hr5(:,i)=y_reshape(t_needed,i);
    end
    
    %t_needed is the array that links everything
    x_MC=get_asymmetric_xMC(d(:,3),d(:,4),t_needed,n_tot,N,MC_factor);
    y_MC=get_asymmetric_yMC(d(:,3),d(:,4),t_needed,n_tot,N,MC_factor);
    
    m=size(t_needed,1);
    xy_t_hr=[reshape(xy_t_hr2,m*n_tot,1) reshape(xy_t_hr3,m*n_tot,1) reshape(xy_t_hr4,m*n_tot,1) reshape(xy_t_hr5,m*n_tot,1) ];
    xy_t_hr_MC=[reshape(xy_t_hr2,m*n_tot,1) reshape(xy_t_hr3,m*n_tot,1) x_MC y_MC];
    %clear xy_t_hr2; clear xy_t_hr3; clear xy_t_hr4; clear xy_t_hr5; %Once they are assigned, they are cleaned up
    %x=x(every lambda times)
    xy_t_hr4_reshape=reshape(xy_t_hr4,m,n_tot);
    xy_t_hr5_reshape=reshape(xy_t_hr5,m,n_tot);
    
    x_MC_reshape=reshape(x_MC,size(t_needed,1),n_tot);
    y_MC_reshape=reshape(y_MC,size(t_needed,1),n_tot);
else
    %First find out the interpolation points
    timepoints_actual=[0:(N-1)]'*dt_actual; %Actual time points
    
    temp_t=([(1+lambda):lambda:N]');
    t_needed(1,1)=1; %First element is same by default
    
    %This allocation is wrong, because of MATLAB's inbuilt error
    %Hence, allocate the multiples first and then proceed
    t_needed(2:(size(temp_t,1)+1),1)=([(1+lambda):lambda:N]');
    
    %Reassign t_needed because of MATLAB's inbuilt error
    %If (l_needed-1)*dt_actual is a multiple of dt_needed then assign them
    %separately
    for l_t_needed=1:size(t_needed,1)
        if (((l_t_needed-1)*dt_needed)/dt_actual)==round((((l_t_needed-1)*dt_needed)/dt_actual))
            t_needed(l_t_needed,1)=round(t_needed(l_t_needed,1));
        end
    end
    
    %Get interpolation data:
    xy_t_hr2=get_interpolate(d(:,1),t_needed,n_tot,N);
    xy_t_hr3=get_interpolate(d(:,2),t_needed,n_tot,N);
    xy_t_hr4=get_interpolate(d(:,3),t_needed,n_tot,N);
    xy_t_hr5=get_interpolate(d(:,4),t_needed,n_tot,N);
    %INTERPOLATION MATRIX
    xy_t_hr=[xy_t_hr2 xy_t_hr3 xy_t_hr4 xy_t_hr5];
    
    %Get pMC data: ASYMMETRIC MC MATRIX
    x_MC=get_asymmetric_xMC(d(:,3),d(:,4),t_needed,n_tot,N,MC_factor);
    y_MC=get_asymmetric_yMC(d(:,3),d(:,4),t_needed,n_tot,N,MC_factor);
%     disp(MC_factor)
    xy_t_hr_MC=[xy_t_hr2 xy_t_hr3 x_MC y_MC];
    
end

end