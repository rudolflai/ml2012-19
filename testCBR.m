function [ labels ] = testCBR( cbr, x )
%TESTCBR Returns a vector of predictions by the CBR system
%   cbr: non-empty CBR system
%   x: matrix of features in the same format as that returned by loaddata

cases = size(x,1);
randcaseorder = randperm(cases);
labels = zeros(cases,1);

for i=randcaseorder,
    [labels(i),cbr] = testExample(cbr, x(i,:));
end

end

