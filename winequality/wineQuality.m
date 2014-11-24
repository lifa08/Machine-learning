% Clean window
clear ; close all; clc
addpath '../lib'

% Load training data
wine = readtable('../data/trainingdataset.csv');
wine = table2dataset(wine);

% Load test data
testwine  = readtable('../data/testdataset.csv');
testwine  = table2dataset(testwine);

% Construct data to be trained and tested
train_features = double(wine(:,1:end-2));
test_features  = double(testwine(:, 1: end - 2));

train_quality = double(wine(:, end-1));
test_quality  = double(testwine(:, end-1));

% train with different models without PCA
accuracies_ori = qualitytrain(train_features,train_quality, test_features,test_quality);

% train with PCA
prin_in   = [train_features; test_features];

[train_num, var_num]            = size(train_features);
[Train_princomp, Test_princomp] = PCA(prin_in, var_num, train_num);

accuracies_pca = qualitytrain(Train_princomp,train_quality, Test_princomp,test_quality);

figure;
x = [1 2 3 4];
plot(x, accuracies_ori, 'Marker', 'o');
hold on;
plot(x, accuracies_pca, 'Marker', '*');
text(x, accuracies_ori, {'generalized linear' 'naive Bayes' 'multiSVM' '1-NN'}, ...
    'VerticalAlignment','bottom', 'HorizontalAlignment','right');
hold off;
ylabel('Accuracy');
title('Accuracies of different model trained with original features and PCA');
legend('Original features','PCA', 'Location','northwest');
rmpath '../lib'