function [net tr perf] = testTrainFn(trainFn, iter)
[x, y] = loaddata('cleandata_students.txt');
[x2, y2] = ANNdata(x, y);

perf = 0;
%trainFns = {'trainbr', 'traincgb', 'traincgf', 'traincgp', 'trainlm', 'trainscg'};
tic;
for i = 1:iter
    net = feedforwardnet(11, trainFn);

    net.trainParam.showWindow = false;  % Turn off GUI
    net.trainParam.showCommandLine = true; % Turn on CL

    [net tr] = train(net, x2, y2);

    predicted_output = sim(net, x2);
    perf = perf + perform(net, y2, predicted_output);

end
disp(perf/iter);
toc

