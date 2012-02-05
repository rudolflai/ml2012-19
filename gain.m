function [information_gain] = gain(au, examples, targets)
% GAIN - computes the The information gain from the attribute test.
%
% AUTHOR:   C.S. Rudolf Lai
% CREATED:  01022012
%
% IN:  s:                set of examples	
%      attribute:        The attribute to be tested
% 
% OUT: information_gain: sparse, binary featureset of aus [N x 45]
	[e_d,   ~    ]   = entropy(0,  0, examples, targets);
	[e_neg, p_neg]   = entropy(au, 0, examples, targets);
	[e_pos, p_pos]   = entropy(au, 1, examples, targets);
	information_gain = e_d - p_neg * e_neg - p_pos * e_pos;
end

function [entropy, probability] = entropy(action_unit, value, examples, targets)
	e_pos = 0;
	e_neg = 0;
	p_pos = 0;
	p_neg = 0;

	% action_unit either == 0 or > 0
	if (action_unit == 0)
		e_pos = sum(targets);
		e_neg = size(targets, 1) - e_pos;
	else
	% filter out the relevant column, resulting in three cases
	% au			target	au+target		action
	% value		1				2						e_pos++
	% value		0				1						e_neg++
	% !value	*				0						no action
		e_pos = sum((examples(:, action_unit) == value) + (targets == 1) == 2);
		e_neg = sum((examples(:, action_unit) == value) + (targets == 1) == 1);
	end

	total = e_pos + e_neg;

	if (total ~= 0)
  	p_pos = e_pos / total;
		p_neg = e_neg / total;
	end

	entropy     = abs(-p_pos * glog(p_pos)) + abs(-p_neg * glog(p_neg));
	probability = total / size(examples, 1);
end

function [result] = glog(in)
	if (in == 0)
    result = 0;
	else
    result = log2(in);
	end
end
