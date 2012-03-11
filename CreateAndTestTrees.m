function [ cm ] = CreateAndTestTrees( tnx, tny, ttx, tty)
%CreateAndTestNN Creates a tree, trains it, runs tests on it and returns a CM

    %Train a NN
    trees = createAllTrees(tnx,tny);

    
    %Generate CM for this fold
    cm = ConfusionMatrix(tty,testTrees(trees, ttx));

end
