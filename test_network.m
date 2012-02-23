function [net, tr] = test_network(examples, targets, hiddenLayerSize, ...
					train_function, learning_rate, trans_function, ...
                    perf_func, no_epoch, no_goal, no_show)

% Create a Fitting Network
% OUT: NN, training record
% e.g [net,tr] =
% test_network(x2,y2,10,'trainlm',0.02,{'tansig'},'mse',100,0,5)
% -> no. of hidden layers
% -> no. of neurons of hidden layers
net             = feedforwardnet(hiddenLayerSize);
net             = configure(net, examples, targets);

% -> training functions
net.trainFcn    = train_function;  % Levenberg-Marquardt

% -> learning rate
net.trainParam.lr 		= learning_rate;
% -> transfer functions

for i=1:size(trans_function),
    net.layers{i}.transferFcn = trans_function{i};
end

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = perf_func;  % Mean squared error


% Maximum number of epochs to train
net.trainParam.epochs = no_epoch;
% Performance goal
net.trainParam.goal 	= no_goal;
% Epochs between displays (NaN for no displays)
net.trainParam.show 	= no_show;
% Initial mu
% net.trainParam.mu 		= 0.001;

% Hide training GUI 
net.trainParam.showWindow = false;
% Hide show on console 
net.trainParam.showCommandLine = true;

[net, tr] = train(net, examples, targets);
tr.totalperf = perform(net,targets,sim(net,examples));

testexamples = examples(:,tr.testInd);
expectedoutput = NNout2labels(targets(:,tr.testInd));
testoutput = NNout2labels(sim(net,testexamples));
CM = ConfusionMatrix(expectedoutput,testoutput);
tr.best_f1 = nanmean(RP2F1(CM2RP(CM)));
end
