function [ output_args ] = drawTrees( trees )
%DRAWTREES Draws the input list of trees
%   trees: List of trees which adheres to the standard given in the CBC
%       manual

arrayfun(@(x) DrawDecisionTree(trees(x), strcat('Decision tree for: ',emolab2str(x))),1:6)

end

