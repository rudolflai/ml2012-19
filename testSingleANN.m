function [ pred ] = testSingleANN( net, au )
%TESTSINGLEANN same as test ANN but uses results from a single output ANN
    [pred, tr] = sim(net,au');
    [v I] = max(pred);
    pred = I==1;

end

