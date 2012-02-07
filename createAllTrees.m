function [ trees ] = createAllTrees( )
%CREATETREES Generates trees for all the emotion labels and attaches a
%   field to provide the F1-measure, so that the relative reliability of 
%   each tree can be used to resolve ambiguity

[examples, targets] = loaddata('cleandata_students.txt');
trees = arrayfun(@(x) makeTreeForLabel(examples, targets, x), 1:6);


% Generate F1-measure to measure the reliability of each tree
[~,cm] = TenFoldValidation(examples,targets);
rplist = CM2RP(cm);
for i=1:6,
    trees(i).precision = rplist(i,2); 
end
end

