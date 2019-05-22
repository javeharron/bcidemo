clear; clc;

%--------------------------------------------------------------------------
 % masterBBIBatch.m

 % Last updated: May 2019, John LaRocco
 
 % Jeju National University-Biomedical Ultrasound Lab
 
 % Details: Load EEG data, process it, and simulate a BBI system with it.

%--------------------------------------------------------------------------

%% load data
%load minhCent.mat;
%[featuresC,sortedLabelC]=processMuseMat(IXDATA,fs,refNo);
%load minhOrig.mat;
%[featuresO,sortedLabelO]=processMuseMat(IXDATA,fs,refNo);
refNo=1;
fs=220;
load minhLeft.mat;
[featuresL,sortedLabelL]=processMuseMat(IXDATA,fs,refNo);
load minhRight.mat;
[featuresR,sortedLabelR]=processMuseMat(IXDATA,fs,refNo);




%% set initial variables


subs=2;
refNo=1;
fs=220;
featureVector=[1,5,10,20];

classRatioValues=[.05 .1 .25 .5 1];
failChanceValues=[0 .05 .1 .25 .5 .75 1];

latencyValues=[.1:.1:1];
timeOutValues=[.1:.1:1.5];
solutionSpace=zeros(length(classRatioValues),length(failChanceValues),length(timeOutValues),length(latencyValues));
solutionSpaceRaw=zeros(length(classRatioValues),length(failChanceValues),length(timeOutValues),length(latencyValues));
classRatio=.25;
latency=.5;
timeOut=1;
failChance=0.05;


for ii=1:length(classRatioValues)
    for i=1:length(failChanceValues)
        for iiii=1:length(timeOutValues)
            for iii=1:length(latencyValues)
        res=initializeParams(refNo,latencyValues(iii),failChanceValues(i),timeOutValues(iiii),fs,subs,classRatioValues(ii),featureVector);

%% run tests
        res=automateTest(res,featuresL,featuresR,sortedLabelL,sortedLabelR);

%% save results
        
        filename=['simulated.bbi.subject.' num2str(refNo) '.classRatio.' num2str(classRatioValues(ii)*100) '.failChance.' num2str(failChanceValues(i)*100) '.latencyMS.' num2str(latencyValues(iii)*1000) '.timeOutMS.' num2str(timeOutValues(iiii)*1000) '.mat'];
        save(filename,'res');
%% fill solution space
        solutionSpace(ii,i,iii,iiii)=res.maxitr;
        solutionSpaceRaw(ii,i,iii,iiii)=res.rawitr;
        save('lastSolutions.mat','solutionSpace');
        save('lastSolutionsRaw.mat','solutionSpaceRaw');
        res=[];
            end
        end
    end
end
%% plot results
% figure;
% surf(solutionSpace); 
% zlabel('ITR (bits/min)')
% xlabel('Class Balance (%)');
% ylabel('Fail Chance (%)');
% 
% figure;
% surf(solutionSpaceRaw); 
% zlabel('ITR (bits/trial)')
% xlabel('Class Balance (%)');
% ylabel('Fail Chance (%)');

% 
% figure();
% bar(res.itr)
% title('Performance on Simulated BBI ITR (bits/sample)')
% ylabel('Performance')
% xlabel('Method')


%xlabel('PCA','ADEN','ADENZ','ADENZ','GADEN','GADENZ');
