function [ cbr ] = retain( cbr, solvedcase )
%RETAIN Updates the CBR system
%   cbr: current CBR system

exist = 0;

for i = 1:length(cbr.emotion)
    % if the problem is not a subset of the index of the emotion, it is not
    % stored in this cluster. Small heuristic to speed up the search.
    if (sum(ismember(solvedcase.problem, cbr.emotion{i}.index)) ...
            ~= length(solvedcase.problem))
        continue;
    end
    if (exist == 1)
        break;
    end
    for j = 1:length(cbr.emotion{i}.cases)
        current_case = cbr.emotion{i}.cases(j);
        if (isequal(current_case.problem, solvedcase.problem))
            current_case.typicality = current_case.typicality + 1;
            if (solvedcase.solution > 0)
                current_case.solution = solvedcase.solution;
            end
            exist = 1;
            break;
        end
    end
end

if (exist == 0)
    cbr.emotion{solvedcase.solution}.cases = ...
        [cbr.emotion{solvedcase.solution}.cases; solvedcase];
    cbr.emotion{solvedcase.solution}.index = ...
        union(cbr.emotion{solvedcase.solution}.index, solvedcase.problem);
end

end

