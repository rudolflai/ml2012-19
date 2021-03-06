[examples, targets] = loaddata('cleandata_students.txt');
[ann_exp,  ann_tar] = ANNdata(examples, targets);

% Create a Fitting Network
% -> no. of hidden layers
% -> no. of neurons of hidden layers
hiddenLayerSize = [6, 6];
net             = feedforwardnet(hiddenLayerSize);
net             = configure(net, ann_exp, ann_tar);

% -> learning rate
net.trainParam.lr 		= 0.001;
% -> transfer functions
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'tansig';
net.layers{3}.transferFcn = 'tansig';
% -> training functions
net.trainFcn    = 'trainscg';  % Levenberg-Marquardt

% Choose a Performance Function
% For a list of all performance functions type: help nnperformance
net.performFcn = 'mse';  % Mean squared error

% Epochs between displays (NaN for no displays)
net.trainParam.show 	= 25;
% Maximum number of epochs to train
net.trainParam.epochs = 100;
% Performance goal
net.trainParam.goal 	= 0;
% Initial mu
% net.trainParam.mu 		= 0.001;
% Learning rate

net = train(net, ann_exp, ann_tar);
Y = sim(net, ann_exp);
% plot(P, T, P, Y, 'r.');


