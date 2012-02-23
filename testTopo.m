function [avbestmetric] = testTopo(first, last, trials, metric)

avbestmetric = ones(1,last);

for i=first:last,
    bestmetricarr = visualizeneurons(i,trials,metric);
    avbestmetric(i) = mean(bestmetricarr);
end

end

