function [ results ] = testANN( net , au )
%TESTANN takes the trained network and loaddata AUs and produces a 
%vector of results y in format of loaddata. as mentioned in specs
[pred, tr] = sim(net,au');

results = NNout2labels(pred);

end

