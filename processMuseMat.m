function [sortedData,sortedLabel]=processMuseMat(IXDATA,fs,refNo)

%--------------------------------------------------------------------------
 % processMuseMat.m

 % Last updated: April 2019, John LaRocco
 
 % Jeju National University-Biomedical Ultrasound Lab
 
 % Details: Loads data coming directly converted from .muse format to .mat.
 % Performs Welch-based feature extraction, resulting in a feature matrix
 % and vector. 
 
 % Input Variables: 
 % IXDATA: A struct containing the raw EEG. 
 % fs: Sampling frequency. Positive, real integer. 
 % refNo: Reference number to use for label vector. Positive, real integer. 
 
 % Output Variables: 
 % sortedData: Feature matrix. Formatted as MATLAB double. 
 % sortedLabel: Vector full of values based on reference number. Double.
 
% Other resources for muse file conversion:
% CLI Commands: http://developer.choosemuse.com/tools/museplayer/command-line-options
% Default Directory: C:\Program Files (x86)\Muse
% CLI conversion: muse-player.exe -f 'filename.muse' -M taste.mat
% Git Repo: https://github.com/arunrawlani/museplayer

% Muse streaming data on Matlab: https://www.krigolsonlab.com/muse-data-collection.html

% To load MAT in Python: import scipy.io
% mat = scipy.io.loadmat('file.mat')

%--------------------------------------------------------------------------

eeg=IXDATA.raw.eeg.data;
lengthS=size(eeg,1)/fs;
adjustedLength=floor(lengthS*fs);

eegAdjusted=eeg(1:adjustedLength,:);

nonNans=find(isnan(eegAdjusted));
eegAdjusted(nonNans)=0;
%plot(eegAdjusted)
windowSize=fs;
overlap=.1;
%eegAdjusted=eegAdjusted(:.1:4);


%windowSamples=window*fs;
%advanceRate=round(windowSamples*overlap);
%numWindows=floor(tSamples/windowSamples);
window=1;
tLeng=1; 
overlap=.1;

channels=4;


eegAdjusted=eegAdjusted(:,1:channels);
eegAdjusted=eegAdjusted';

tSamples=adjustedLength;
%% window parameters

windowSamples=window*fs;
advanceRate=round(windowSamples*overlap);
numWindows=floor(tSamples/windowSamples);

lbnds=[1:advanceRate:(tSamples-windowSamples)];
ubnds=[windowSamples:advanceRate:tSamples];
capper=min([length(lbnds),length(ubnds)]);
lbnds=lbnds(1:capper);
ubnds=ubnds(1:capper);


features=[];
sortedLabel=refNo*ones(1,capper);

%% feature extraction loop
for up=1:capper;
noi=eegAdjusted(:,lbnds(up):ubnds(up));
%sampleLabel(up)=max(keyFrame(lbnds(up):ubnds(up)));
yold=featuresWelch(noi',fs);
y=unifyChannel(yold);
features(:,up)=y;

end

sortedData=features;



end