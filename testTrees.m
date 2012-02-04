function [ labelPredictions ] = testTrees( trees, testdata )
%Produces a column of predictions by walking through the tree.
entries = size(testdata,1);
%create a matrix wth allocated space
labelPredictions = zeros(entries,6);
for row=1:entries
    dataRow=testdata(row,:);
    for treeNo=1:6
        mark = testSingleTree ( trees(treeNo) , dataRow);
        labelPredictions(row,treeNo) = mark;
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