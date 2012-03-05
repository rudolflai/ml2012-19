function [ finalMatrix ] = ConfusionMatrix( av ,pv )
%CONFUSIONMATRIX compares the 2 vectors and produces a confusion matrix
%   av is the actual values (answers)
%   pv is the predicted values (generated from CBR system)
finalMatrix = zeros(6,6);

for row=1:size(av,1)
 actual = av(row);
 predicted = pv(row);
 if(actual > 0 && predicted > 0)
    finalMatrix(actual, predicted) = finalMatrix(actual, predicted) + 1;
 end
end


end

