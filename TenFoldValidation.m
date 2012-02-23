function [ errorEstimate confused foldedConfused growingCM] =...
                    TenFoldValidation( trainingData, ...
                    answersheet,hiddenLayerSize, ...
					train_function, learning_rate, trans_function, ...
                    perf_func, no_epoch, no_goal, no_show, single )
%TENFOLDVALIDATION : Does the ten fold validation.
%Returns the error estimate.
%Inputs are the training data and the "answersheet" of the
%emotions that correspond to the data. 
%the rest are the optimized parameters
%single is a boolean needed to determine if the output is single or not

%Assumes the following: 
%   rows in trainingdata = rows in answersheet
%   The no. of rows may not be a factor of 10, overlap of test sets may
%   exist

%default value
errorEstimate = 0;
confused = zeros(6,6);
foldedConfused = cell(10,1);
growingCM = cell(10,1);

%First find size of training data
entries = size(trainingData,1);
%see if valid for 10 fold validation
if(entries>=10)

%Next find the (maximum) no. of entries per test data set
    testSize = ceil(entries/10);

%estmates would hold all the estimates after each fold 
    estimates = [0 0];
    
    
%loops through the folding procress
    for fold=1:10
        testSet = trainingData(1:testSize,:);
        testAnsSet = answersheet(1:testSize,:);
        trainingData = trainingData(testSize+1:end,:);
        answersheet = answersheet(testSize+1:end,:);
        
        %MAKE ANN HERE
        [net tr] = createNetwork( trainingData,answersheet,hiddenLayerSize, ...
                	train_function, learning_rate, trans_function, ...
                 perf_func, no_epoch, no_goal, no_show,single);
        %CALL testANN
        predictedValues = testANN(net,testSet);    
        
        localCM = ConfusionMatrix(testAnsSet,predictedValues);
        
        foldedConfused{fold} = localCM;
        
        confused = confused + localCM;
        
        growingCM{fold} = confused;
        
        errorVector = bitxor(predictedValues,testAnsSet);
        errors = sum(errorVector>0);
        
        errorEst = errors/size(testAnsSet,1);
        %fprintf('error = %d\n',errorEst);
        
        % I would have used mean but I'm not sure how many test sets there
        % will be all together. Since the array is not as powerful  as the
        % the lists in haskell, I thought this might be better
        estimates(1) = estimates(1)+errorEst;
        estimates(2) = estimates(2)+1;
        
        %I know its expensize to reconnect the data but either way I need
        %to extract the set make the rest into a single matrix and pass it
        %in the createAllTrees function. Either way its expensive
        trainingData = [trainingData;testSet];
        answersheet = [answersheet;testAnsSet];
        
    end    

    errorEstimate = estimates(1)/estimates(2);
    
end

end

