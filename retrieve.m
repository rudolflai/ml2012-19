% Returns the case which is closest to new case
% cbr_sys: non-empty cbr_sys system
% newcase: case without a solution

function [ closestcase ] = retrieve( cbr_sys, newcase )

k = 5;
distFn = @getCityBlockDistance;
weightedFn = @euclideanWeightedFn;

matrixAUs = reshape([cbr_sys.problem], 45, length(cbr_sys))';
closestcase = kNN(k, [newcase.problem], matrixAUs, [cbr_sys.solution], ...
    distFn, weightedFn, [cbr_sys.typicality]);

end

