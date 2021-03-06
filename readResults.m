function [mscores,macc,mf1,mphi,mitr]=readResults(res)

%--------------------------------------------------------------------------
 % readResults

 % Last updated: April 2019, J. LaRocco

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

mscores=zeros(4,4,5);
macc=zeros(4,5);
mf1=zeros(4,5);
mphi=zeros(4,5);
mitr=zeros(4,5);

%% unpack each case
xval01=res.a;
[scores,acc,f1,phi,itr]=unwrapStruct(xval01);
macc(1,:)=acc;
mf1(1,:)=f1;
mphi(1,:)=phi;
mitr(1,:)=itr;
mscores(1,:,:)=scores;

xval05=res.b;
[scores,acc,f1,phi,itr]=unwrapStruct(xval05);
macc(2,:)=acc;
mf1(2,:)=f1;
mphi(2,:)=phi;
mitr(2,:)=itr;
mscores(2,:,:)=scores;

xval10=res.c;
[scores,acc,f1,phi,itr]=unwrapStruct(xval10);
macc(3,:)=acc;
mf1(3,:)=f1;
mphi(3,:)=phi;
mitr(3,:)=itr;
mscores(3,:,:)=scores;

xval20=res.d;
[scores,acc,f1,phi,itr]=unwrapStruct(xval20);
macc(4,:)=acc;
mf1(4,:)=f1;
mphi(4,:)=phi;
mitr(4,:)=itr;
mscores(4,:,:)=scores;



end

