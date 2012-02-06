function [ finalMatrix ] = ConfusionMatrix( av ,pv )
%CONFUSIONMATRIX compares the 2 vectors and produces a confusion matrix
%   av is the actual values (answers)
%   pv is the predicted values (generated from trees)
finalMatrix = zeros(6,6);

for row=1:size(av,1)
 if(av(row)>0&&pv(row)>0)
    finalMatrix(av(row),pv(row)) = finalMatrix(av(row),pv(row))+1;
 end
end


end

