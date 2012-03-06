function [f1Measures] = TestWeightDistFn(examples, targets)
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

%First find size of training data
cases = size(examples,1);

%Checks if valid for 10 fold validation
if(cases >= 10)
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
    testlogic = zeros(cases,1);
    testlogic(1 + (foldcount - 1) * testsize : foldcount * testsize) = 1;
    
    testset = randexamples(testlogic,:);
    testansset = randtargets(testlogic);
    
    trainexamples = randexamples(~testlogic,:);
    traintargets = randtargets(~testlogic);
    cms = cell(kLimit,3,3);
    count = 0;
    %Train a CBR system
    for k=1:kLimit
        for ret=1:3
            for get=1:3
                if(count<(kLimit*3*3))
                    count = count+1;
                    cms{k,ret,get}=zeroes(6,6);
                end
                cbr = CBRinit(trainexamples, traintargets);
                cases = size(testset,1);
                randcases = randperm(cases);
                labels = zeros(cases,1);
                for i=randcases,
                    newcase = cbr_new_case (testset(), 0);
                    cases;
                    solvedcase;
                    if(ret==1)
                        cases = retrieveCityBlock(cbr,newcase,k);
                    else
                    if(ret==2)
                        cases = retrieveChebyshev(cbr,newcase,k);
                    else
                        cases = retrieveEuclidean(cbr,newcase,k);
                    end
                    end
                    if(get==1)
                        solvedcase = reuseCityBlock(cases,newcase);
                    else
                    if(get==2)
                        solvedcase = reuseChebyshev(cases,newcase);
                    else
                        solvedcase = reuseEuclidean(cases,newcase);
                    end
                    end
                    cbr = retain(cbr, solvedcase);
                    labels(i) = solvedcase.solution;
                    cms{k,ret,get} = cms{k,ret,get}+ ...
                        ConfusionMatrix(testansset, labels);
                end
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
            averagerp = mean(CM2RP(cms{k,ret,get}),1);
            rc = averagerp(1);
            prc = averagerp(2);
            f1Measures(k,ret,get) = 2 * rc * prc / ( rc + prc);
            if(f1>highestf1)
                highestK=k;
                highestRet=ret;
                highestGet=get;
            end
        end
    end
end
Rtype = {'City Block','Chebyshev','Eulidean'};


display(f1Measures);
sprintf('best f1 performance by:\n');
sprintf('k = %i\n',highestK);
sprintf('dist fn = %s\n',Rtype{highestRet});
sprintf('weighing fn = %s\n',Rtype{highestGet});

end

function[cases] = retrieveCityBlock(cbr,newcase,k)

end
function[cases] = retrieveChebyshev(cbr,newcase,k)

end
function[cases] = retrieveEuclidean(cbr,newcase,k)

end
function[solved] = reuseCityBlock(oldcases,newcase)

end

function[solved] = reuseChebyshev(oldcases,newcase)

end

function[solved] = reuseEuclidean(oldcases,newcase)

end