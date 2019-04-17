
function xval=comparisonTests(features,labels,subs,p,fs)

%--------------------------------------------------------------------------
 % comparisonTests

 % Last updated: April 2019, J. LaRocco

 % Details: A program that takes and randomly reorders feature data from several subjects. Testing is still performed on a subject it has not seen before.  
 % Usage:
 % xval=comparisonTests(features,labels,subs,p,fs);

 % Input: 
 %  subs: Number of subjects.  
 %  features: cell-based struct of features. 
 %  labels: cell-based struct of targets. 
 %  p: positive integer number of features.
 %  fs: positive integer sampling frequency. 
 
 % Output: 
 %  xval: a struct containing the performance results. 

%--------------------------------------------------------------------------

xval=[];
xval.p=p;
xval.fs=fs;
xval.subs=subs;


% System configurations
[mean_measures,mean_phi,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa]=lda_pca_mval(subs,features,labels,p);

xval.lda.pca.mean.acc=mean_accuracy; 
xval.lda.pca.mean.sens=mean_sensitivity; 
xval.lda.pca.mean.ppv=mean_ppv; 
xval.lda.pca.mean.phi=mean_phi;  
xval.lda.pca.mean.spec=mean_specificity; 
xval.lda.pca.mean.f1=mean_f1;  
xval.lda.pca.mean.kappa=mean_kappa; 


[mean_measures,mean_phi,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa]=lda_aden_mval(subs,features,labels,p);

xval.lda.aden.mean.acc=mean_accuracy; 
xval.lda.aden.mean.sens=mean_sensitivity; 
xval.lda.aden.mean.ppv=mean_ppv; 
xval.lda.aden.mean.phi=mean_phi;  
xval.lda.aden.mean.spec=mean_specificity; 
xval.lda.aden.mean.f1=mean_f1;  
xval.lda.aden.mean.kappa=mean_kappa; 


[mean_measures,mean_phi,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa]=lda_adenz_mval(subs,features,labels,p);

xval.lda.adenz.mean.acc=mean_accuracy; 
xval.lda.adenz.mean.sens=mean_sensitivity; 
xval.lda.adenz.mean.ppv=mean_ppv; 
xval.lda.adenz.mean.phi=mean_phi;  
xval.lda.adenz.mean.spec=mean_specificity; 
xval.lda.adenz.mean.f1=mean_f1;  
xval.lda.adenz.mean.kappa=mean_kappa; 


[mean_measures,mean_phi,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa]=lda_gaden_mval(subs,features,labels,p,p,2,2);

xval.lda.gaden.mean.acc=mean_accuracy; 
xval.lda.gaden.mean.sens=mean_sensitivity; 
xval.lda.gaden.mean.ppv=mean_ppv; 
xval.lda.gaden.mean.phi=mean_phi;  
xval.lda.gaden.mean.spec=mean_specificity; 
xval.lda.gaden.mean.f1=mean_f1;  
xval.lda.gaden.mean.kappa=mean_kappa; 



[mean_measures,mean_phi,mean_aucroc,mean_accuracy,mean_sensitivity,mean_specificity,mean_acc2,mean_ppv,mean_npv,mean_f1,mean_kappa]=lda_gadenz_mval(subs,features,labels,p,p,2,2);

xval.lda.gadenz.mean.acc=mean_accuracy; 
xval.lda.gadenz.mean.sens=mean_sensitivity; 
xval.lda.gadenz.mean.ppv=mean_ppv; 
xval.lda.gadenz.mean.phi=mean_phi;  
xval.lda.gadenz.mean.spec=mean_specificity; 
xval.lda.gadenz.mean.f1=mean_f1;  
xval.lda.gadenz.mean.kappa=mean_kappa; 



end

