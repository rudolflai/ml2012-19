function [ ] = visualizeneurons( neurons, trials, metric )
%VISUALIZENEURONS Summary of this function goes here
%   Detailed explanation goes here

[x,y] = loaddata('cleandata_students.txt');
[x2,y2] = ANNdata(x,y);

trainingfcn = 'trainlm';
perffcn = 'mse';
learningrate = 0.01;
epochs = 100;
goal = 0;
show = 1;

transferfcn = {'tansig'};

result = zeros(epochs,trials);
enum = zeros(epochs,trials);

for i=1:trials,
    
    [~,tr] = test_network(x2, y2, neurons, ...
					trainingfcn, learningrate, transferfcn, ...
                    perffcn, epochs, goal, show);    
    result(1:tr.num_epochs+1,i) = tr.(metric);                 
    enum(1:tr.num_epochs+1,i) = tr.epoch;
end

enum
result

figure
plot(enum,result);
    

end

