function [f1matrix] = TenFoldAllAlgos(clean)
% Returns a 10 X 6 X 3 array, containing all the f1 measures per fold
% for each emotion. Cell order: trees, nn, cbr
if (clean)
    file = 'cleandata_students.txt';
else
    file = 'noisydata_students.txt';
end

[x, y] = loaddata(file);
algos = {@CreateAndTestTrees @CreateAndTestNN @CreateAndTestCBR};
name = {'Decision Trees' 'Neural Networks' 'Case Based Reasoning'};
f1matrix = zeros(10,6,3);

for i=1:3,
    fprintf(name{i});
    f1matrix(:,:,i) = TenFoldValidation(x,y,algos{i})
end
end