% Clean window
clear ; close all; clc
addpath '../lib'

% Load training data
wine    = readtable('../data/trainingdataset.csv');
wine    = table2dataset(wine);

% Load test data
testwine  = readtable('../data/testdataset.csv');
testwine  = table2dataset(testwine);

% Convert categorical variables such as type colum into nominal arrays
wine     = ConvertCate(wine);
testwine = ConvertCate(testwine);

% visualize relationship among different features
visualize(wine);

% two variables seems to have important role in deciding wine type
figure;
subplot(1,2,1);
gscatter(wine.totalSulfurDioxide, wine.alcohol, wine.type);
xlabel('totalSulfurDioxide');
ylabel('alcohol');
title('feature selection');

% feature selection
Train_select = [wine.totalSulfurDioxide wine.alcohol];
Test_select  = [testwine.totalSulfurDioxide testwine.alcohol];

% PCA
train_X = double(wine(:,1:end-2));
test_X  = double(testwine(:, 1: end-2));
prin_in = [train_X; test_X];

[train_num, var_num]            = size(train_X);
[Train_princomp, Test_princomp] = PCA(prin_in, var_num, train_num);

% visualize data after PCA
subplot(1,2,2);
Type_train    = wine.type;
gscatter(Train_princomp(:, 1), Train_princomp(:, 2), Type_train);
xlabel('z1');
ylabel('z2');
title('PCA');

% train different models and compare their prediction performance
[select_scores,  select_accuracies]= typetrain(Train_select, wine.type, Test_select, testwine.type);
[princomp_scores, princomp_accuracies] = typetrain(Train_princomp, wine.type, Test_princomp, testwine.type);
accuracycomp(select_accuracies, princomp_accuracies);
scorecomp(princomp_scores, select_scores);

CVSVMModel   = fitcsvm(Train_princomp, wine.type, 'Standardize',true, ...
    'KernelFunction', 'linear');
Type_svm     = predict(CVSVMModel, Test_princomp);
accuracy     = mean((double(Type_svm == testwine.type)));
rmpath '../lib'
return;