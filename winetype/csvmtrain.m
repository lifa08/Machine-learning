clear, clc, close all;
% Load training data
wine    = readtable('trainingdataset.csv');
wine    = table2dataset(wine);

% Load test data
testwine  = readtable('testdataset.csv');
testwine  = table2dataset(testwine);

% Convert categorical variables such as type colum into nominal arrays
wine     = ConvertCate(wine);
testwine = ConvertCate(testwine);

% fit svm model
CVSVMModel = fitcsvm(double(wine(:, 1:end-2)), wine.type);
Type_svm = predict(CVSVMModel, double(testwine(:, 1:end-2)));
accuracy   = mean((double(Type_svm == testwine.type)));

wsc  = fScore(testwine.type, Type_svm, 'White');
rsc  = fScore(testwine.type, Type_svm, 'Red');