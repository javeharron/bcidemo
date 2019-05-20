function [mscores,macc,mf1,mphi,mitr]=readBBIResults(res)

%--------------------------------------------------------------------------
 % readBBIResults

 % Last updated: May 2019, J. LaRocco

 % Details: Reads loaded result structs.  
 % Usage:
 % xval=readResults(res);

 % Input: 
 %  res: A struct of results, with subsets of 1, 5, 10, and 20 features.   
 
 % Output: 
 %  mscores: a matrix of accuracy, f1, and phi.
 %  macc: Matrix of accuracy values.
 %  mf1: Matrix of f1 values.
 %  mphi: Matrix of phi values.
 %  mitr: Matrix of ITR (bits/min)
 
%--------------------------------------------------------------------------

mscores=zeros(1,4,5);
macc=zeros(1,5);
mf1=zeros(1,5);
mphi=zeros(1,5);
mitr=zeros(1,5);

%% unpack each case


xval10=res.control.c;
[scores,acc,f1,phi,itr]=unwrapStruct(xval10);
macc(1,:)=acc;
mf1(1,:)=f1;
mphi(1,:)=phi;
mitr(1,:)=itr;
mscores(1,:,:)=scores;


end

