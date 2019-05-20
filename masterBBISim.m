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
fs=220;
refNo=1;
subs=2;

%% load data
%load minhCent.mat;
%[featuresC,sortedLabelC]=processMuseMat(IXDATA,fs,refNo);
%load minhOrig.mat;
%[featuresO,sortedLabelO]=processMuseMat(IXDATA,fs,refNo);

load minhLeft.mat;
[featuresL,sortedLabelL]=processMuseMat(IXDATA,fs,refNo);
load minhRight.mat;
[featuresR,sortedLabelR]=processMuseMat(IXDATA,fs,refNo);

%% change class balance

[cutR,newLength]=rebalanceClasses(featuresR,.25);
cutLabelR=sortedLabelR(1:newLength);

%% calculate delays
delayParams=[];
delayParams.latency=.5;
delayParams.timeOut=1;
delayParams.failChance=0.05;
delayParams.lengthVec=size(featuresR,2);

delays=calculateDelay(delayParams.latency,delayParams.failChance,delayParams.timeOut,delayParams.lengthVec);
delay=mean(delays);

%% left vs right
features=[];
features{1}=featuresL;
features{2}=featuresR;

labels=[];
labels{1}=0*sortedLabelL;
labels{2}=sortedLabelR;


[totalF,totalL]=dataMixer(features,labels,[1:1:subs],subs);

%% test without latency

xval01=comparisonTests(totalF,totalL,subs,1,fs);
xval05=comparisonTests(totalF,totalL,subs,5,fs);
xval10=comparisonTests(totalF,totalL,subs,10,fs);
xval20=comparisonTests(totalF,totalL,subs,20,fs);
res=[];
res.a=xval01;
res.b=xval05;
res.c=xval10;
res.d=xval20;

%% latency sim
xval01=comparisonTestsTimer(totalF,totalL,subs,1,fs,delay);
xval05=comparisonTestsTimer(totalF,totalL,subs,5,fs,delay);
xval10=comparisonTestsTimer(totalF,totalL,subs,10,fs,delay);
xval20=comparisonTestsTimer(totalF,totalL,subs,20,fs,delay);
res=[];
res.delayParams=delayParams;
res.a=xval01;
res.b=xval05;
res.c=xval10;
res.d=xval20;
%save('resLR.mat','res');



% l vs r
%load('resLR.mat','res');
[mscores,macc,mf1,mphi,mitr]=readResults(res);
%[mscores,macc,mf1,mphi,mitr]=readBBIResults(res);
%xLR=mean(mphi);


%% plot results
% 
% figure();
% bar(mphi)
% title('Feature Selection Performance on 2-Class Motor Imagery BCI')
% ylabel('Performance')
% xlabel('Method')

figure();
bar(mitr)
title('Feature Selection Performance on BCI ITR (bits/sample)')
ylabel('Performance')
xlabel('Method')


%xlabel('PCA','ADEN','ADENZ','ADENZ','GADEN','GADENZ');
