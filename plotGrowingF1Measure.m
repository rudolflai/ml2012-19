
[val1 val2 nil foldedSingleOutCM]=...
    TenFoldValidation(x,y,26,'trainscg',0.02,{'tansig'},'mse',100,0,5,1);
[val3 val4 nil1 foldedSixOutCM]=...
    TenFoldValidation(x,y,11,'trainscg',0.02,{'tansig'},'mse',100,0,5,0);

singleOutF1 = zeros(10,1);
sixOutF1 = zeros(10,1);
foldNo = zeros(10,1);

for fold=1:10
   foldNo(fold) = fold;
   singleOutRP = combinedCM2RP(foldedSingleOutCM{fold});
   sixOutRP = combinedCM2RP(foldedSixOutCM{fold});
   [singleOutRecall singleOutPrecision] = combinedCM2RP(foldedSingleOutCM{fold});
   [sixOutRecall sixOutPrecision] = combinedCM2RP(foldedSixOutCM{fold});
   
   singleOutF1(fold) = 2 * singleOutRecall * singleOutPrecision / ...
                        ( singleOutRecall + singleOutPrecision);
   sixOutF1(fold) = 2 * sixOutRecall * sixOutPrecision / ...
                        ( sixOutRecall + sixOutPrecision);
   
end

plot(foldNo,singleOutF1,foldNo,sixOutF1);
axis([1 10 0 1.3]);
legend('SingleOutputNN','SixOutputNN');
title('Growing F1 measure per fold');
ylabel('F1 measure');
xlabel('Fold no.');
