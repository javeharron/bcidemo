function res=initializeParams(refNo,latency,failChance,timeOut,fs,subs,classRatio,featureVector)

%--------------------------------------------------------------------------
 % initializeParams.m

 % Last updated: May 2019, John LaRocco
 
 % Jeju National University-Biomedical Ultrasound Lab
 
 % Details: Automate testing for simulated BBI. 
 
 % Input Variables: 
 % refNo: Reference number for case. 
 % latency: total length of stimulation process and system (positive number in seconds)
 % failureChance: percent of stimulation process failure (from 0 to 1)
 % timeOut: threshold (integer in seconds) to cancel a retry 
 % fs: Sampling frequency
 % subs: Number of blocks for leave-one-out cross-validation (LOOCV)
 % classRatio: Ratio to cut down one class to. Setting classRatio=1 uses all data.
 % featureVector: 4 element vector (in ascending order) of number of features to select.
 
 % Output Variables: 
 % res: A struct containing key initialized experimental parameters. 

%--------------------------------------------------------------------------


res=[];
res.subs=subs;
res.refNo=refNo;
res.fs=fs;
res.classRatio=classRatio;
delayParams=[];
delayParams.latency=latency;
delayParams.timeOut=timeOut;
delayParams.failChance=failChance;
res.delayParams=delayParams;
featureVector=sort(featureVector,'ascend');
res.featuresA=featureVector(1);
res.featuresB=featureVector(2);
res.featuresC=featureVector(3);
res.featuresD=featureVector(4);




end