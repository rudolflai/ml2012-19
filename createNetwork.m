function [ resultnet ,tr ] = createNetwork( uexamples, utargets, hiddenLayerSize, ...
					train_function, learning_rate, trans_function, ...
                    perf_func, no_epoch, no_goal, no_show,single)
%CREATENETWORK Creates a trained network WITH LOADDATA FORMAT uexamples and utargets 
% If single is set to 1, it will create 6 single output trees in a cell
% array
%OUT: NN, training record, outputs from all data
% e.g [net,tr,Y] =
% createNetwork(x,y,10,'trainlm',0.02,{'tansig'},'mse',100,0,5,0)
% -> no of hidden layers
% -> no. of neurons of hidden layers
[examples targets] = ANNdata(uexamples,utargets);
repeat = 1;
if(single)
    repeat = 6;
end

netHolder = cell(repeat,1);
for emotion=1:repeat

    net             = feedforwardnet(hiddenLayerSize);
    if(single)
        net             = configure(net, examples, targets(emotion,:));
    else
        net             = configure(net, examples, targets);
    end
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
    if (single)
        [net, tr] = train(net, examples, targets(emotion,:));
    else
        [net, tr] = train(net, examples, targets);
    end
    netHolder{emotion} = net;
end

if(repeat==1)
    resultnet = netHolder{repeat};
else
    resultnet = netHolder;
end
    
end

