function [ results ] = testANN( net , au )
%TESTANN takes the trained network and loaddata AUs and produces a 
%vector of results y in format of loaddata. as mentioned in specs
numNetworks = size(net,1);

if numNetworks==1

    [pred, tr] = sim(net{1},au');
else
    pred = zeros(6,size(au,1));
    for emotion=1:6
        pred(emotion,:) =  testSingleANN(net{emotion},au);
    end
           
end

results = NNout2labels(pred);
end

