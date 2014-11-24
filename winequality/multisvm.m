function [result] = multisvm(TrainingSet,GroupTrain,TestSet)
%Models a given training set with a corresponding group vector and 
%classifies a given test set using an SVM classifier according to a 
%one vs. all relation. 
%
%This code was written by Cody Neuburger cneuburg@fau.edu
%Florida Atlantic University, Florida USA
%This code was adapted and cleaned from Anand Mishra's multisvm function
%found at http://www.mathworks.com/matlabcentral/fileexchange/33170-multi-class-support-vector-machine/

u           = unique(GroupTrain);
numClasses  = length(u);
result      = zeros(length(TestSet(:,1)),1);

%build models
for k=1:numClasses
    G1vAll    = (GroupTrain==u(k));
    models(k) = svmtrain(TrainingSet,G1vAll, 'kktviolationlevel', 0.5);
end

%classify test cases
for j=1:size(TestSet,1)
    for k=1:numClasses
        if(svmclassify(models(k),TestSet(j,:))) 
            break;
        end
    end
    result(j) = k;
end