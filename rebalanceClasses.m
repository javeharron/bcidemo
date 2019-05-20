function [cutData,newLength]=rebalanceClasses(class1,ratio)

%--------------------------------------------------------------------------
 % rebalanceClasses.m

 % Last updated: May 2019, John LaRocco
 
 % Jeju National University-Biomedical Ultrasound Lab
 
 % Details: Looks at the total size of each class, and then reduces it to a
 % fraction of its prior size. For example, a ratio of '0.25,' reduces data
 % to the first "25%" of its original size. 
 
 % Input Variables: 
 % class1: matrix containing class to be reduced (size: features by trials)
 % ratio: percentage between 0 and 1 to reduce class size to
 
 % Output Variables: 
 % cutData: Feature matrix, reduced to specified ratio.
 % scalarValue: Length of new matrix by number of trials.
 
%--------------------------------------------------------------------------

newLength=ceil(size(class1,2)*ratio);

cutData=class1(:,[1:newLength]);


end