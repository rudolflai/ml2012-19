function [best_attr] = best_attribute(examples, attribs, targets)
% BEST_ATTRIBUTE - Selects the best attribute at hand based on information gain
%
% AUTHOR:   C.S. Rudolf Lai
% CREATED:  01022012
% 
% attribs:  list of attributes
% examples: set of training examples
% targets:  target labels for training examples
gains            = arrayfun(@(au) gain(au, examples, targets), attribs);
[~, action_unit] = max(gains);
best_attr        = attribs(action_unit);
end

