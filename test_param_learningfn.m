% e.g. test_param_learningfn([10 10], 'trainlm', zeros(1,10), [0.1:0.1:1], zeros(1,10), [1:70], [71:85], [86:100], 10)

function [performances] = test_param_learningfn(hiddenlayer_sizes, training_fn, ...
    learning_rates, mus, momentums, trainInds, valInds, testInds, perfSize)

[x, y] = loaddata('cleandata_students.txt');
[x2, y2] = ANNdata(x, y);

%{
trainb	Batch training with weight and bias learning rules
trainbfg	BFGS quasi-Newton backpropagation
trainbfgc	BFGS quasi-Newton backpropagation for use with NN model reference adaptive controller
trainbr	Bayesian regulation backpropagation
x trainbu	Batch unsupervised weight/bias training
trainc	Cyclical order weight/bias training
traincgb	Conjugate gradient backpropagation with Powell-Beale restarts
traincgf	Conjugate gradient backpropagation with Fletcher-Reeves updates
traincgp	Conjugate gradient backpropagation with Polak-Ribiére updates
traingd	Gradient descent backpropagation
traingda	Gradient descent with adaptive learning rate backpropagation
traingdm	Gradient descent with momentum backpropagation
traingdx	Gradient descent with momentum and adaptive learning rate backpropagation
trainlm	Levenberg-Marquardt backpropagation
trainoss	One-step secant backpropagation
trainr	Random order incremental training with learning functions
trainrp	Resilient backpropagation
x trainru	Unsupervised random order weight/bias training
trains	Sequential order incremental training with learning functions
trainscg	Scaled conjugate gradient backpropagation
%}

performances = zeros(1, perfSize);

for i = 1:perfSize
    net = feedforwardnet(hiddenlayer_sizes, training_fn);
    
    % TODO: Set transfer function for each layer in the network
    
    net.trainParam.showWindow = 0;  % Turn off GUI
    net.trainParam.showCommandLine = 1; % Turn on CL
    
    % Assign params
    net.trainParam.lr = learning_rates(i);
    net.trainParam.mu = mus(i);
    net.trainParam.mc = momentums(i);
    
    % divideind gives the same set of training, validation and testing data
    net.divideFcn = 'divideind';
    net.divideParam.trainInd = trainInds;
    net.divideParam.valInd = valInds;
    net.divideParam.testInd = testInds;
    
    net = train(net, x2, y2);
    predicted_output = sim(net, x2);
    
    % perform() by default uses "mean square error (mse)"
    performances(i) = perform(net, y2, predicted_output);
end

% Plot the related param against performance.
plot(1:perfSize, performances);