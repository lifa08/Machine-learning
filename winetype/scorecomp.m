function scorecomp(princomp_scores, select_scores)
figure;
% plot white F-Score
subplot(1,2,1);
x = [1 2 3 4];
plot(x, select_scores.white_scores, 'Marker', 'o');

hold on;
plot(x, princomp_scores.white_scores, 'Marker', '*');
text(x, princomp_scores.white_scores, select_scores.Properties.RowNames, ...
    'VerticalAlignment','bottom', 'HorizontalAlignment','right');
hold off;
ylabel('White Type F-Scores');
title('White Type F-Scores');
legend('featrue selection','PCA');

% plot red F-Score
subplot(1,2,2);
plot(x, select_scores.red_scores, 'Marker', 'o');
hold on;
plot(x, princomp_scores.red_scores, 'Marker', '*');
text(x, princomp_scores.red_scores, select_scores.Properties.RowNames, ...
    'VerticalAlignment','bottom', 'HorizontalAlignment','right');
hold off;
ylabel('Red Type F-Scores');
title('Red Type F-Scores');
legend('featrue selection','PCA');