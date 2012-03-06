% Returns the case which is closest to new case
% cbr_sys: non-empty cbr_sys system
% newcase: case without a solution

function [ closestcase ] = retrieve( cbr_sys, newcase )

k = 5;
distFn = @getEuclideanDistance;
weightedFn = @euclideanWeightedFn;

matrixAUs = reshape([cbr_sys.problem], length(cbr_sys), 45);
closestcase = kNN(k, [newcase.problem], matrixAUs, [cbr_sys.solution], ...
    distFn, weightedFn, [cbr_sys.typicality]);

end

