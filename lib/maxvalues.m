function max_value = maxvalues(arr1, arr2)
if (length(arr1) > length(arr2)) || (length(arr1) < length(arr2))
    warning('two array must be the same length');
end
len = length(arr1);
max_value = zeros(len, 1);
for i=1:len
    max_value(i) = max(arr1(i), arr2(i));
end