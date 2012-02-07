function [ f1 ] = RP2F1( rpmatrix )
%RP2F1 Summary of this function goes here
%   Detailed explanation goes here

f1 = zeros(6,1);

for i=1:6,
    recall = rpmatrix(i,1);
    precision = rpmatrix(i,2);
    f1(i) = 2 * recall * precision / ( recall + precision);
end
end

