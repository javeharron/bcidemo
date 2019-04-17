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
load minhCent.mat;

[featuresC,sortedLabelC]=processMuseMat(IXDATA,fs,refNo);


load minhOrig.mat;

[featuresO,sortedLabelO]=processMuseMat(IXDATA,fs,refNo);

load minhLeft.mat;

[featuresL,sortedLabelL]=processMuseMat(IXDATA,fs,refNo);

load minhRight.mat;

[featuresR,sortedLabelR]=processMuseMat(IXDATA,fs,refNo);


%% left vs right
features=[];
features{1}=featuresL;
features{2}=featuresR;

labels=[];
labels{1}=0*sortedLabelL;
labels{2}=sortedLabelR;


[totalF,totalL]=dataMixer(features,labels,[1:1:subs],subs);

xval01=comparisonTests(totalF,totalL,subs,1,fs);
xval05=comparisonTests(totalF,totalL,subs,5,fs);
xval10=comparisonTests(totalF,totalL,subs,10,fs);
xval20=comparisonTests(totalF,totalL,subs,20,fs);
res=[];
res.a=xval01;
res.b=xval05;
res.c=xval10;
res.d=xval20;
save('resLR.mat','res');

%% left vs original nose (o)
features=[];
features{1}=featuresL;
features{2}=featuresO;

labels=[];
labels{1}=0*sortedLabelL;
labels{2}=sortedLabelO;

[totalF,totalL]=dataMixer(features,labels,[1:1:subs],subs);

xval01=comparisonTests(totalF,totalL,subs,1,fs);
xval05=comparisonTests(totalF,totalL,subs,5,fs);
xval10=comparisonTests(totalF,totalL,subs,10,fs);
xval20=comparisonTests(totalF,totalL,subs,20,fs);
res=[];
res.a=xval01;
res.b=xval05;
res.c=xval10;
res.d=xval20;
save('resLO.mat','res');
%% l vs center
features=[];
features{1}=featuresL;
features{2}=featuresC;

labels=[];
labels{1}=0*sortedLabelL;
labels{2}=sortedLabelC;

[totalF,totalL]=dataMixer(features,labels,[1:1:subs],subs);

xval01=comparisonTests(totalF,totalL,subs,1,fs);
xval05=comparisonTests(totalF,totalL,subs,5,fs);
xval10=comparisonTests(totalF,totalL,subs,10,fs);
xval20=comparisonTests(totalF,totalL,subs,20,fs);

res=[];
res.a=xval01;
res.b=xval05;
res.c=xval10;
res.d=xval20;
save('resLC.mat','res');
%% R vs center
features=[];
features{1}=featuresR;
features{2}=featuresC;

labels=[];
labels{1}=0*sortedLabelR;
labels{2}=sortedLabelC;

[totalF,totalL]=dataMixer(features,labels,[1:1:subs],subs);

xval01=comparisonTests(totalF,totalL,subs,1,fs);
xval05=comparisonTests(totalF,totalL,subs,5,fs);
xval10=comparisonTests(totalF,totalL,subs,10,fs);
xval20=comparisonTests(totalF,totalL,subs,20,fs);
res=[];
res.a=xval01;
res.b=xval05;
res.c=xval10;
res.d=xval20;
save('resRC.mat','res');
%% R vs original noise (o)
features=[];
features{1}=featuresR;
features{2}=featuresO;

labels=[];
labels{1}=0*sortedLabelR;
labels{2}=sortedLabelO;

[totalF,totalL]=dataMixer(features,labels,[1:1:subs],subs);

xval01=comparisonTests(totalF,totalL,subs,1,fs);
xval05=comparisonTests(totalF,totalL,subs,5,fs);
xval10=comparisonTests(totalF,totalL,subs,10,fs);
xval20=comparisonTests(totalF,totalL,subs,20,fs);
res=[];
res.a=xval01;
res.b=xval05;
res.c=xval10;
res.d=xval20;
save('resRO.mat','res');

%% Center vs original noise (o)
features=[];
features{1}=featuresC;
features{2}=featuresO;

labels=[];
labels{1}=0*sortedLabelC;
labels{2}=sortedLabelO;

[totalF,totalL]=dataMixer(features,labels,[1:1:subs],subs);

xval01=comparisonTests(totalF,totalL,subs,1,fs);
xval05=comparisonTests(totalF,totalL,subs,5,fs);
xval10=comparisonTests(totalF,totalL,subs,10,fs);
xval20=comparisonTests(totalF,totalL,subs,20,fs);
res=[];
res.a=xval01;
res.b=xval05;
res.c=xval10;
res.d=xval20;

save('resOC.mat','res');

%% load and compare results
% l vs c
load('resLC.mat','res');
[mscores,macc,mf1,mphi]=readResults(res);
xLC=mean(mphi);

% l vs o
load('resLO.mat','res');
[mscores,macc,mf1,mphi]=readResults(res);
xLO=mean(mphi);

% r vs c
load('resRC.mat','res');
[mscores,macc,mf1,mphi]=readResults(res);
xRC=mean(mphi);


% r vs o
load('resRO.mat','res');
[mscores,macc,mf1,mphi]=readResults(res);

xRO=mean(mphi);

% o vs c
load('resOC.mat','res');
[mscores,macc,mf1,mphi]=readResults(res);
xOC=mean(mphi);


% l vs r
load('resLR.mat','res');
[mscores,macc,mf1,mphi]=readResults(res);
xLR=mean(mphi);


%% plot results

figure();
bar(xLR)
title('Feature Selection Performance on 2-Class Motor Imagery BCI')
ylabel('Performance')
xlabel('Method')
%xlabel('PCA','ADEN','ADENZ','ADENZ','GADEN','GADENZ');
