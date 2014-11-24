% must be run at matlab R2014b
% Clean window
clear ; close all; clc;
addpath '../lib'

% load training data
wine = readtable('../data/trainingdataset.csv');
wine = table2dataset(wine);

wine_quality  = double(wine(:, end-1));
wine_features = double(wine(:, 1:end-2));

% Load test data
testwine  = readtable('../data/testdataset.csv');
testwine  = table2dataset(testwine);

test_features = double(testwine(:, 1:end-2));
test_quality  = double(testwine(:, end-1));

% k-cross validation to get a suitable k
fold_num = 100;
k_num    = 15;
K = kcrossvalidation(wine, fold_num, k_num);

% Predict with the best k
knn_model       = fitcknn(wine_features, wine_quality, 'NumNeighbors', K, 'NSMethod','kdtree','Distance','minkowski','BreakTies', 'nearest', 'Standardize',true);
predict_quality = predict(knn_model, test_features);

% Calculate fscores for each quality value
knn_fscores = qualityScores(test_quality, predict_quality);
rmpath '../lib'