
function [out_features,out_labels]=dataMixer(features,labels,train_sub,newsubs)

%--------------------------------------------------------------------------
 % dataMixer

 % Last updated: April 2019, J. LaRocco

 % Details: A program that takes and randomly reorders feature data from several subjects. Testing is still performed on a subject it has not seen before.  
 % Usage:
 % [out_features,out_labels]=dataMixer(features,labels,train_sub,subs);

 % Input: 
 %  subs: Number of subjects.  
 %  features: cell-based struct of features. 
 %  labels: cell-based struct of targets. 
 %  train_sub: vector of training subjects. 
 %  newsubs: number of "subjects" to recombine to. For same number as
 %  subjects, use subs=length(train_sub);
 
 % Output: 
 %  out_features: cell-based struct of reordered features. 
 %  out_labels: cell-based struct of reordered targets. 
%--------------------------------------------------------------------------

subs=length(train_sub);


newfeatures=[];
newlabels=[];

tlength=[];
feat=[];
labe=[];


for u=1:subs;
    [x,y]=size(features{train_sub(u)});
    tlength=[tlength y];
    x=features{train_sub(u)}; 
    feat=[feat x];
    t=labels{train_sub(u)};
    labe=[labe t];
    
end

newlength=floor(sum(tlength)/newsubs);
if newlength ==0;
newlength=1;
end
obs=newlength;

for i=1:newsubs;    
lobound=obs*(i-1)+1;
hibound=obs*i;
    [x,y]=size(feat);
    p=randperm(y);
    newfeatures=feat(:,p);
    newlabels=labe(1,p);
    x1=newfeatures(:,lobound:hibound);
    y1=newlabels(1,lobound:hibound);
    out_features{i}=x1;
    out_labels{i}=y1;
    
end




end

