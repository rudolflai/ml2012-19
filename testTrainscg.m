function [ net, performances ] = testTrainscg( sigmas, lambdas )
%TESTTRAINSCG Summary of this function goes here
%   Detailed explanation goes here
[x, y] = loaddata('cleandata_students.txt');
[x2, y2] = ANNdata(x, y);

rounds = 2;

randInds = randperm(100);
trainInds = randInds(1:70);
valInds = randInds(71:85);
testInds = randInds(86:100);

rangeSize = length(sigmas);
performances = zeros(1, rangeSize);
f1s = zeros(1, rangeSize);

for m = 1:rounds
    for i = 1:rangeSize
        net = feedforwardnet(11, 'trainscg');
        
        for j = 1:length(11)
            net.layers{j}.transferFcn = 'tansig';
        end
        
        net.trainParam.epochs = 500;

        net.trainParam.showWindow = 0;  % Turn off GUI
        net.trainParam.showCommandLine = 1; % Turn on CL

        % Assign params
        net.trainParam.sigma = sigmas(i);
        net.trainParam.lambda = lambdas(i);

        % divideind gives the same set of training, validation and testing data
        net.divideFcn = 'divideind';
        net.divideParam.trainInd = trainInds;
        net.divideParam.valInd = valInds;
        net.divideParam.testInd = testInds;

        net = train(net, x2, y2);
        %predicted_output = sim(net, x2);
        
        
        %[net, tr] = train(net, x2, y2);
        predicted_output = sim(net, x2);
        %tr.totalperf = perform(net,y2,predicted_output);
        testexamples = x2(:,testInds);
        expectedoutput = NNout2labels(y2(:,testInds));
        testoutput = NNout2labels(sim(net,testexamples));
        CM = ConfusionMatrix(expectedoutput,testoutput);
        %tr.best_f1 = nanmean(RP2F1(CM2RP(CM)));      
        
        f1s(i) = f1s(i) + nanmean(RP2F1(CM2RP(CM)));

        % perform() by default uses "mean square error (mse)"
        performances(i) = performances(i) + perform(net, y2, predicted_output);
    end
end
plot(sigmas, performances/rounds);
end

