function [ arraybyemotion ] = reshapecell( arraybyalgo )
%Rearranges the data in a cell array into one which has a primary index by
%emotion
%   algobyemotion is a 6X10X3 array

arraybyemotion = zeros(6,10,3);

for label=1:6;
    for algo=1:3,
        perfold = arraybyalgo{algo};
        arraybyemotion(label,:,algo) = perfold(:,label);
    end
end

