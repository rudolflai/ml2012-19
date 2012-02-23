function [ recall precision ] = combinedCM2RP( cfmatrix )
%COMBINEDCM2RP gets a single RP for all emotions from a confusion matrix
true_p =0;
sum_trials = 0;
sum_p = 0;

for i=1:6,
    true_p = true_p + cfmatrix(i,i);
    sum_trials = sum_trials + sum(cfmatrix(i,:));
    sum_p = sum_p + sum(cfmatrix(:,i));
    
    
end

%Recall
    recall = true_p/sum_trials;
    
    %Precision
    precision = true_p/sum_p;

end

