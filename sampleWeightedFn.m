% xAUs: [1 x 45]
% yAUs: [1 x 45]
% distFn: distance function handle
function [ w ] = sampleWeightedFn( xAUs, yAUs )

w = 1 / getEuclideanDistance(xAUs, yAUs)^2;

end

