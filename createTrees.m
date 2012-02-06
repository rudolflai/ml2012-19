function [ trees ] = createTrees( )
%CREATETREES Summary of this function goes here
%   Detailed explanation goes here

[examples, targets] = loaddata('cleandata_students.txt');
trees = arrayfun(@(x) makeTreeForLabel(examples, targets, x), 1:6);
save
end

