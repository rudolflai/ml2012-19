[x y] = loaddata('cleandata_students.txt');
[x2 y2] = loaddata('noisydata_students.txt');

cms = cell(3);

cms{1} = CreateAndTestTrees(x,y,x2,y2);
cms{2} = CreateAndTestNN(x,y,x2,y2);
cms{3} = CreateAndTestCBR(x,y,x2,y2);

f1s = cell(3);

atype = {'trees','ANN','CBR'};

bestf1 = 0;
at = 0;

for i=1:3
    display(atype{i});
    rp = CM2RP(cms{i});
    f1s{i} = RP2F1(rp); 
    display(f1s{i});
    meanf1 = nanmean(f1s{i});
    fprintf('Average F1 value = %d\n',meanf1);
    if(meanf1>bestf1)
        bestf1= meanf1;
        at = i;
    end
end

fprintf('The best average F1 is from %s with a value of %d\n',atype{at},bestf1);