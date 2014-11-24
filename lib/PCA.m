% implement PCA
function [Train_princomp, Test_princomp] = PCA(prin_in, var_num, train_num)
[COEFF,SCORE,latent] = princomp(prin_in);

% Choose K
for i=1:var_num
    if(sum(latent(1:i,1)) > 0.98*sum(latent))
        break;
    end
end
k = i;
Train_princomp  = SCORE(1:train_num,1:k);
Test_princomp   = SCORE(train_num+1:end, 1:k);