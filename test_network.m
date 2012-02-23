function [net, tr] = test_network(examples, targets, hiddenLayerSize, ...
					train_function, learning_rate, trans_function, ...
                    perf_func, no_epoch, no_goal, no_show, testratio)

% Create a Fitting Network
% OUT: NN, training record
% e.g [net,tr] =
% test_network(x2,y2,10,'trainlm',0.02,{'tansig'},'mse',100,0,5)
% -> no. of hidden layers
% -> no. of neurons of hidden layers


% Extract test set and training set
datasize = size(examples,2);
randlogicarr = randperm(datasize);
testsetsize = round(datasize * testratio);
testsetexample = examples(:,randlogicarr(1:testsetsize));
testsetoutput = NNout2labels(targets(:,randlogicarr(1:testsetsize)));
trainingsetexample = examples(:,randlogicarr(:,testsetsize+1:end));
trainingsetoutput = targets(:,randlogicarr(:,testsetsize+1:end));

net = feedforwardnet(hiddenLayerSize);
net = configure(net, trainingsetexample, trainingsetoutput);

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

% train the network
[net, tr] = train(net, trainingsetexample, trainingsetoutput);

% add metrics
tr.totalperf = perform(net,trainingsetoutput,sim(net,trainingsetexample));
netoutput = NNout2labels(sim(net,testsetexample));
CM = ConfusionMatrix(testsetoutput,netoutput);
tr.best_f1 = nanmean(RP2F1(CM2RP(CM)));
end
