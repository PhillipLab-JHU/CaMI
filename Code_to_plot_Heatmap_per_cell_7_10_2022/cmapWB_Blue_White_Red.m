function out=cmapWB_Blue_White_Red(N)
% Original:
% colmap.

%c1=[1 0 0];
c1=[0 0 1];
%cm=[1 1 1];
%cm=[0.5 0.5 0.5];
cm=[1 1 1];
%c2=[0 0.65 0];
c2=[1 0 0];

out=zeros(N,3);
N1=round((N)/2);
N2=N-N1;
%colormap(cmapWB(100))
for k=1:3
   cc01=linspace(c1(k),cm(k),N1);
   cc02=linspace(cm(k),c2(k),N2);    
   out(:,k)=[cc01(:);cc02(:)];    
end