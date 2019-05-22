function [delay]=calculateDelay(latency,failChance,timeOut,vectorLength)

%--------------------------------------------------------------------------
 % calculateDelay.m

 % Last updated: May 2019, John LaRocco
 
 % Jeju National University-Biomedical Ultrasound Lab
 
 % Details: Calculate delay (per trial) for a combination of factors. 
 
 % Input Variables: 
 % latency: total length of stimulation process and system (positive number in seconds)
 % failureChance: percent of stimulation process failure (from 0 to 1)
 % timeOut: threshold (integer in seconds) to cancel a retry 
 % vectorLength: total length of vector to generate
 
 % Output Variables: 
 % delay: final delay per trial value in seconds/trial
 
%--------------------------------------------------------------------------

%% set base matrix
baseValues=latency*ones(1,vectorLength);


%% calculate stimulation failure
restimTime=zeros(1,vectorLength);
rollDice=randperm(vectorLength);

failIndex=ceil(failChance*vectorLength);

failKey=rollDice(1:failIndex);
restimTime(failKey)=1;

%% extra stimulation
failTwiceIndex=ceil(failChance*failChance*vectorLength);
if failTwiceIndex > 1;
    endPoints=min([(failIndex+failTwiceIndex),(length(rollDice)-1)]);
    startPoints=(failIndex+1);
    
failKey2=rollDice(startPoints:endPoints);
restimTime(failKey2)=2;

end


%% combine both
addedTime=latency*restimTime;
delay=baseValues+addedTime;

%% factor in timeouts
if (max(delay) > timeOut)
overMax=find(delay>=timeOut);
delay(overMax)=timeOut;
end




end