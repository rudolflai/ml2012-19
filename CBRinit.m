% Trains a CBR system
%
% examples: matrix of AUs of size [n x 45]
% targets: vector of labels returned by [n x 1]

function [cbr_sys] = CBRinit (examples, targets)

% Preallocate the structure array but need to know the size in advance,
% we don't know the size because there might be repeated cases.
%
%sample_case = cbr_new_case([], 0);
%cbr_sys = repmat(sample_case, size(examples, 1), 1);

for i = 1:size(examples, 1)
    new_case = cbr_new_case(examples(i, :), targets(i));
    cbr_sys = retain(cbr_sys, new_case);
end

end