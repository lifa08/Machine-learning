% train data with different models
function [FScoreTable, AccuracyTable] = train(Train_X, Train_Y,Test_X, Test_Y)
white_scores = zeros(4,1);
red_scores   = zeros(4,1);

% bayes
Type_nb         = BayesTrain(Train_X, Train_Y, Test_X);
nb_accuracy     = mean((double(Type_nb == Test_Y)));
white_scores(1) = fScore(Test_Y, Type_nb, 'White');
red_scores(1)   = fScore(Test_Y, Type_nb, 'Red');

% svm
CVSVMModel   = fitcsvm(Train_X, Train_Y);
Type_svm     = predict(CVSVMModel, Test_X);

svm_accuracy     = mean((double(Type_svm == Test_Y)));
white_scores(2)  = fScore(Test_Y, Type_svm, 'White');
red_scores(2)    = fScore(Test_Y, Type_svm, 'Red');

% knn model
knn_ml   = fitcknn(Train_X, Train_Y);
Type_knn = predict(knn_ml, Test_X);

knn_accuracy     = mean((double(Type_knn == Test_Y)));
white_scores(3)  = fScore(Test_Y, Type_knn, 'White');
red_scores(3)    = fScore(Test_Y, Type_knn, 'Red');

% desicion tree
dt_ml   = fitctree(Train_X, Train_Y);
Type_dt = predict(dt_ml, Test_X);

dt_accuracy      = mean((double(Type_dt == Test_Y)));
white_scores(4)  = fScore(Test_Y, Type_dt, 'White');
red_scores(4)    = fScore(Test_Y, Type_dt, 'Red');

rowname = {'Naive Bayesian', 'SVM', 'knn', 'Decision tree'};
FScoreTable = table(white_scores, red_scores, 'RowNames', rowname);

AccuracyTable = table(nb_accuracy, svm_accuracy, knn_accuracy, dt_accuracy);
