function [f1Measures,cms] = TestWeightDistFn(examples, targets)
%TestWeightDistFn : Does the ten fold validation.
%Returns the error estimate.
%Inputs are the examples and the EXPECTED targets of the emotions that
%correspond to the data.

%Assumes the following:
%   rows in examples = rows in targets
%   The no. of rows may not be a factor of 10, overlap of test sets may
%   exist

kLimit = 10;

f1Measures = zeros(kLimit,3,3);
% cells to hold matrixes
cms = cell(kLimit,3,3);
for k=1:kLimit
    for ret=1:3
        for get=1:3
            cms{k,ret,get} = zeros(6,6);
        end
    end
end

%First find size of training data
cases = size(examples,1);

%Checks if valid for 10 fold validation
if(cases < 10)
    error('Too few cases to perform ten fold validation with');
end


%First find size of training data
cases = size(examples,1);

%Checks if valid for 10 fold validation
if(cases < 10)
    error('Too few cases to perform ten fold validation with');
end

%Find the (maximum) no. of entries per test data set
%Test set takes 10% of full dataset
testsize = ceil(cases/10);

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
    for k=1:kLimit
        for ret=1:3
            for get=1:3
                %Train a CBR system
                cbr = CBRinit(trainexamples, traintargets);
                
                %Generate CM for this fold                
                cms{k,get,ret} = cms{k,get,ret} + ...
                    sndExamples2CM(cbr, testset, testansset,k,ret,get);
                
            end
        end
    end
end

highestf1=0;
highestK=0;
highestRet=0;
highestGet=0;
for k=1:kLimit
    for ret=1:3
        for get=1:3
            averagerp = CM2RP(cms{k,ret,get});
            f1Measures(k,ret,get) = nanmean(averagerp(:));
            if(f1Measures(k,ret,get)>highestf1)
                highestf1 = f1Measures(k,ret,get);
                highestK=k;
                highestRet=ret;
                highestGet=get;
            end
        end
    end
end
Rtype = {'City Block','Chebyshev','Eulidean'};


display(f1Measures);
fprintf('best f1 performance by:\n');
fprintf('k = %i\n',highestK);
fprintf('dist fn = %s\n',Rtype{highestRet});
fprintf('weighing fn = %s\n',Rtype{highestGet});
fprintf('f1 value = %d\n',highestf1);

end

function[cm] =sndExamples2CM(cbr, x, y,k,ret,get)
    predicted = sndtestCBR(cbr, x,k,ret,get);
    cm = ConfusionMatrix(y, predicted);
end

function [ labels ] = sndtestCBR( cbr, x , k ,ret, get)
  
cases = size(x,1);
randcaseorder = randperm(cases);
labels = zeros(cases,1);

for i=randcaseorder,
    [labels(i),cbr] = sndtestExample(cbr, x(i,:),k,ret,get);
end
end

function [ y, updatedcbr ] = sndtestExample( cbr, x ,k,ret,get)
newcase = cbr_new_case (x, 0);
solvedcase = reuse(sndretrieve(cbr, newcase,k,ret,get), newcase);
updatedcbr = retain(cbr, solvedcase);
y = solvedcase.solution;
end

function [ closestcase ] = sndretrieve( cbr_sys, newcase,k,ret,get)

if(ret==1)
    distFn = @getCityBlockDistance;
end
if(ret==2)
    distFn = @getChebyshevDistance;
end
if(ret==3)
    distFn = @getEuclideanDistance;
end

if(get==1)
    weightedFn = @cityBlockWeightedFn;
end
if(get==2)
    weightedFn = @chebWeightedFn;
end
if(get==3)
    weightedFn = @euclideanWeightedFn;
end
matrixAUs = reshape([cbr_sys.problem], 45, length(cbr_sys))';
closestcase = kNN(k, [newcase.problem], matrixAUs, [cbr_sys.solution], ...
    distFn, weightedFn, [cbr_sys.typicality]);

end
