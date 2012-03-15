% Uses ANOVA, Multiple Comparisons determine whether the
% performances of the algorithms (i.e. decision tree, NN and CBR) are 
% statisically the same, and compare the outcomes with the ones from T-test
%
% dataFile: 1 for 'cleandata_students.txt' and 0 for 'noisydata_students.txt'

function [] = areTheyDifferent( dataFile, sigLevel )

f1Measures = TenFoldAllAlgos(dataFile);

% Reshape the 3D matrix to 6-by-10-by-3
f1Measures = permute(f1Measures, [2, 1, 3]);

% Iterate for 6 emotions
fprintf('--------------\n');
fprintf('ANOVA & Multiple Comparison\n');
fprintf('--------------\n');
for i = 1:6
    f1Emo = squeeze(f1Measures(i, :, :));
    [p, anovatab, stats] = anova1(f1Emo);
    if p < sigLevel
        % reject null hypothesis
        fprintf('>>Null hypothesis rejected, 3 algos have different means on %s.\n', emolab2str(i));
        pairwiseComp = multcompare(stats, 'display', 'off', 'ctype', 'bonferroni');
        disp(pairwiseComp);
    else
        fprintf('>>Null hypothesis accepted, 3 algos have the same means on %s.\n', emolab2str(i));
    end
end

% t-test
fprintf('--------------\n');
fprintf('T-test\n');
fprintf('--------------\n');
for i = 1:6
    comb = combnk(1:3, 2)';
    for j = comb
        x = f1Measures(i, :, j(1));
        y = f1Measures(i, :, j(2));
        h = ttest2(x, y, 0.05);
        if h == 0
            fprintf('>>Null hypothesis accepted, %s and %s have the same means on %s\n', algolab2str(j(1)), algolab2str(j(2)), emolab2str(i));
        else
            fprintf('>>Null hypothesis rejected, %s and %s have different means on %s\n', algolab2str(j(1)), algolab2str(j(2)), emolab2str(i));
        end
    end
end


