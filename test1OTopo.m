function [avbestmetric] = test1OTopo(first, last, trials, metric, testRatio)

[x,y] = loaddata('cleandata_students.txt');
[x2,y2] = ANNdata(x,y);

%avbestmetric = ones(1,last);

avbestmetric = zeros(1,last);

for i=first:last,
    for j=1:6,
        target = [y2(j,:); ~y2(j,:)];
        bestmetricarr = visualizeneurons(i,trials,metric, ...
            testRatio, x2,target);
        avbestmetric(i) = avbestmetric(i) + mean(bestmetricarr);
    end    
end

avbestmetric = avbestmetric / 6;

end

