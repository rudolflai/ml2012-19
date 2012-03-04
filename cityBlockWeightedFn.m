function [ w ] = cityBlockWeightedFn( xAUs, yAUs )
%CITYBLOCKWEIGHTEDFN 
% xAUs: [1 x 45]
% yAUs: [1 x 45]
% distFn: distance function handle
w = 1 / getCityBlockDistance(xAUs, yAUs)^2;

end

