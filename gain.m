function [information_gain] = gain(s, attribute)
% GAIN - computes the The information gain from the attribute test.
%
% AUTHOR:   C.S. Rudolf Lai
% CREATED:  01022012
%
% IN:  s:                set of examples	
%      attribute:        The attribute to be tested
% 
% OUT: information_gain: sparse, binary featureset of aus [N x 45]


function [res] = entropy(positive, negative)
	total = positive + negative;
	res = -(positive/total)*log2(positive/total) - (negative/total)*log2(negative/total);
