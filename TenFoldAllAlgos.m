function [f1matrix] = TenFoldAllAlgos(clean)
% Returns a 3 element cell array, containing all the f1 measures per fold
% for each emotion, i.e 10 X 6. Cell order: trees, nn, cbr
if (clean)
    file = 'cleandata_students.txt';
else
    file = 'noisydata_students.txt';
end

[x, y] = loaddata(file);
algos = {@CreateAndTestTrees @CreateAndTestNN @CreateAndTestCBR};

f1matrix = cellfun(@(algo) TenFoldValidation(x,y,algo), algos, ...
    'UniformOutput', false);

end