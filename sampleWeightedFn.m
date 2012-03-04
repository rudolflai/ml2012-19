% xAUs: [1 x 45]
% yAUs: [1 x 45]
% distFn: distance function handle
function [ w ] = sampleWeightedFn( xAUs, yAUs, distFn )

w = 1 / distFn(xAUs, yAUs)^2;

end

