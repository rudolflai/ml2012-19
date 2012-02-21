function [] = plotResult( results, metric )
%PLOTRESULT Summary of this function goes here
%   Detailed explanation goes here

rows = size(results,1);
cols = size(results,2);

[x,y] = meshgrid(1:cols,1:rows);
metricmatrix = reshape([results.(metric)],rows,cols);

figure
plot3(x,y,metricmatrix);
xlabel('Neurons in layer 1');
ylabel('Neurons in layer 2');
grid on;

errormin = min(metricmatrix(:));
% [x y] ==> y neurons in layer 1, x neurons in layer 2
[xmin ymin] = find(metricmatrix == errormin,1);


fprintf('Minimum at Layer 1:%d, Layer 2: %d with %s: %f\n'...
    ,ymin,xmin,metric,errormin);



end

