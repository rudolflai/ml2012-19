function [ labelPredictions ] = testTrees( trees, testdata )
%Produces a column of predictions by walking through the tree.
entries = size(testdata, 1);

labelPredictions = zeros(entries, 1);

<<<<<<< HEAD
for row=1:entries
    dataRow=testdata(row,:);
    for treeNo=1:6
        mark = testSingleTree ( trees(treeNo) , dataRow);
        if(mark==1)
            if(labelPredictions(row)~=0)
                fprintf('WARNING: MULTIPLE CLASSES\n')
=======
for row = 1:entries
    dataRow = testdata(row, :);
    highestPrecision = -1;   % Choose the tree with highest precision when ambiguous
    for treeNo = 1:6
        mark = testSingleTree(trees(treeNo), dataRow);
        if (mark == 1)
            if (labelPredictions(row) ~= 0)
                % Multiclass conflict
                if (~isfield(trees(treeNo), 'precision'))
                    % Output 0 if precision measurement hasn't been calculated
                    labelPredictions(row) = 0;
                    break
                else
                    if (trees(treeNo).precision > highestprecision)
                        labelPredictions(row) = treeNo;
                        highestPrecision = trees(treeNo).precision;
                    elseif (trees(treeNo).precision == highestprecision)
                        if (rand() > 0.5)
                            labelPredictions(row) = treeNo;
                            highestPrecision = trees(treeNo).precision;
                        end
                    end
                end
            else
                labelPredictions(row) = treeNo;
                highestprecision = trees(treeNo).precision;
>>>>>>> Ambiguity resolved
            end
        end
    end        
end
end

function [ decision ] = testSingleTree ( tree ,dataRow )
%walks through the tree to find if its a positive or not

%if no children, must be leaf therefore decision should be made
    if(size(tree.kids)==0)
        decision = tree.class;
    else
        turn = dataRow(tree.op);
        if(turn==1)
            decision = testSingleTree(tree.kids{2},dataRow);
        else
            decision = testSingleTree(tree.kids{1},dataRow);
        end
    end
end