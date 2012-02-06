function prune_example(x,y)
    
% x: noSamples x 45 (as returned by loaddata)
% y: noSamples x 1 (as returned by loaddata)

% TREEFIT - t = treefit(X,y) creates a decision tree t for predicting response y
% as a function of predictors X. X is an n-by-m matrix of predictor values. y is
% either a vector of n response values (for regression), or a character array or
% cell array of strings containing n class names (for classification). Either 
% way, t is a binary tree where each non-terminal node is split based on the 
% values of a column of X.
%
% INPUT PARAMETERS
% catidx   - Vector of indices of the columns of X. treefit treats these columns 
%            as unordered categorical values.
% splitmin - A number n such that impure nodes must have n or more observations
%            to be split (default 10).
tree = treefit(x,y,'method','classification','catidx',1:100,'splitmin',1);


% cost = treetest(t,'resubstitution') computes the cost of the tree t using a 
% resubstitution method. t is a decision tree as created by the treefit 
% function. The cost of the tree is the sum over all terminal nodes of the 
% estimated probability of that node times the node's cost. If t is a 
% classification tree, the cost of a node is the sum of the misclassification 
% costs of the observations in that node. If t is a regression tree, the cost of 
% a node is the average squared error over the observations in that node. cost is 
% a vector of cost values for each subtree in the optimal pruning sequence for 
% t. The resubstitution cost is based on the same sample that was used to create 
% the original tree, so it underestimates the likely cost of applying the tree 
% to new data.

% cost = treetest(t,'crossvalidate',X,y) uses 10-fold cross-validation to 
% compute the cost vector. X and y should be the learning sample, which is the 
% sample that was used to fit the tree t. The function partitions the sample 
% into 10 subsamples, chosen randomly but with roughly equal size. For 
% classification trees, the subsamples also have roughly the same class 
% proportions. For each subsample, treetest fits a tree to the remaining data 
% and uses it to predict the subsample. It pools the information from all 
% subsamples to compute the cost for the whole sample.

% OUTPUT
% cost      - the cost of the tree t
% s         - containing the standard error of each cost value
% nodes     - number of terminal nodes for each subtree
% bestLevel - the estimated best level of pruning

[cost, s, nodes, bestLevel ] = treetest(tree, 'cross',        x, y);
[cost2,s2,nodes2,bestLevel2] = treetest(tree, 'resubstitution'    );

% t2 = treeprune(t1,'level',level) takes a decision tree t1 as created by the 
% treefit function, and a pruning level, and returns the decision tree t2 
% pruned to that level. Setting level to 0 means no pruning. Trees are pruned 
% based on an optimal pruning scheme that first prunes branches giving less 
% improvement in error cost.
prunedTree  = treeprune(tree,'level',bestLevel);
prunedTree2 = treeprune(tree,'level',bestLevel2);

[mincost, minloc ] = min(cost);
[mincost2,minloc2] = min(cost2);

plot(nodes,cost,'b-o',nodes(bestLevel+1),cost(bestLevel+1),'rs');
xlabel('Tree size (number of terminal nodes)')
ylabel('Cost')
axis([0 12 0 1])
grid on

figure(2)
plot(nodes2,cost2,'b-o',nodes2(bestLevel2+1),cost2(bestLevel2+1),'rs');
xlabel('Tree size (number of terminal nodes)')
ylabel('Cost')
grid on
axis([0 12 0 1])
