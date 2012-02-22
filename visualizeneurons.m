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

figure
set(gca,'XLim',[0 40]);
set(gca,'YLim',[0 0.8]);
title(['With ' int2str(neurons) ' neurons'])
hold on

for i=1:trials,
    
    [~,tr] = test_network(x2, y2, neurons, ...
					trainingfcn, learningrate, transferfcn, ...
                    perffcn, epochs, goal, show);    
                
   plot(tr.epoch,tr.(metric),'DisplayName',['Trial' int2str(i)]);
                
end
    
hold off

end

