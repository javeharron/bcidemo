function [Pxx,power]=featuresRestrictedDictionaryGMP(epochs,fs,bounds)


%--------------------------------------------------------------------------
% FEATURESRESTRICTEDDICTIONARYGMP

% Last updated: March 2016, J. LaRocco

% Details: Feature extraction method, using matching pursuit with Gabor
% atoms and restricted dictionary. Based on code from P. Mineault:
% http://www.mathworks.com/matlabcentral/fileexchange/32426-matching-pursuit-for-1d-signals

% Usage: [y,power]=featuresGMP(segments,fs)

% Input:
%  epochs: Matrix of EEG data.
%  fs: sampling frequency.
%  bounds: A 1 by 2 matrix of lower and upper frequency bounds to restrict dictionary to.
%          Must be positive integers greater than 0 (e.g., [8 18])

% Output:
% Pxx: Pxx is the spectral feature vector.
% power: power is the raw spectrum.

%--------------------------------------------------------------------------
bounds=sort(bounds,'ascend');
lbound=bounds(1);
ubound=bounds(2);
f=lbound:1:ubound;


[samples,chan]=size(epochs);

Pxx=zeros(34,chan);
power=[];

t=((-3*fs):1:(3*fs))';

s=10*ones(1,length(f));
gabors = exp(-pi*(t.^2)*s.^(-2)).*cos(2*pi*t*f./fs);

for i=1:chan;
    
    yith=epochs(:,i);
    [ws,yhat] = temporalMP(prototype_cleanup(yith'),gabors,false,20); clc;
    
    pv=(pwelch(yhat',[],10,[],fs));
    if i==1
        power=zeros(length(pv),chan);
    end
    
    
    
    spec_coefs=pow2db(abs(pv));
    
    [spectral_coefs]=featureSpecOrganizer(spec_coefs);
    
    
    
    Pxx(:,i)=spectral_coefs;
    power(:,i)=spec_coefs;
end



end
