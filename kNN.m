% Returns the estimated emotion label using k-Nearest Neighbour.
% When ambiguous, returns a list of estimated labels.
%
% xAUs: [1 x 45]
% matrixAUs: [n x 45]
% labels: [n x 1]
% typicalites: [n x 1]

function [ closestCase, estimatedLabel ] = kNN( k, xAUs, matrixAUs, ...
    labels, distFn, weightedFn, typicalities )

estimatedLabel = 7; % 7 indicates neutral in emolab2str.m

% find out the nearest neighbours
nrows = size(matrixAUs, 1);
distind = zeros(nrows, 2);  % rows of [distance, rowindex]

for i = 1:nrows
    d = distFn(xAUs, matrixAUs(i, :));
    distind(i, :) = [d i];
end

% sorts the rows in distind w.r.t. the first column, i.e. distance
distind = sortrows(distind); 

kNNind = distind(1:k, 2);
kNNAUs = matrixAUs(kNNind, :);
kNNLabels = labels(kNNind);

% estimate the nearest label using weightedFn
maxDistWeight = 0;

for i = 1:6
    inds = find(kNNLabels == i);
    if ~isempty(inds)
        sum = 0;    % sum of weight for each class
        for j = inds
            sum = sum + weightedFn(xAUs, kNNAUs(j, :)) * typicalities(j);
        end
        if sum > maxDistWeight
            maxDistWeight = sum;
            estimatedLabel = i;
        elseif sum == maxDistWeight
            if estimatedLabel == 7
                estimatedLabel = i;
            else
                estimatedLabel = [estimatedLabel i];
            end
        end
    end
end
    
% Randomise if ambiguous
if length(estimatedLabel) ~= 1
    estimatedLabel = estimatedLabel(ceil(rand()*length(estimatedLabel)));
end

inds = find(kNNLabels == estimatedLabel);
ind = inds(1);
closestCase = struct('problem', matrixAUs(ind), 'solution', labels(ind),...
    'typicality', typicalities(ind));

end