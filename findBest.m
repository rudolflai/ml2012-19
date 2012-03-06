[x y] = loaddata('cleandata_students.txt');
f1M = zeros(10,3,3);
for i=1:50
  [f1 cms] = TestWeightDistFn(x,y);
  f1M = f1 + f1M;
end

highestf1=0;
highestK=0;
highestRet=0;
highestGet=0;
 avgF1 = f1M/50;
 for k=1:10
    for ret=1:3
        for get=1:3
            if(avgF1(k,ret,get)>highestf1)
                highestf1 = avgF1(k,ret,get);
                highestK=k;
                highestRet=ret;
                highestGet=get;
            end
        end
    end
end
Rtype = {'City Block','Chebyshev','Eulidean'};


display(avgF1);
fprintf('best f1 performance by:\n');
fprintf('k = %i\n',highestK);
fprintf('dist fn = %s\n',Rtype{highestRet});
fprintf('weighing fn = %s\n',Rtype{highestGet});
fprintf('f1 value = %d\n',highestf1);
