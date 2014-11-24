% Clean window
clear ; close all; clc
addpath '../lib'

% Load training data
wine = readtable('../data/trainingdataset.csv');
wine = table2dataset(wine);

% Load test data
testwine  = readtable('../data/testdataset.csv');
testwine  = table2dataset(testwine);

% Convert all the categorical variables such as type colum into nominal arrays
wine     = ConvertCate(wine);
testwine = ConvertCate(testwine);

% fit svm model
CVSVMModel = fitcsvm(double(wine(:, 1:end-2)), wine.type);
Type_svm = predict(CVSVMModel, double(testwine(:, 1:end-2)));

% Construct training data to be trained and tested
train_white_index = find(wine.type == 'White');
train_red_index   = find(wine.type == 'Red');

train_white_features = double(wine(train_white_index,1:end-2));
train_white_quality  = double(wine(train_white_index,end-1));

train_red_features = double(wine(train_red_index,1:end-2));
train_red_quality  = double(wine(train_red_index,end-1));

% predict the class and construct
test_white_index = find(Type_svm == 'White');
test_red_index   = find(Type_svm == 'Red');

test_white_features = double(testwine(test_white_index,1:end-2));
test_white_quality  = double(testwine(test_white_index,end-1));

test_red_features = double(testwine(test_red_index,1:end-2));
test_red_quality  = double(testwine(test_red_index,end-1));

% train with kNN for white wine
knn_white_model       = fitcknn(train_white_features, train_white_quality,'NumNeighbors', 1, 'NSMethod','kdtree','Distance','minkowski','BreakTies', 'nearest', 'Standardize',true);
predict_white_quality = predict(knn_white_model, test_white_features);
white_knn_fscores     = qualityScores(test_white_quality, predict_white_quality);

% train with kNN for red wine
knn_red_model       = fitcknn(train_red_features, train_red_quality,'NumNeighbors', 1, 'NSMethod','kdtree','Distance','minkowski','BreakTies', 'nearest', 'Standardize',true);
predict_red_quality = predict(knn_red_model, test_red_features);
red_knn_fscores     = qualityScores(test_red_quality, predict_red_quality);

% reconstruct the whole test data
testwinequality = [test_white_quality; test_red_quality];
testwinepredict = [predict_white_quality; predict_red_quality];

redwhite_knn_fscores     = qualityScores(testwinequality, testwinepredict);
rmpath '../lib'