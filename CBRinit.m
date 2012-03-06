% Trains a CBR system
%
% examples: matrix of AUs of size [n x 45]
% targets: vector of labels returned by [n x 1]

function [cbr_sys] = CBRinit (examples, targets)

for i = 1:size(examples, 1)
    new_case = cbr_new_case(examples(i, :), targets(i));
    cbr_sys = retain(cbr_sys, new_case);
end

end