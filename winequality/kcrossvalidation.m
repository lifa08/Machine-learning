function final_K = kcrossvalidation (wine, fold_num, k_num)

fold_size       = floor(size(wine, 1) / fold_num);
k_accuracies    = zeros(k_num, 1);

wine          = wine(randperm(size(wine,1)), :);
wine_quality  = double(wine(:, end-1));
wine_features = double(wine(:, 1:end-2));

for k=1:k_num
    accuracies = zeros(fold_num, 1);
    for f=1:fold_num
        validation_index = [1:fold_size] + fold_size*(f-1);
        training_index   = find(~ismember([1:size(wine_features,1)], validation_index));

        X_train = wine_features(training_index, :);
        y_train = wine_quality(training_index, :);

        X_vali = wine_features(validation_index, :);
        y_vali = wine_quality(validation_index, :);

        model = fitcknn(X_train, y_train, 'NumNeighbors', k, 'NSMethod','kdtree','Distance','minkowski','BreakTies', 'nearest', 'Standardize',1);

        y_predict = predict(model, double(X_vali));
        accuracy = sum(y_predict == y_vali)/length(validation_index);
        accuracies(f) = accuracy;
    end
    k_accuracies(k) = mean(accuracies);
end

plot(1:k_num, k_accuracies,'g');
xlabel('k');
ylabel('predict accuracy');
title('accuracies of different k');

final_K = find(k_accuracies==max(k_accuracies));
