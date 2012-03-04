function [ d ] = getCityBlockDistance( xAUs, yAUs )

d = sum(abs(xAUs - yAUs));

end

