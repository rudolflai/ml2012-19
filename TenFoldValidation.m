function [perfold, total] = TenFoldValidation(examples, targets)
%TENFOLDVALIDATION : Does the ten fold validation.
%Returns two structs. 
%perfold is a 10 X 2 matrix of recall and precision values
%total is a struct with fields: cm, averagerp (6 X 2 matrix) and f1

%Inputs are the examples and the EXPECTED targets of the emotions that
%correspond to the data.

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
total.cm = zeros(6,6);
perfold = zeros(10,2);

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
    
    %Train a CBR system
    cbr = CBRinit(trainexamples, traintargets);
    
    %Generate CM for this fold
    foldcm = examples2CM(cbr, testset, testansset);
    perfold(foldcount,:) = nanmean(CM2RP(foldcm),1);
    total.cm = total.cm + foldcm;
end

total.averagerp = CM2RP(total.cm);
total.f1 = nanmean(total.averagerp(:));
end

