function y = NNout2labels(x)

%NNOUT2LABELS - transforms the output of a NN to a 1 column label representation
%
% AUTHOR:	M.F. Valstar
% CREATED:	02102006
%
%IN:  x: the output of a NN
%OUT: y: a one-column label representation

[v I] = max(x);
y = I';