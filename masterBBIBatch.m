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

classRatioValues=[.05:.05:1];
failChanceValues=[0:.05:1];


classRatio=.25;
latency=.5;
timeOut=1;
failChance=0.05;

for i=1:length(failChanceValues)
res=initializeParams(refNo,latency,failChanceValues(i),timeOut,fs,subs,classRatio,featureVector);

%% run tests
res=automateTest(res,featuresL,featuresR,sortedLabelL,sortedLabelR);

%% save results

filename=['simulated.bbi.subject.' num2str(refNo) '.classRatio.' num2str(classRatio*100) '.failChance.' num2str(failChance*100) '.mat'];
save(filename,'res');

res=[];

end

%% plot results

% 
% figure();
% bar(res.itr)
% title('Performance on Simulated BBI ITR (bits/sample)')
% ylabel('Performance')
% xlabel('Method')


%xlabel('PCA','ADEN','ADENZ','ADENZ','GADEN','GADENZ');
