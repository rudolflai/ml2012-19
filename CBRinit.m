% Trains a CBR system
%
% examples: matrix of AUs of size [n x 45]
% targets: vector of labels returned by [n x 1]

function [cbr_sys] = CBRinit (examples, targets)

cbr_sys = cell(size(examples, 1), 1);
%cbr_sys = cbr_create(length(unique(targets)));
for i = 1:size(examples, 1)
    target = targets(i);
    new_case = cbr_new_case(examples(i, :), target);
    
    % Simply attach a new case to the end of the CBR system without
    % checking existent case in the system
    %
    % TODO: Check existent case and deal with it
    cbr_sys{i} = new_case;
    
    % Can be an extension:
    %
    % Adds cases to six different matrix according to their targets
    % having six matrices makes it more efficient to search for an
    % existent case.
    %{
    cbr_sys1 = [];
    cbr_sys2 = [];
    cbr_sys3 = [];
    cbr_sys4 = [];
    cbr_sys5 = [];
    cbr_sys6 = [];
    
    switch target
        case 1
            retain(cbr_sys1, new_case);
        case 2
            retain(cbr_sys2, new_case);
        case 3
            retain(cbr_sys3, new_case);
        case 4
            retain(cbr_sys4, new_case);
        case 5
            retain(cbr_sys5, new_case);
        case 6
            retain(cbr_sys6, new_case);
    end
    %}
end

% For the extension above
%cbr_sys = [cbr_sys1 ; cbr_sys2 ; cbr_sys3 ; cbr_sys4 ; cbr_sys5 ; cbr_sys6];

end