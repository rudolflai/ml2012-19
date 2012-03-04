function [ w ] = chebWeightedFn( xAUs, yAUs )
%CHEBWEIGHTEDFN % xAUs: [1 x 45]
% yAUs: [1 x 45]
% distFn: distance function handle

w = 1 / getChebyshevDistance(xAUs, yAUs)^2;

end

