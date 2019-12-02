
load('itrBbi.mat','bbiVec'); 

latencyValues=[.1:.1:1];
failChanceValues=[0:.25:1];
timeOutValues=[.1:.1:1.5];
%% anova test

last1=bbiVec(:,1);
varNames = {'BBI1','BBI2','BBI3','BBI4'};

t = array2table(bbiVec,'VariableNames',varNames);

factorNames = {'latencyValues','failChanceValues','timeOutValues'};

factorNames2= {'latencyValues','failChanceValues','timeOutValues','BBI1','BBI2','BBI3','BBI4'};
%% make vectors
lateCell=[];
sfnCell=[];
timeCell=[];
% latency
   valueThres=length(last1(:))/length(latencyValues);
for ii=1:valueThres 
lateCell=[lateCell; latencyValues];
    
end
laterCell=lateCell(:);
clear lateCell;
for ii=1:length(laterCell)
lateCell{ii}=mat2cell(laterCell(ii),1);
end
% sfn
   valueThres=length(last1(:))/length(failChanceValues);
for ii=1:valueThres 
sfnCell=[sfnCell; failChanceValues];
    
end
sfnrCell=sfnCell(:);
clear sfnCell;
for ii=1:length(sfnrCell)
sfnCell{ii}=mat2cell(sfnrCell(ii),1);
end

% timeout
   valueThres=length(last1(:))/length(timeOutValues);
for ii=1:valueThres 
timeCell=[timeCell; timeOutValues];
    
end
timerCell=timeCell(:);
clear timeCell;
for ii=1:length(timerCell)
timeCell{ii}=mat2cell(timerCell(ii),1);
end
% final table
within = table(lateCell',sfnCell',timeCell','VariableNames',factorNames);

%% analysis

superT=table(laterCell,sfnrCell,timerCell,bbiVec(:,1),bbiVec(:,2),bbiVec(:,3),bbiVec(:,4),'VariableNames',factorNames2);
rm = fitrm(superT,'BBI1-BBI4 ~ latencyValues + failChanceValues + timeOutValues');
[ranovatbl] = ranova(rm);

