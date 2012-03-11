function [ labelPredictions ] = testTrees( trees, testdata )
%Produces a column of predictions by walking through the tree.
%Combines the output of the 6 classifiers
%If precision data is available, use it to determine which output is more
%reliable.

entries = size(testdata, 1);

labelPredictions = zeros(entries, 1);

for row = 1:entries
    dataRow = testdata(row, :);
    currentdepth = -1;
    depths = zeros(6,1);
    for treeNo = 1:6
        [mark depths(treeNo)] = testSingleTree(trees(treeNo), dataRow,0);
        if (mark == 1)
            % Multiclass conflict
            if (labelPredictions(row) ~= 0)
                if(currentdepth>depths(treeNo))
                    currentdepth=depths(treeNo);
                    labelPredictions(row) = treeNo;
                elseif (currentdepth==depths(treeNo)&&...
                     (trees(labelPredictions(row)).depth...
                            >trees(treeNo).depth))
                        labelPredictions(row) = treeNo;
                end
            else
                labelPredictions(row) = treeNo;
                currentdepth = depths(treeNo);
            end
        end
    end

    % No positive outputs
    if (labelPredictions(row) == 0)
        [v labelPredictions(row)] = min(depths);
    end
end
end

function [ decision, depth ] = testSingleTree ( tree ,dataRow,depth )
%walks through the tree to find if its a positive or not

%if no children, must be leaf therefore decision should be made
    if(size(tree.kids)==0)
        decision = tree.class;
    else
        depth=depth+1;
        if(dataRow(tree.op))
            [decision depth] = testSingleTree(tree.kids{2},dataRow,depth);
        else
            [decision depth] = testSingleTree(tree.kids{1},dataRow,depth);
        end
    end
end