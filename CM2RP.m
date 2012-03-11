function [ rpmatrix ] = CM2RP( cfmatrix )
%CM2RP Extracts recall and precision rates from a confusion matrix
%   cfmatrix: 6 X 6 confusion matrix

rpmatrix = zeros(6,2);

for i=1:6,
    true_p = cfmatrix(i,i);
    sum_trials = sum(cfmatrix(i,:));
    sum_p = sum(cfmatrix(:,i));
%     if(true_p==0)
%         rpmatrix(i,1) = 0;
%         rpmatrix(i,2) = 0;
%     else
    %Recall
    rpmatrix(i,1) = true_p/sum_trials;
    
    %Precision
    rpmatrix(i,2) = true_p/sum_p;
    
        
    end
end


