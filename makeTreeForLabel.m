function [ tree ] = makeTreeForLabel( samples, targets, target_emotion )
%MAKETREEFORLABEL Builds a tree depending on the target emotion
%   Detailed explanation goes here

tree = makeTree(samples,1:45,targets == target_emotion);


end

