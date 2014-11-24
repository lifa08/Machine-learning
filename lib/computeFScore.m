% compute f-score given:
%  n_tp: true positives
%  n_tn: true negatives
%  n_fp: false positives
%  n_fn: false negatives
function fscore = computeFScore(n_tp, n_fp, n_fn)
  if (n_tp == 0)
    fscore = 0;
  else
    precision =  n_tp / (n_tp + n_fp);
    recall = n_tp / (n_tp + n_fn);
    fscore = 2 * precision * recall / (precision + recall);
  end
