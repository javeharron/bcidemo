clear; clc;

%--------------------------------------------------------------------------
 % masterFile.m

 % Last updated: March 2019, John LaRocco
 
 % Jeju National University-Biomedical Ultrasound Lab
 
 % Details: Load EEG data, process it, and generate features from it. 
 % Following this, iterate through comparisons of 4 datasets, with
 % different numbers of features ([1, 5, 10, 20]). 
 % Datasets include: Orig (original noise EEG), Center (center motor
 % imagery task EEG), left (left hand motor imagery EEG), right (right hand
 % motor imagery EEG). 

%--------------------------------------------------------------------------
%% set initial variables

res=[];
subs=2;
refNo=1;
fs=220;
classRatio=.25;
latency=.5;
timeOut=1;
failChance=0.05;
featureVector=[1,5,10,20];

res=initializeParams(refNo,latency,failChance,timeOut,fs,subs,classRatio,featureVector);

%% load data
%load minhCent.mat;
%[featuresC,sortedLabelC]=processMuseMat(IXDATA,fs,refNo);
%load minhOrig.mat;
%[featuresO,sortedLabelO]=processMuseMat(IXDATA,fs,refNo);

load minhLeft.mat;
[featuresL,sortedLabelL]=processMuseMat(IXDATA,res.fs,res.refNo);
load minhRight.mat;
[featuresR,sortedLabelR]=processMuseMat(IXDATA,res.fs,res.refNo);


%% run tests
res=automateTest(res,featuresL,featuresR,sortedLabelL,sortedLabelR);



%% plot results


figure();
bar(res.itr)
title('Performance on Simulated BBI ITR (bits/sample)')
ylabel('Performance')
xlabel('Method')


%xlabel('PCA','ADEN','ADENZ','ADENZ','GADEN','GADENZ');
