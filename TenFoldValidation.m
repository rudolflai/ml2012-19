function [ errorEstimate ] = TenFoldValidation( trainingData,answersheet )
%TENFOLDVALIDATION : Does the ten fold validation.
%Returns the error estimate.
%Inputs are the training data and the "answersheet" of the
%emotions that correspond to the data.

%Assumes the following: 
%   rows in trainingdata = rows in answersheet
%   The no. of rows may not be a factor of 10, overlap of test sets may
%   exist

%default value
errorEstimate = 0;

%First find size of training data
entries = size(trainingData,1);
%see if valid for 10 fold validation
if(entries>=10)

%Next find the (maximum) no. of entries per test data set
    testSize = floor(entries/10);

%estmates would hold all the estimates after each fold 
    estimates = [];
    
    marker = 1;
    
%loops through the folding procress
    while(marker<=entries)
        testSet = trainingData(1:testSize,:);
        testAnsSet = answersheet(1:testSize,:);
        trainingData = trainingData(testSize+1:end,:);
        answersheet = answersheet(testSize+1:end,:);
        marker = marker + testSize;
        %we do the tree making and calculations here
        for label=1:6
            tree(label) = makeTreeForLabel(trainingData,answersheet,label);
        end
        %I know its expensize to reconnect the data but either way I need
        %to extract the set make the rest into a single matrix and pass it
        %in the makeTree function. Either way its expensive
        trainingData = [trainingData;testSet];
        answersheet = [answersheet;testAnsSet];
        
        fprintf('marker = %i\n',marker);
    end    
    m = size(trainingData,1);
    fprintf('final=%i\n',m);
end
end


