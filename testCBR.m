function [ labels ] = testCBR( cbr, x )
%TESTCBR Returns a vector of predictions by the CBR system
%   cbr: non-empty CBR system
%   x: matrix of features in the same format as that returned by loaddata

cases = size(x,1);
randcases = randperm(cases);
currentcbrstate = cbr;
labels = zeros(cases,1);

for i=randcases,
    [labels(i),currentcbrstate] = testExample(currentcbrstate, x(i,:));
end

end

