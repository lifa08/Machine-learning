% Train data with naive Bayesian and return the F-Score
function [Type_predict] = BayesTrain(Train, Train_result, Test_train)
Nb            = NaiveBayes.fit(Train,Train_result);
Type_predict  = Nb.predict(Test_train);