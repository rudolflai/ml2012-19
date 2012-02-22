function [ pred ] = testSingleANN( net, au )
%TESTSINGLEANN same as test ANN but uses results from a single output ANN
    [pred1, tr] = sim(net,au');
    [v I] = max(pred1);
    entry = size(I,2);
    pred = zeros(1,entry);
    for col=1:entry
        if(I(col)==1)
            pred(col) = pred1(I(col),col);
        end
    end

end

