function [xys]=get_trajfile(xlsfile)
% select for the trajectory file
% 
% developed  by-
%  Pei-Hsun Wu, Ph.D. 
%    @ Johns Hopkins University

% check trajectories data

%% step 1
% load trajectories data; 

if nargin==0 %Meaning no input file is given
    %uigetfile prompts opening a dialog box to extract .xls file
    [filename, pathname] = uigetfile( ...
    {'*.xlsx;*.xls;*.mat','trajectory Files (*.xlsx,*.xls,*.mat,)';
       '*.xlsx',  'excel files (*.xlsx)'; ...
       '*.xls','excel file (*.xls)'; ...
       '*.mat','MAT-files (*.mat)'; ...  
       '*.*',  'All Files (*.*)'}, ...
       'select cell trajectory file');
     xlsfile=[pathname,filename]; %Auto-concatenation 
end
[num,~,~]=xlsread(xlsfile); %Same as [num]=xlsread(xlsfile)

%num contains all datasets as the excel file

%  check trajectories. 
ui=unique(num(:,1)); %Number of cells
tlength=zeros(size(ui));%Zeros with No. of cells
xys=cell(size(ui)); %Empty Matrix containing individual cell data
 for k = 1:length(ui); %1 to Number of cells
    col=num(:,1)==ui(k);
    tlength(k)=sum(col); % length of trajectories
    xytemp=num(col,1:end);
    % sort for time
    [~,sid]=sort(xytemp(:,2),'ascend'); % ensure the time elapse in right order
    xytemp=xytemp(sid,3:end); % only obtain the trajectory locations.
    xys{k}=xytemp ;   % trajectories of cells.  
 end
 
 
