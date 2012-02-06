function [ output_args ] = drawTrees( trees )
%DRAWTREES Summary of this function goes here
%   Detailed explanation goes here

arrayfun(@(x) DrawDecisionTree(trees(x), strcat('Decision tree for: ',emolab2str(x))),1:6)

end

