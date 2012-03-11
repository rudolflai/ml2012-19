function [ f1 ] = RP2F1( rpmatrix )
%RP2F1 Extracts F1 measure from recall and precision matrix
%   rpmatrix: Recall and precision matrix
%   Based on formulas given in CBC manual

f1 = zeros(6,1);

for i=1:6,
    recall = rpmatrix(i,1);
    precision = rpmatrix(i,2);
    if((recall+precision)~=0)
        f1(i) = 2 * recall * precision / ( recall + precision);
    end
end
end

