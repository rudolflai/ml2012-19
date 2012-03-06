% Updates the CBR system. If same case with the same label already exists 
% in the system, increments its typicality. Otherwise, add it to the system
%
% cbr_sys: current CBR system
% solved_case: case with solution

function [ cbr_sys ] = retain( cbr_sys, solved_case )

% find indices of cases with same label as the solved case
ind = find([cbr_sys.solution] == solved_case.solution);

exist = 0;  % flag to check if the case has already existed.

% narrow the scope for checking the existent case.
for i = ind
    if isequal(cbr_sys(i).problem, solved_case.problem)
        cbr_sys(i).typicality = cbr_sys(i).typicality + 1;
        exist = 1;
        break;
    end
end 
    
% if doesn't exist, simply adds it to the end of the CBR system
if ~exist
    cbr_sys = [cbr_sys ; solved_case];
end

end

