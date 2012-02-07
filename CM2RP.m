function [ prmatrix ] = CM2RP( cfmatrix )
%CM2RP Summary of this function goes here
%   Detailed explanation goes here

prmatrix = zeros(6,2);

for i=1:6,
    true_p = cfmatrix(i,i);
    sum_trials = sum(cfmatrix(i,:));
    sum_p = sum(cfmatrix(:,i));
    
    %Recall
    prmatrix(i,1) = true_p/sum_trials;
    
    %Precision
    prmatrix(i,2) = true_p/sum_p;
end
end

