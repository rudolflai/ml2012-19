function [ accuracy ] = testTopo( neuronsperlayer, examples, targets )
%TESTTOPO Takes an integer array configuration of the neural network and
%   outputs the test error
%   INPUT: an array configuration of the hidden layers in the neural
%   network. eg. [10,15] means two hidden layers, the first with 10 neurons
%   and the second with 15 neurons
%
%   OUTPUT: mean squared error from best iteration of the neural network



net = feedforwardnet(neuronsperlayer);
net = configure(net, examples, targets);
net.trainParam.epoch = 100;
net = train(net, examples, targets);
output = sim(net, examples);

perform(net,

end

