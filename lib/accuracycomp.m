function accuracycomp(select_accuracies, princomp_accuracies)
figure;
x = [1 2 3 4];
plot(x, table2array(select_accuracies), 'Marker', 'o');

hold on;
plot(x, table2array(princomp_accuracies), 'Marker', '*');

max_value = maxvalues(table2array(select_accuracies), table2array(princomp_accuracies));
text(x, max_value, select_accuracies.Properties.RowNames, ...
    'VerticalAlignment','bottom', 'HorizontalAlignment','right');
hold off;
ylabel('Accuracy');
title('accuracy of different classifiers');
legend('featrue selection','PCA');