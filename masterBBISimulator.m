clear; clc;

%--------------------------------------------------------------------------
 % masterBBISimulator.m

 % Last updated: July 2019, John LaRocco
 
 % Jeju National University-Biomedical Ultrasound Lab
 
 % Details: Simulate performance of a BBI system.

%--------------------------------------------------------------------------





%% set initial variables
refNo=11;
classRatioValues=[.05:.05:1];
classValues=[2 5 10 50];
winSampleLengthValues=[1:1:3];
winOverlapValues=[.1:.1:1];
latencyValues=[.1:.1:1];
failChanceValues=[0:.05:1];
timeOutValues=[.1:.1:3];

solutionSpace=zeros(length(classRatioValues),length(classValues),length(winSampleLengthValues),length(winOverlapValues),length(latencyValues),length(failChanceValues),length(timeOutValues));
solutionSpaceRaw=zeros(length(classRatioValues),length(classValues),length(winSampleLengthValues),length(winOverlapValues),length(latencyValues),length(failChanceValues),length(timeOutValues));

classRatio=.25;
latency=.5;
timeOut=1;
failChance=0.05;
winSampleLength=1; 

for ii=1:length(classRatioValues)
for vi=1:length(classValues)
    for vii=1:length(winSampleLengthValues)
for viii=1:length(winOverlapValues)    
    for iii=1:length(latencyValues)
for i=1:length(failChanceValues)    
    for iiii=1:length(timeOutValues)
            
        
%% run tests
        vectorLength=500;
        scores=itrSim(classRatioValues(ii),classValues(vi),winSampleLengthValues(vii),winOverlapValues(viii),latencyValues(iii),failChanceValues(i),timeOutValues(iiii),vectorLength);

        filename=['simulated.bbi.subject.' num2str(refNo) '.accuracyRate.' num2str(classRatioValues(ii)*100) 'classNumber.' num2str(classValues(vi)) '.windowLength.' num2str(winSampleLengthValues(vii)*1000) '.windowOverlap.' num2str(winOverlapValues(viii)*1000) '.latencyMS.' num2str(latencyValues(iii)*1000) '.failChance.' num2str(failChanceValues(i)*100) '.timeOutMS.' num2str(timeOutValues(iiii)*1000) '.mat'];
        save(filename,'scores');

%% fill solution space
        solutionSpace(ii,vi,vii,viii,iii,i,iiii)=scores.itrMin;
        solutionSpaceRaw(ii,vi,vii,viii,iii,i,iiii)=scores.itrMin;
        save('itrSolutions1.mat','solutionSpace');
        save('itrSolutionsRaw1.mat','solutionSpaceRaw');
        res=[];
    end
end
    end
end
    end
end
end

