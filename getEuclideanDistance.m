function [ d ] = getEuclideanDistance( xAUs, yAUs )

d = sqrt(sum((xAUs - yAUs).^2));

end

