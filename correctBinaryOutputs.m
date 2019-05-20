function [phi,roc,auc_roc,accuracy,sensitivity,specificity,acc2,ppv,npv,f1,kappa,itr]=correctBinaryOutputs(C,testing_label)

%--------------------------------------------------------------------------
% correctBinaryOutputs

% Last updated: July 2016, J. LaRocco

% Details: Calculates performance metrics from two binary vectors.

% Usage:
% [phi,roc,auc_roc,accuracy,sensitivity,specificity,acc2,ppv,npv,f1,kappa]=correctOutputs(tp,tn,fp,fn)

% Input:
%  C: Vector of classifier outputs (0 or 1).  
%  testing_label: Vector of 'correct' answers (0 or 1).  
%  tp: True positives (positive number)
%  tn: True negatives (positive number)
%  fp: False positives (positive number)
%  fn: False negatives (positive number)

% Output:
%  phi: phi correlation
%  roc: roc coefficients
%  itr: information transfer rate
%  auc_roc: product of roc coefficients
%  accuracy: accuracy 
%  sensitivity: sensitivity 
%  specificity: specificity
%  acc2: accuracy
%  ppv: positive predictive value
%  npv: negative predictive value
%  f1: f1 measure with 2 as beta
%  kappa: Cohen's kappa
 

%--------------------------------------------------------------------------
tp=length(find(C(testing_label==1)==1));
tn=length(find(C(testing_label==0)==0));

fp=length(find(C(testing_label==0)==1));
fn=length(find(C(testing_label==1)==0));
%should equal 'instances' value
check_sum=tp+tn+fn+fp;

%basic metrics

%accuracy
accuracy=(tp+tn)/check_sum;
acc2=accuracy;

%sensitivity (or recall)

sensitivity=tp/(tp+fn);

%specificity
specificity=tn/(tn+fp);

%PPV/precision

ppv=tp/(tp+fp);

%NPV
npv=tn/(tn+fn);

%ROC
tpr=sensitivity; %y axis
fpr=1-specificity; %x axis
roc=[fpr,tpr];

auc_roc=roc(1)*roc(2);
roc=mean(roc);
%phi
n_1dot=tp+fp;
n_0dot=tn+fn;

n_dot1=tp+fn;
n_dot0=fp+tn;

phi_num=(tp*tn)-(fp*fn);
phi_denom=sqrt(n_1dot*n_0dot*n_dot1*n_dot0);

phi=phi_num/phi_denom;

%cleanup

phi=prototype_cleanup(phi);
roc=prototype_cleanup(roc);
auc_roc=prototype_cleanup(auc_roc);
accuracy=prototype_cleanup(accuracy);
sensitivity=prototype_cleanup(sensitivity);
specificity=prototype_cleanup(specificity);
ppv=prototype_cleanup(ppv);
npv=prototype_cleanup(npv);

precision2=ppv;
recall2=sensitivity;
beta1 = 2;
f1 = prototype_cleanup((1 + beta1^2).*(precision2.*recall2)./((beta1^2.*precision2) + recall2));
pre=((tp+fn)/check_sum)*((tp+fp)/check_sum)+(1-((tp+fn)/check_sum))*(1-((tp+fp)/check_sum));
kappa=(((tn+tp)/check_sum)-pre)/(1-pre);

% 2 class ITR
N=2;
itr1=log2(N);
itr2=(accuracy*log2(accuracy));
itr3=((1-accuracy)*log2((1-accuracy)/(N-1)));
%itr=log2(N)+(accuracy*log2(accuracy))-((1-accuracy)*log2((1-accuracy)/(N-1)));
itr=prototype_cleanup(itr1)+prototype_cleanup(itr2)-prototype_cleanup(itr3);
kappa=prototype_cleanup(kappa);
%itr=prototype_cleanup(itr);
end