
function scores=itrSim(accuracy,N,winSampleLength,winOverlap,latency,failChance,timeOut,vectorLength)

%--------------------------------------------------------------------------
 % itrSim

 % Last updated: April 2019, J. LaRocco

 % Details: A program that simulates ITR based on input parameters. 
 % Usage:
 % scores=itrSim(accuracy,N,winSampleLength,winOverlap,latency,failChance,timeOut,vectorLength);

 % Input: 
 %  accuracy: Accuracy of classifier (as %).  
 %  N: Number of classes (Real positive integer). 
 %  winSampleLength: Length of sample window (in seconds, positive number).
 %  winOverlap: Update rate for window (in seconds, positive number).
 %  latency: Innate delay of system (in seconds, positive number). 
 %  failChance: Chance for initial stimulation to fail (as %).
 %  timeOut: Time threshold for attempting to stop retrying (as seconds).
 %  vectorLength: Number of trials to simulate (real positive integer). 
 
 % Output: 
 %  scores: a struct containing the performance results. 

%--------------------------------------------------------------------------

scores=[];


%% calculate ITR
itr1=log2(N);
itr2=(accuracy*log2(accuracy));
itr3=((1-accuracy)*log2((1-accuracy)/(N-1)));
itr=prototype_cleanup(itr1)+prototype_cleanup(itr2)-prototype_cleanup(itr3);
scores.itr=itr;

%% calculate time per trial
scores.baseTrialsPerWindow=winSampleLength/winOverlap;
scores.baseTrialsPerMin=60*scores.baseTrialsPerWindow;
scores.itrTrialBase=itr*scores.baseTrialsPerWindow;
scores.itrMinBase=itr*scores.baseTrialsPerMin;

%% calculate delay
[delay]=calculateDelay(latency,failChance,timeOut,vectorLength);
scores.delay=mean(delay); 
scores.delayVar=std(delay); 

%% calculate post-delay trials for ITR
scores.timePerTrial=scores.delay;
scores.trialsPerWindow=winSampleLength/scores.timePerTrial;
scores.trialsPerMin=scores.trialsPerWindow*60;

%% ITR post delays        
scores.itrWindow=itr*scores.trialsPerWindow;
scores.itrMin=itr*scores.trialsPerMin;

end
