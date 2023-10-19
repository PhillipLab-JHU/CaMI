
%% Case by Case Entropy calculations:
% Main input(s):
% R_comp_group: Contains temporal transition information for a single cell, 
% example, SG1 -> SG2 --> SG2 --> CG1
% cond_c_<condition name> : Contains temporal transition information for single
% cells of an individual condition. This data can be extracted from
% R_comp_group and knowing the indices of cells in a specific condition as
% obtained from 'global_actual_full' (it is of format: Condition Number | Cell
% Number | Time point | X | Y)

% Load the pertinent 8hr or 2.5hr datasets:
%load('C:\Users\Jude Phillip\Documents\MATLAB\My_Codes\Datasets_For_Paper\global_actual_full.mat');
%load('C:\Users\Jude Phillip\Documents\MATLAB\My_Codes\Datasets_For_Paper\R_comb_group.mat');
% Extract data using the pattern demonstrated below (examples are demonstrated for different biological modules). 
% A 'cell' is generated per condition. Use that 'cell' to calculate temporal entropies.



%% Transition Entropy: Calculate Entropy at each transition (S_T1toT2, S_T2toT3 and S_T3toGT4)[NEW VERSION]:
% Enter the specific condition you want to calculate entropy for:
% R_comb_temp=<pertinent condition>. R_comb temp contains the temporal transition information Also commented below
% To calculate for all cases use: for q=1:1 & R_comb_temp=R_comb_group;
clear q; 
S_1to2=[]; S_2to3=[]; S_3toC=[]; S_net=[]; S_mean=[]; S_combined=[];
%for q=1:1
for q=1:max(size(cond_c_Ly12_vary_CN))
    R_comb_temp=[]; R_comb_temp=cond_c_Ly12_vary_CN{q}; %Enter the specific condition
   %R_comb_temp=[]; R_comb_temp=R_comb_group; %R_comb_group for all cases
    T_1to2=[]; T_2to3=[]; T_3toC=[];
    clear i; clear j; 
    for i=1:4
        for j=1:4
            T_1to2(i,j)=(size(find((R_comb_temp(:,1)==i & R_comb_temp(:,2)==j)),1));
            T_2to3(i,j)=(size(find((R_comb_temp(:,2)==i & R_comb_temp(:,3)==j)),1));
            T_3toC(i,j)=(size(find((R_comb_temp(:,3)==i & R_comb_temp(:,4)==j)),1));
        end
    end
    T_1to2=T_1to2./(max(size(R_comb_temp))); S_1to2(q,1)=-sum(sum(T_1to2.*log(T_1to2+1e-18)));
    T_2to3=T_2to3./(max(size(R_comb_temp))); S_2to3(q,1)=-sum(sum(T_2to3.*log(T_2to3+1e-18)));
    T_3toC=T_3toC./(max(size(R_comb_temp))); S_3toC(q,1)=-sum(sum(T_3toC.*log(T_3toC+1e-18)));
    S_net(q,1)=sum(S_1to2(q,1)+S_2to3(q,1)+S_3toC(q,1)); S_mean(q,1)=S_net(q,1)/3;   
