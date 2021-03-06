function res=automateTest(res,featuresL,featuresR,sortedLabelL,sortedLabelR)

%--------------------------------------------------------------------------
 % automateTest.m

 % Last updated: May 2019, John LaRocco
 
 % Jeju National University-Biomedical Ultrasound Lab
 
 % Details: Automate testing for simulated BBI. 
 
 % Input Variables: 
 % res: struct containing the vital parameters.
 % featuresL: Left hand EEG features.
 % featuresR: Right hand EEG features (primary class of interest).
 % sortedLabelL: Left hand label
 % sortedLabelR: Right hand label

 % Output Variables: 
 % res: A struct containing the final test values, including f1, phi, and ITR (bits/min). 
 
%--------------------------------------------------------------------------




%% change class balance
[cutR,newLength]=rebalanceClasses(featuresR,res.classRatio);
cutLabelR=sortedLabelR(1:newLength);
res.newLength=newLength;
res.delayParams.lengthVec=newLength;

%% calculate delays
delays=calculateDelay(res.delayParams.latency,res.delayParams.failChance,res.delayParams.timeOut,newLength);
delay=mean(delays);
res.delay=delay;

%% left vs right
features=[];
features{1}=featuresL;
features{2}=featuresR;

labels=[];
labels{1}=0*sortedLabelL;
labels{2}=sortedLabelR;

subs=res.subs;
fs=res.fs;
[totalF,totalL]=dataMixer(features,labels,[1:1:subs],subs);

%% test without latency

xval01=comparisonTests(totalF,totalL,subs,res.featuresA,fs);
xval05=comparisonTests(totalF,totalL,subs,res.featuresB,fs);
xval10=comparisonTests(totalF,totalL,subs,res.featuresC,fs);
xval20=comparisonTests(totalF,totalL,subs,res.featuresD,fs);

res.control.a=xval01;
res.control.b=xval05;
res.control.c=xval10;
res.control.d=xval20;
%% archive control values for offline processing
[mscores,macc,mf1,mphi,mitr]=readBBIResults(res);
res.control.c.scores=mscores;
res.control.c.accuracy=macc;
res.control.c.f1=mf1;
res.control.c.phi=mphi;
res.control.c.itr=mitr;

%% latency sim
xval01=comparisonTestsTimer(totalF,totalL,subs,res.featuresA,fs,delay);
xval05=comparisonTestsTimer(totalF,totalL,subs,res.featuresB,fs,delay);
xval10=comparisonTestsTimer(totalF,totalL,subs,res.featuresC,fs,delay);
xval20=comparisonTestsTimer(totalF,totalL,subs,res.featuresD,fs,delay);

res.a=xval01;
res.b=xval05;
res.c=xval10;
res.d=xval20;
%save('resLR.mat','res');



% l vs r
%load('resLR.mat','res');
[mscores,macc,mf1,mphi,mitr]=readResults(res);
res.scores=mscores;
res.accuracy=macc;
res.f1=mf1;
res.phi=mphi;
res.itr=mitr;
res.maxitr=max(max(mitr));

%% itr in bits per trial
P=macc(find(mitr==max(max(mitr))));
N=2;
rawitr1=log2(N);
rawitr2=P*log2(P);
rawitr3=(1-P)*log2((1-P)/(N-1));
rawitr=rawitr1+rawitr2+rawitr3;
res.rawitr=rawitr;


end