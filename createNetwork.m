function [ net ,tr ] = createNetwork( uexamples, utargets, hiddenLayerSize, ...
					train_function, learning_rate, trans_function, ...
                    perf_func, no_epoch, no_goal, no_show)
%CREATENETWORK Creates  a trained network WITH LOADDATA FORMAT uexamples and utargets 
%OUT: NN, training record, outputs from all data
% e.g [net,tr,Y] =
% creatNetwork(x,y,10,'trainlm',0.02,{'tansig'},'mse',100,0,5)
% -> no of hidden layers
% -> no. of neurons of hidden layers
[examples targets] = ANNdata(uexamples,utargets);

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

[net, tr] = train(net, examples, targets);

end

