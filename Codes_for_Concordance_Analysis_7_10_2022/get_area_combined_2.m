%% Extract data from file and calculate Area of triangle accordingly:
function [Area]=get_area_combined_2(xy_temp,N,n_tot)
%tempf='C:\Users\SunLabUser\Documents\MATLAB\Ageing motility tracking data\Ageing_Data_in_excel\';
%data=load(strcat(tempf,'Supplementarydataset1.txt'));
%convert=0.45; %For Sean's 10X objective
convert=1; %For Jude Phillip's ageing data
x=xy_temp(:,3)*convert; %All x-data
y=xy_temp(:,4)*convert; %All y-data
%N=200;%Number of time points, which can vary from experiments to experiments which we know already
%Get individual cells
%n_tot=size(x,1)/N; %Total number of cells
%dt=3; %Data acquisition time=3min
%N_max=(N-1); %Max number of tau=N_max
for i=1:n_tot
    m=0;
    for j=1+N*(i-1):2:N-2+N*(i-1) %An individual cell
        m=m+1;
        P1=[]; P2=[]; P3=[];
        P1=[x(j,1) y(j,1)]; P2=[x(j+1,1) y(j+1,1)]; P3=[x(j+2,1) y(j+2,1)];
        Area(i,m)=abs(0.5*det([P1(1,1) P1(1,2) 1; P2(1,1) P2(1,2) 1; P3(1,1) P3(1,2) 1])); %N_rows=n_tot; N_columns=j
    end
end

end