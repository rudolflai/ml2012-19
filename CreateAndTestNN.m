function [ cm ] = CreateAndTestNN( tnx, tny, ttx, tty)
%CreateAndTestNN Creates a NN, trains it, runs tests on it and returns a CM

    %Train a NN
    [net,~] = createNetwork(tnx, tny, 26,'trainscg',0.02,{'tansig'},...
        'mse',100,0,5,1);
    
    %Generate CM for this fold
    cm = ConfusionMatrix(tty,testANN(net, ttx));

end
