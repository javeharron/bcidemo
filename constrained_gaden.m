function [g1_winner,max_phi_g1,performance_g1]=constrained_gaden(data,group,bottleneck,offspring,correct_ind,distances)

%--------------------------------------------------------------------------
 % constrained_gaden

 % Last updated: April 2014, J. LaRocco

 % Details: Genetic algorithms constrained in number of offspring and to
 % Finds optimal subset for classification using phi. Also does a z-score transform to normalize data. 
 % Note: GA is constrained in offspring/'phenotypes,' as the system running
 % this is not Shub-Niggurath. Ia! Ia! 

 % Usage:
 % [g1_winner,max_phi_g1,performance_g1]=constrained_genetic_algorithm(training,group,testing,limits,bottleneck,offspring)
 
 % Input: 
 %  data: Matrix of features data from training subjects.  
 %  group: Matrix of feature data from training subject labels (0 or 1).
 
 %  bottleneck: Number of features to keep.  
 %  correct_ind: Indices of higher feature space.   
 %  distances: distances of values
 % Output: 
 %  g1_winner: feature subset that performed best. 
 %  max_phi_g1: corresponding max phi for it.  
 %  performance_g1: performance matrix for all offspring. 
    
%--------------------------------------------------------------------------

limits=length(distances);


% R_1=find(group==1);
% x1=data(R_1,:);  
% 
% 
% R_0=find(group==0);
% x0=data(R_0,:);  
% 

%offspring=4;

g1=[];
for ia=1:(offspring+1);
   g1(:,ia)=randperm(limits);
    
end




g1=g1(1:bottleneck,:);
g1=sort(g1,'ascend');

performance_g1=[];

for bierce=1:(offspring+1)
performance_g1(:,bierce)=sum(distances(g1(:,bierce)));    
end


%for vrilya=1:(offspring+1)

%     
%     
%     training_ga1=x1(:,[correct_ind(g1(:,vrilya))]);
% [d1,d2]=size(training_ga1); 
%     training_ga0=x0(:,[correct_ind(g1(:,vrilya))]);
% [u1,u2]=size(training_ga0); 
% 
% 
% midpoint1=floor(d1*.5);
% segpoint1=midpoint1+1;
% 
% midpoint0=floor(u1*.5);
% segpoint0=midpoint0+1;
% 
% trainga1=x1([1:midpoint1],:);
% 
% testga1=x1([segpoint1:d1],:);
% leng1=length([segpoint1:d1]);
% 
% trainga0=x0([1:midpoint0],:);
% testga0=x0([segpoint0:u1],:);
% leng0=length([segpoint0:u1]);
% 
% trainga=[trainga1; trainga0];
% testga=[testga1; testga0];
% 
%     %training_ga=[training_ga1; training_ga0];
% trainlabel=[ones(midpoint1,1); zeros(midpoint0,1)];
% testlabel=[ones(leng1,1); zeros(leng0,1)];
% 
% 
% %randomize orders
% 
% [instances,featurenumset]=size(trainga);
% p=randperm(instances);
% trainlabel=reshape(trainlabel(p),size(trainlabel));
% training_ga=reshape(trainga(p,:),size(trainga));
% 
% [instances2,featurenumset2]=size(testga);
% p2=randperm(instances2);
% testlabel=reshape(testlabel(p2),size(testlabel));
% test_ga=reshape(testga(p2,:),size(testga));
% 
%     
%     
%  %[d1,d2]=size(training_ga1);
% %trainingreords=randperm(d1);
% pseudotrain_label=trainlabel;
% 
% pseudotrain_ga=training_ga;
% 
% pseudotest_ga=test_ga;
% 
% 
% [C]=prototype_ldam_default_classify(pseudotest_ga,pseudotrain_ga,pseudotrain_label);
% 
% 
% [phi,roc,auc_roc,accuracy,sensitivity,specificity,acc2,ppv,npv]=prototype_correction(C,testlabel);
% 
% performance_g1(:,vrilya)=[phi,auc_roc,accuracy,sensitivity,specificity,acc2,ppv,npv];    
%  
%end


max_phi_g1=max(performance_g1(1,:));

   imaro=find(performance_g1(1,:)==max_phi_g1);
    solomon_kane=imaro(1); 

    g1_winner=g1(:,[solomon_kane]);
    
end
