function [cbr_sys] = CBRinit (examples, targets)
% Trains a CBR system
%
% examples: matrix of AUs of size [n x 45]
% targets: vector of labels returned by [n x 1]
% cbr_sys is a struct array of cases


cbr_sys = cbr_new_case(examples(1, :), targets(1));

for i = 2:size(examples, 1)
    new_case = cbr_new_case(examples(i, :), targets(i));
    cbr_sys = retain(cbr_sys, new_case);
end

end