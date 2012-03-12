function [f1matrix] = TenFoldAllAlgos(clean)

if (clean)
    file = 'cleandata_students.txt';
else
    file = 'noisydata_students.txt';
end

[x, y] = loaddata(file);
algos = {@CreateAndTestTrees @CreateAndTestNN @CreateAndTestCBR};

f1matrix = cellfun(@(algo) TenFoldValidation(x,y,algo), algos, 'UniformOutput', false);

end