[examples, targets] = loaddata('cleandata_students.txt');
[ann_exp,  ann_tar] = ANNdata(examples, targets);

P = 0:0.01:1;
T = sin(-pi/2 + P * 3 * pi);

% Create a Fitting Network
hiddenLayerSize = 5;
net             = feedforwardnet(hiddenLayerSize);
net             = configure(net, P, T);

net.trainParam.epochs = 100;
net = train(net, P, T);
Y = sim(net, P);
plot(P, T, P, Y, 'r.');

