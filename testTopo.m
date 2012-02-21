function [result] = testTopo(neuron)
layers = length(neuron);
if (layers > 2 || layers == 0)
    error('layer size is < 2 and >= 1');
end

[x,y] = loaddata('cleandata_students.txt');
[x2,y2] = ANNdata(x,y);

trainingfcn = 'trainlm';
perffcn = 'mse';
learningrate = 0.01;
epochs = 100;
goal = 0;
show = 1;

transferfcn = cell(1,2);
for i=1:layers,
    transferfcn{i} = 'tansig';
end



for i=1:neuron(1),
    
    hiddentopo = zeros(1,layers);
    hiddentopo(1) = i;
    
    if (layers == 2)
        for j=1:neuron(2),
            hiddentopo(2) = j;
            [~,tr,~] = test_network(x2, y2, hiddentopo, ...
					trainingfcn, learningrate, transferfcn, ...
                    perffcn, epochs, goal, show);   
            result(j,i) = tr; 
    
        end
   
    
    else
    [~,tr,~] = test_network(x2, y2, hiddentopo, ...
					trainingfcn, learningrate, transferfcn, ...
                    perffcn, epochs, goal, show);    
    result(i) = tr;                            
    end

    
end
        



end

