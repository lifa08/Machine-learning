% Convert all the categorical variables such as type colum into nominal arrays
function wine = ConvertCate(wine)
    names  = wine.Properties.VarNames;
    ncols  = size(wine,2);
    category = false(1,ncols);
    for i = 1:ncols
        if isa(wine.(names{i}),'cell') || isa(wine.(names{i}),'nominal')
            category(i) = true;
            wine.(names{i}) = nominal(wine.(names{i}));
        end
    end
