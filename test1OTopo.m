function [avbestmetric] = test6OTopo(first, last, trials, metric)

[x,y] = loaddata('cleandata_students.txt');
[x2,y2] = ANNdata(x,y);

avbestmetric = ones(1,last);

for i=first:last,
    bestmetricarr = visualizeneurons(i,trials,metric,x2,y2);
    avbestmetric(i) = mean(bestmetricarr);
end

end

