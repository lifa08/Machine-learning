function visualize(wine)
figure;
gplotmatrix(double(wine(:,1:end-2)), [], wine.type, [], [], [], 'off', 'hist', wine.Properties.VarNames(:, 1:end-2), wine.Properties.VarNames(:, 1:end-2));
