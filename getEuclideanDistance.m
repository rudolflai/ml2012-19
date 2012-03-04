% xAUs, yAUs and weights should be of the same size.
function [ d ] = getEuclideanDistance( xAUs, yAUs )

d = sqrt(sum((xAUs - yAUs).^2));

end

