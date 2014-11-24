function Accuracyarr = qualitytrain(train_features,train_quality, test_features,test_quality)

% generalized linear model
gl_mdl      = fitglm(train_features, train_quality, 'Distribution', 'normal');
quality_gl  = predict(gl_mdl, test_features);
quality_gl  = round(quality_gl);
gl_accuracy = sum(test_quality == quality_gl)/length(test_quality);

% naive Bayes
quality_nb   = BayesTrain(train_features, train_quality, test_features);
nb_accuracy  = sum(test_quality == quality_nb)/length(test_quality);

% multisvm
quality_svm  = multisvm(train_features, train_quality, test_features);
svm_accuracy = sum(test_quality == quality_svm)/length(test_quality);

% kNN
knn_mdl      = fitcknn(train_features, train_quality, 'NumNeighbors', 1, 'Distance', 'minkowski', 'Standardize',true);
Quality_knn  = predict(knn_mdl, test_features);
knn_accuracy = sum(test_quality == Quality_knn)/length(test_quality);

Accuracyarr = [gl_accuracy, nb_accuracy, svm_accuracy, knn_accuracy];
