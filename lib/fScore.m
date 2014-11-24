% calculates F-score given the labels, predictions and positive value
function [fscore] = fScore(labels, predictions, positive)
  n_tp = 0;
  n_tn = 0;
  n_fp = 0;
  n_fn = 0;
  for i=1:length(predictions)
    if (predictions(i) == positive)
        if (labels(i) == positive)
            n_tp = n_tp + 1;
        else
            n_fp = n_fp + 1;
        end
    else
        if(labels(i) == positive)
            n_fn = n_fn + 1;
        else
            n_tn = n_tn + 1;
        end
    end
  end
  fscore = computeFScore(n_tp, n_fp, n_fn);
end