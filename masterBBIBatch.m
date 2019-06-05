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

featureVector=[1,5,10,20];

classRatioValues=[.05:.05:1];
failChanceValues=[0:.05:1];

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
        save('lastSolutions1.mat','solutionSpace');
        save('lastSolutionsRaw1.mat','solutionSpaceRaw');
        res=[];
            end
        end
    end
end
%% plot results
% plot class (50/50), failchance=0
solutionSpace=solutionSpace/600;
figure;
% plot class (50/50), failchance=0
evenITR0=squeeze(solutionSpace(5,1,:,:));
surf(timeOutValues,timeOutValues,evenITR0); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');


% plot class (95/5), failchance=0
figure;
evenITR1=squeeze(solutionSpace(1,1,:,:));
surf(timeOutValues,timeOutValues,evenITR1); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');

[h,p,ci,stats]=ttest2(evenITR0(:),evenITR1(:));

% plot class (90/10), failchance=0
figure;
evenITR1=squeeze(solutionSpace(2,1,:,:));
surf(timeOutValues,timeOutValues,evenITR1); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');

% plot class (75/25), failchance=0
figure;
evenITR1=squeeze(solutionSpace(3,1,:,:));
surf(timeOutValues,timeOutValues,evenITR1); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');

% plot class (66/33), failchance=0
figure;
evenITR1=squeeze(solutionSpace(4,1,:,:));
surf(timeOutValues,timeOutValues,evenITR1); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');

%% hypothesis 1 post hoc
%[h,p,ci,stats]=ttest2(evenITR0(:),evenITR1(:));


%% part 2
%% plot results

figure;
% plot class (50/50), failchance=0
evenITR0=squeeze(solutionSpace(5,1,:,:));
surf(timeOutValues,timeOutValues,evenITR0); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');

figure;
% plot class (50/50), failchance=0.05
evenITR1=squeeze(solutionSpace(5,2,:,:));
surf(timeOutValues,timeOutValues,evenITR1); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');

figure;
% plot class (50/50), failchance=0.1
evenITR2=squeeze(solutionSpace(5,3,:,:));
surf(timeOutValues,timeOutValues,evenITR2); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');

figure;
% plot class (50/50), failchance=0.25
evenITR3=squeeze(solutionSpace(5,4,:,:));
surf(timeOutValues,timeOutValues,evenITR3); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');

% plot class (50/50), failchance=0.50
figure;
evenITR4=squeeze(solutionSpace(5,5,:,:));
surf(timeOutValues,timeOutValues,evenITR4); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');

% plot class (50/50), failchance=0.75
figure;
evenITR5=squeeze(solutionSpace(5,6,:,:));
surf(timeOutValues,timeOutValues,evenITR5); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');


% plot class (50/50), failchance=1.0
figure;
evenITR6=squeeze(solutionSpace(5,7,:,:));
surf(timeOutValues,timeOutValues,evenITR6); 
zlabel('ITR (bits/min)')
ylabel('Timeout Threshold (s)');
xlabel('Latency (s)');

%% hyp 2 post hoc
%[h,p,ci,stats]=ttest2(evenITR0(:),evenITR4(:));


%% part 3
% class ratio, fail chance, latency, timeout
figure;
% plot class (50/50), timeout=.1
failLatITR0=squeeze(solutionSpace(5,:,1,:));
surf(timeOutValues,failChanceValues,failLatITR0); 
zlabel('ITR (bits/min)')
ylabel('Fail Chance (%)');
xlabel('Timeout Threshold (s)');

figure;
% plot class (50/50), timeout=1
failLatITR1=squeeze(solutionSpace(5,:,10,:));
surf(timeOutValues,failChanceValues,failLatITR1); 
zlabel('ITR (bits/min)')
ylabel('Fail Chance (%)');
xlabel('Timeout Threshold (s)');

%% hypothesis 3 post hoc
%[h,p,ci,stats]=ttest2(failLatITR0(:),failLatITR1(:));
