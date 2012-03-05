function [ cm ] = examples2CM( cbr, x, y )
%EXAMPLES2CM Takes input samples and returns a confusion matrix
%   x,y: features and targets as returned by loaddata respectively

predicted = testCBR(cbr, x);
cm = ConfusionMatrix(y, predicted);

end

