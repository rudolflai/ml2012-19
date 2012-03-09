function [perfold] = TenFoldValidation(examples, targets, algofn)
%TENFOLDVALIDATION : Does the ten fold validation for 1 algorithm
%perfold is a 10 X 6 matrix of f1 measures for each fold and emotion

%Inputs are the examples and the EXPECTED targets of the emotions that
%correspond to the data. 
%algofn:    function which takes in the split data and returns a confusion
%           matrix

%Assumes the following:
%   rows in examples = rows in targets
%   The no. of rows may not be a factor of 10, overlap of test sets may
%   exist



%First find size of training data
cases = size(examples,1);

%Checks if valid for 10 fold validation
if(cases < 10)
    error('Too few cases to perform ten fold validation with');
end

%Find the (maximum) no. of entries per test data set
%Test set takes 10% of full dataset
testsize = ceil(cases/10);

%default value
perfold = zeros(10,6);

%Randomize the order of targets and examples once
order = randperm(cases);
randexamples = examples(order, :);
randtargets = targets(order);

%loops through the folding process
for foldcount=1:10,
    
    %Subdivide the dataset into test and training sets
    testlogic = false(cases,1);
    testlogic(1 + (foldcount - 1) * testsize : foldcount * testsize) =...
        true;
    
    testset = randexamples(testlogic,:);
    testansset = randtargets(testlogic);
    
    trainexamples = randexamples(~testlogic,:);
    traintargets = randtargets(~testlogic);

    foldcm = algofn(trainexamples, traintargets, testset, testansset);

    perfold(foldcount,:) = RP2F1(CM2RP(foldcm));
end
end

