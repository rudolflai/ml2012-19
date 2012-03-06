% Returns a newly created case structure.
%
% example: list of 45 AUs
% target: emotion label
% typicality: no. of time a case has been seen in the system

function [ new_case ] = cbr_new_case (example, target)

new_case = struct('problem', example, 'solution', target, 'typicality', 1);

end