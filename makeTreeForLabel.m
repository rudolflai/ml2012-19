function [ tree ] = makeTreeForLabel( samples, targets, target_emotion )
	  	
%MAKETREEFORLABEL Builds a tree depending on the target emotion
	  	
%   samples: Training data of AU activation
	  	
%   targets: Training data expected results
	  	
%   target_emotion: the emotion label the tree will classify
	  	

	  	
[tree depth] = makeTree(samples,1:size(samples,2),targets == target_emotion,0);
	  	
tree.depth = depth;
	  	

	  	
end