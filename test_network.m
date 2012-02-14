function [net, Y] = test_network(examples, targets, hiddenLayerSize, ...
																	train_function, learning_rate, perf_func, ...
																	no_epoch, no_goal, no_show)

% Create a Fitting Network
% -> no. of hidden layers
% -> no. of neurons of hidden layers
net             = feedforwardnet(hiddenLayerSize);
net             = configure(net, examples, targets);

% -> learning rate
net.trainParam.lr 		= learning_rate;
% -> transfer functions
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'tansig';
% -> training functions
net.trainFcn    = train_function;  % Levenberg-Marquardt

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = perf_func;  % Mean squared error

% Epochs between displays (NaN for no displays)
net.trainParam.show 	= no_show;
% Maximum number of epochs to train
net.trainParam.epochs = no_epoch;
% Performance goal
net.trainParam.goal 	= no_goal;
% Initial mu
% net.trainParam.mu 		= 0.001;

net = train(net, examples, targets);
Y   = sim(net, examples);

end
