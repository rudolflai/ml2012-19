function [ labelPredictions ] = testTrees( trees, testdata )
%Produces a column of predictions by walking through the tree.
%Combines the output of the 6 classifiers
%If precision data is available, use it to determine which output is more
%reliable.

NO_POS_THRESHOLD = 0.5;
entries = size(testdata, 1);

labelPredictions = zeros(entries, 1);

for row = 1:entries
    dataRow = testdata(row, :);
    highestprecision = -1;   % Choose the tree with highest precision when ambiguous
    for treeNo = 1:6
        mark = testSingleTree(trees(treeNo), dataRow);
        if (mark == 1)
            % Multiclass conflict
            if (labelPredictions(row) ~= 0)
                % Multiclass conflict
            
                if (~isfield(trees(treeNo), 'precision'))
                    % Output 8 if precision measurement hasn't been calculated
                    labelPredictions(row) = 8;
                    break
                else
                    if (trees(treeNo).precision > highestprecision)
                        labelPredictions(row) = treeNo;
                        highestprecision = trees(treeNo).precision;
                    elseif (trees(treeNo).precision == highestprecision)
                        if (rand() > 0.5)
                            labelPredictions(row) = treeNo;
                            highestprecision = trees(treeNo).precision;
                        end
                    end
                end
            else
                labelPredictions(row) = treeNo;
                if (isfield(trees(treeNo), 'precision'))
                    highestprecision = trees(treeNo).precision;
                end
            end
        end
    end

    % No positive outputs
    if (labelPredictions(row) == 0)
        if (isfield(trees(treeNo), 'precision'))
            [minPrecision, minIndex] = min([trees.precision]);
            if (minPrecision < NO_POS_THRESHOLD)
                labelPredictions(row) = minIndex;
            else
                labelPredictions(row) = floor(rand() * 6) + 1;
            end
        end
    % Multi-class conflict had occured    
    elseif (labelPredictions(row) == 8)
        labelPredictions(row) = 0;
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