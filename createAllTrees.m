
function [ trees ] = createAllTrees(examples, targets)
 	
%CREATETREES Generates trees for all the emotion labels and attaches a
	  	
%   field to provide the precision if tenfold = 1, so that the relative reliability of 
	  	
%   each tree can be used to resolve ambiguity
	  	
%   examples: training set
	  	
%   targets: training expected results
	  	
%   tenfold: boolean, use 10 fold cross validation to generate a precision data
	  	

	  	
trees = arrayfun(@(x) makeTreeForLabel(examples, targets, x), 1:6);
	  	
end