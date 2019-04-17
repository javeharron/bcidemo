function [scores,acc,f1,phi]=unwrapStruct(xval)

%--------------------------------------------------------------------------
 % readResults

 % Last updated: April 2019, J. LaRocco

 % Details: A program that unwraps results from structs and puts them in matrices.   
 % Usage:
 % [scores,acc,f1,phi]=unwrapStruct(res);

 % Input: 
 %  xval: A struct of results, with subsets of 1, 5, 10, and 20 features.   
 
 % Output: 
 %  scores: A matrix of accuracy, f1, and phi.
 %  acc: Vector of accuracy values.
 %  f1: Vector of f1 values.
 %  phi: Vector of phi values.
 
%--------------------------------------------------------------------------

scores=zeros(3,5);
acc=zeros(1,5);
f1=zeros(1,5);
phi=zeros(1,5);

acc(1)=xval.lda.pca.mean.acc;
f1(1)=xval.lda.pca.mean.f1;
phi(1)=xval.lda.pca.mean.phi;

acc(2)=xval.lda.aden.mean.acc;
f1(2)=xval.lda.aden.mean.f1;
phi(2)=xval.lda.aden.mean.phi;

acc(3)=xval.lda.adenz.mean.acc;
f1(3)=xval.lda.adenz.mean.f1;
phi(3)=xval.lda.adenz.mean.phi;

acc(4)=xval.lda.gaden.mean.acc;
f1(4)=xval.lda.gaden.mean.f1;
phi(4)=xval.lda.gaden.mean.phi;

acc(5)=xval.lda.gadenz.mean.acc;
f1(5)=xval.lda.gadenz.mean.f1;
phi(5)=xval.lda.gadenz.mean.phi;

scores(1,:)=acc;
scores(2,:)=f1;
scores(3,:)=phi;

end

