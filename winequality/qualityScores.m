function fscores = qualityScores(test_quality, predict_quality)
quality_values  = [1, 2, 3, 4, 5, 6, 7];
fscores     = zeros(7,1);
for i=1:length(quality_values)
    fscores(i) = fScore(test_quality, predict_quality, quality_values(i));
end