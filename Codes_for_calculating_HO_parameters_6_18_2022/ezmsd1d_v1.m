function [out]=ezmsd1d_v1(x)
%******************************************************
% estimate the MSD, from vector x comprising the trajectory.
% 
%*******************************************************
% written by : 
%               Pei-Hsun Wu
%               PhD student
%               Department of Chemical Engineering
%               the University of Florida
% 
% Last update:  Feb 11, 2009
%               
%******************************************************
msdr=[];
msd=[];
fn=length(x); % frame number of analysis. There are 500 frames
to=[]; 
tos=[];

% fid=fopen('msd.dat','a');
for dt= 1 : (fn-1) %Here dt is tau
% route 2 -loop oriented
        summ=0 ;        
        for i = 1 : fn-dt           
           dx = -x(i)+x(i+dt) ; % dx in pixel  %         
           summ=summ + dx*dx; % summation of all the dx in certain delta t.
        end  
            to=[to;summ/(fn-dt)];
        if length(to)==1000  %If size exceeds some number which is not happening here
            tos=[tos,to];
%             %         fid=fopen('msd.dat','a');
%             fprintf(fid,'%12.4f /n', to);
% %         fclose(fid);
            to=[];
        end
          
end
%       fid=fopen('msd.dat','a');
%         fprintf(fid,'%12.4f /n',to);
%         fclose(fid);
%         fid=fopen('msd.dat','r');
%         out=fscanf(fid,'%g',[1,inf]);
%         fclose(fid);
%         delete('msd.dat');
out=[tos(:);to];
% out=out';
%%%%%
% out=msdr;