end
S_combined=[S_1to2'; S_2to3'; S_3toC'; S_net'; S_mean'];
S_combined=S_combined';

figure(1)
subplot(3,1,1)
bar(S_1to2); title('Transition Entropies T1 to T2')
ylim([0 3]);
subplot(3,1,2)
bar(S_2to3); title('Transition Entropies T2 to T3')
ylim([0 3]);
subplot(3,1,3)
bar(S_3toC); title('Transition Entropies T3 to T')
ylim([0 3]);


%% State Entropy: Calculate Entropy at each stage (S_T1, S_T2, S_T3 and S_T4)[NEW VERSION]:
% Enter the specific condition you want to calculate entropy for:
% R_comb_temp=<pertinent condition>. Also commented below
% To calculate for all cases use: for q=1:1 & R_comb_temp=R_comb_group;
clear q; 
S_T1=[]; S_T2=[]; S_T3=[]; S_T4=[]; S_net=[]; S_C=[]; S_mean=[]; S_combined=[];
%for q=1:1
for q=1:max(size(cond_c_Ly12_vary_CN))
    R_comb_temp=[]; R_comb_temp=cond_c_Ly12_vary_CN{q}; %Enter the specific condition
   %R_comb_temp=[]; R_comb_temp=R_comb_group; %R_comb_group for all cases
    T_1to2=[]; T_2to3=[]; T_3toC=[]; T_C=[];
    clear i; 
    for i=1:4
        T_1to2(i,1)=size(find(R_comb_temp(:,1)==i),1);
        T_2to3(i,1)=size(find(R_comb_temp(:,2)==i),1);
        T_3toC(i,1)=size(find(R_comb_temp(:,3)==i),1);
        T_C(i,1)=size(find(R_comb_temp(:,4)==i),1);
    end
    T_1to2=T_1to2./size(R_comb_temp,1); %Normalization
    T_2to3=T_2to3./size(R_comb_temp,1); %Normalization
    T_3toC=T_3toC./size(R_comb_temp,1); %Normalization
    T_C=T_C./size(R_comb_temp,1); %Normalization
    
    S_T1(q,1)=-sum(sum(T_1to2.*log(T_1to2+1e-18)));
    S_T2(q,1)=-sum(sum(T_2to3.*log(T_2to3+1e-18)));
    S_T3(q,1)=-sum(sum(T_3toC.*log(T_3toC+1e-18)));
    S_C(q,1)=-sum(sum(T_C.*log(T_C+1e-18)));
    S_net(q,1)=sum(S_T1(q,1)+S_T2(q,1)+S_T3(q,1)+S_C(q,1)); S_mean(q,1)=S_net(q,1)/4;
end
S_combined=[S_T1'; S_T2'; S_T3'; S_C'; S_net'; S_mean']; S_combined=S_combined';

figure(2)
subplot(4,1,1)
bar(S_T1); title('State Entropies T1')
ylim([0 3]);
subplot(4,1,2)
bar(S_T2); title('State Entropies T2')
ylim([0 3]);
subplot(4,1,3)
bar(S_T3); title('State Entropies T3')
ylim([0 3]);
subplot(4,1,4)
bar(S_C); title('State Entropies T')
ylim([0 3]);

%% Conditional Transition Entropy [Tijk: 'k' is given]: Calculate Cond Transition Entropy [NEW VERSION]:
% Enter the specific condition you want to calculate entropy for:
% R_comb_temp=<pertinent condition>. Also commented below
% To calculate for all cases use: for q=1:1 & R_comb_temp=R_comb_group;
clear q; S_cond_combined=[]; S_itojto1=[]; S_itojto2=[]; S_itojto3=[]; S_itojto4=[];
%for q=1:1
for q=1:max(size(cond_c_Ly12_vary_CN))
    clear i; clear j; clear k; m=0; T_itojto1=[]; T_itojto2=[]; T_itojto3=[]; T_itojto4=[];
    R_comb_temp=[]; R_comb_temp=cond_c_Ly12_vary_CN{q}; %Enter the specific condition
   %R_comb_temp=[]; R_comb_temp=R_comb_group; %R_comb_group for all cases
    for i=1:4
        for j=1:4
            m=m+1;
            T_itojto1(m,1)=(size(find((R_comb_temp(:,1)==i & R_comb_temp(:,2)==j & R_comb_temp(:,3)==1)),1))./(1e-18+size(find((R_comb_temp(:,3)==1)),1));
            T_itojto2(m,1)=(size(find((R_comb_temp(:,1)==i & R_comb_temp(:,2)==j & R_comb_temp(:,3)==2)),1))./(1e-18+size(find((R_comb_temp(:,3)==2)),1));
            T_itojto3(m,1)=(size(find((R_comb_temp(:,1)==i & R_comb_temp(:,2)==j & R_comb_temp(:,3)==3)),1))./(1e-18+size(find((R_comb_temp(:,3)==3)),1));
            T_itojto4(m,1)=(size(find((R_comb_temp(:,1)==i & R_comb_temp(:,2)==j & R_comb_temp(:,3)==4)),1))./(1e-18+size(find((R_comb_temp(:,3)==4)),1));
        end
    end
    S_itojto1(q,1)=-sum(sum(T_itojto1.*log(T_itojto1+1e-18)));
    S_itojto2(q,1)=-sum(sum(T_itojto2.*log(T_itojto2+1e-18)));
    S_itojto3(q,1)=-sum(sum(T_itojto3.*log(T_itojto3+1e-18)));
    S_itojto4(q,1)=-sum(sum(T_itojto4.*log(T_itojto4+1e-18)));
end
S_cond_combined=[S_itojto1'; S_itojto2'; S_itojto3'; S_itojto4']; S_cond_combined=S_cond_combined';

figure(3)
subplot(4,1,1)
bar(S_itojto1); title('Cond. Transition Entropy given SGx at T3=SG1')
ylim([0 3]);
subplot(4,1,2)
bar(S_itojto2); title('Cond. Transition Entropy given SGx at T3=SG2')
ylim([0 3]);
subplot(4,1,3)
bar(S_itojto3); title('Cond. Transition Entropy given SGx at T3=SG3')
ylim([0 3]);
subplot(4,1,4)
bar(S_itojto4); title('Cond. Transition Entropy given SGx at T3=SG4')
ylim([0 3]);

%% Extract conditional transition probabilities: T(i,j,k) for a given biological module:
% Given T(i,j) what is probability distribution of transitioning to k=1,2,3,4
% Enter the specific condition you want to calculate transition probabilities for:
% R_comb_temp=<pertinent condition>. Also commented below
% To calculate for all cases use: for q=1:1 & R_comb_temp=R_comb_group;
clear q; T_cond_combined=[];
%for q=1:1
for q=1:max(size(cond_c_Ly12_vary_CN))
    clear i; clear j; clear k; m=0; T_1to2to3=cell(16,1);
    R_comb_temp=[]; R_comb_temp=cond_c_Ly12_vary_CN{q}; %Enter the specific condition
   %R_comb_temp=[]; R_comb_temp=R_comb_group; %R_comb_group for all cases
    T_1to2=[]; T_2to3=[]; T_3toC=[]; T_cond_total=[];
    for i=1:4
        for j=1:4
            m=m+1;
            T_1to2(i,j)=(size(find((R_comb_temp(:,1)==i & R_comb_temp(:,2)==j)),1));
            T_2to3(i,j)=(size(find((R_comb_temp(:,2)==i & R_comb_temp(:,3)==j)),1));
            T_3toC(i,j)=(size(find((R_comb_temp(:,3)==i & R_comb_temp(:,4)==j)),1));
            for k=1:4
                T_1to2to3{m,1}(k,1)=(size(find((R_comb_temp(:,1)==i & R_comb_temp(:,2)==j & R_comb_temp(:,3)==k)),1))./(1e-18+size(find((R_comb_temp(:,1)==i & R_comb_temp(:,2)==j)),1));
            end
            T_cond_total=[T_cond_total; T_1to2to3{m,1}];
        end
    end
    T_cond_combined=[T_cond_combined,T_cond_total];
end



