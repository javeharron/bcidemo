function [mean_measures,mean_phi,mean_phiclassic,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa,mean_itr]=lda_gaden_tval(subs,features,labels,pvalue,limits,offspring,generations,delay)

%--------------------------------------------------------------------------
 % LDA_GADEN_TVAL

 % Last updated: April 2014, J. LaRocco

 % Details: Single classifier with GADEN for feature reduction and LDA for pattern recognition. 

 % Usage: [mean_measures,mean_phi,mean_phiclassic,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc_sns,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa,mean_itr]=lda_gaden_tval(subs,features,labels,pvalue,limits,offspring,delay)

 % Input: 
 %  subs: Number of subjects.  
 %  features: cell-based struct of features. 
 %  labels: cell-based struct of targets. 
 %  pvalue: features to reduce to. 
 %  limits: Size of initial subset (highest averaged distances). 
 %  offspring: Number of offspring to investigate. Keep low for speed. 
 %  generations: number of generations (full cycles)
 %  delay: latency period (in seconds) to add per trial
 
 % Output: 
 %  mean_measures: output matrix of all averaged metrics
    % 1st row is mean phi
    % 2st row is mean phi by other means
    % 3rd row is mean accuracy
    % 4th row is mean sensitivity
    % 5th row is mean specificity
    % 6th row is mean accuracy (mean of sensitivity and specificity)
    % 7th row is mean accuracy (calculated in different way than 3rd row, should be the same as value in 3rd row)
    % 8th row is mean ppv
    % 9th row is mean npv
    % 10th row is f1, with beta=2
    % 11th row is Cohen's kappa
    % 12th row is information transfer rate (bits/trial)
%--------------------------------------------------------------------------

mean_measures=[]; 
a=1:subs;
for vv=1:subs
test_sub=vv; 
testing_data=squeeze(features{test_sub});
testing_label=labels{test_sub}'; 
arrays1=a;
arrays1(arrays1==vv) = [];
train_sub=arrays1;
num_subs=length(train_sub);

AA = [];
tic;
for uu=1:num_subs;
      
    
trainingdata=squeeze(features{train_sub(uu)});

traininglabel=labels{train_sub(uu)}';

[training_csp,test_csp,training_mad,test_mad,ga_ind,aden_ind,maden]=feature_selection_gaden(trainingdata',traininglabel,testing_data',limits,pvalue,offspring,generations);

reduced_features=training_csp;
mod_test=test_csp;

dispstr=sprintf('Running validation subject %s through model %s', num2str(vv), num2str(train_sub(uu)));
        disp(dispstr);

traininglabel=traininglabel';
[ypre,clas_err]=stacking_ldam_default_classify(mod_test,reduced_features,traininglabel');

 altout = clas_err*(1/(subs-1));
AA = [AA altout];
clc;
end
timerClass=toc;
AltModelOut = sum(AA,2);
AltModelOutBin = zeros(1,length(AltModelOut));
AltModelOutBin(find(AltModelOut>=0.5)) = 1;
AltModelOutBin(find(AltModelOut<0.4999)) = 0;

[phi,phiclassic,auc_roc,accuracy,sensitivity,specificity,acc2,ppv,npv,f1,kappa,itr]=correctBinaryOutputs(AltModelOutBin,testing_label);
sNum=length(AltModelOutBin);
timerClass=timerClass+(delay*sNum);
sampPerSec=sNum/timerClass;
itr=itr*sampPerSec*60;
mean_measures(:,vv)=[phi,phiclassic,auc_roc,accuracy,sensitivity,specificity,acc2,ppv,npv,f1,kappa,itr];

end
mean_phi=mean(mean_measures(1,:));
mean_phiclassic=mean(mean_measures(2,:));
mean_aucroc=mean(mean_measures(3,:));
mean_accuracy=mean(mean_measures(4,:));
mean_sensitivity=mean(mean_measures(5,:));
mean_specificity=mean(mean_measures(6,:));
mean_acc2=mean(mean_measures(7,:));
mean_ppv=mean(mean_measures(8,:));
mean_npv=mean(mean_measures(9,:));
mean_f1=mean(mean_measures(10,:));
mean_kappa=mean(mean_measures(11,:));
mean_itr=mean(mean_measures(12,:));

end
