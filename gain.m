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
[e_d,   ~]       = entropy(0,  0, examples, targets);
[e_neg, p_neg]   = entropy(au, 0, examples, targets);
[e_pos, p_pos]   = entropy(au, 1, examples, targets);
information_gain = e_d - p_neg * e_neg - p_pos * e_pos;
end

function [entropy, probability] = entropy(action_unit, value, examples, targets)
e_pos = 0;
e_neg = 0;
p_pos = 0;
p_neg = 0;

% Count the number of positive and negative examples
% I still think that this can be achieved in an alternative fashion
% namely using some sort of filter and then counting the size of the 
% resulting array
for i = 1:size(examples, 1)
  if (action_unit == 0 || examples(i, action_unit) == value)
    if (targets(i) == 1)
      e_pos = e_pos + 1;
    elseif (targets(i) == 0)
      e_neg = e_neg + 1;
    end
  end
end

total = e_pos + e_neg;
p_pos = e_pos / total;
p_neg = e_neg / total;

entropy     = abs(-p_pos * log2(p_pos)) + abs(-p_neg * log2(p_neg));
probability = total / size(examples, 1);
end
