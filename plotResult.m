function [] = plotResult( results, metric )
%PLOTRESULT Summary of this function goes here
%   Detailed explanation goes here

rows = size(results,1);
cols = size(results,2);

[x,y] = meshgrid(1:cols,1:rows)

plot3(x,y,reshape([results.(metric)],rows,cols));
xlabel('Neurons in layer 1');
ylabel('Neurons in layer 2');
grid on;

end

