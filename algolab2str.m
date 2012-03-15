function [ a ] = algolab2str( b )

switch b
    case 1
          a = 'd-tree';
    case 2
        a = 'NN';
    case 3
        a = 'CBR';
    otherwise
        error('Unknown emotion label: %d',b);
end

end

