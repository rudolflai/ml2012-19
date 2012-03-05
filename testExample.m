function [ y, updatedcbr ] = testExample( cbr, x )
%EDITCBR Produces a vector of label predictions y in the format of loaddata
%   cbr: trained CBR
%   x: a vector of features
%   y: predicted output

newcase = cbr_new_case (x, 0);
solvedcase = reuse(retrieve(cbr, newcase), newcase);
updatedcbr = retain(cbr, solvedcase);
y = solvedcase.solution;

end

