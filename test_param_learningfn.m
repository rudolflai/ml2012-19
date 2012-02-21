[x, y] = loaddata('cleandata_students.txt');
[x2, y2] = ANNdata(x, y);

hiddenlayer_sizes = [5 5];
%{
train	Train neural network
trainb	Batch training with weight and bias learning rules
trainbfg	BFGS quasi-Newton backpropagation
trainbfgc	BFGS quasi-Newton backpropagation for use with NN model reference adaptive controller
trainbr	Bayesian regulation backpropagation
trainbu	Batch unsupervised weight/bias training
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
trainru	Unsupervised random order weight/bias training
trains	Sequential order incremental training with learning functions
trainscg	Scaled conjugate gradient backpropagation
%}
training_fn = 'traingdm';

learning_rates= [0.05:0.05:1];
mus = [0.001:0.001:0.02];
performances = zeros(1, 20);

trainInds = [1:70];
valInds = [71:85];
testInds = [86:100];

for i = 1:20
    net = feedforwardnet(hiddenlayer_sizes, training_fn);
    net.trainParam.lr = learning_rates(i);
    net.trainParam.mu = mus(i);
    net.divideFcn = 'divideind';
    net.divideParam.trainInd = trainInds;
    net.divideParam.valInd = valInds;
    net.divideParam.testInd = testInds;
    % tr: training record
    [net, tr] = train(net, x2, y2);
    predicted_output = sim(net, x2);
    performances(i) = perform(net, y2, predicted_output);
end
disp(performances);
plot(learning_rates, performances);