function [ tree depth ] = makeTree( samples, attributes, targets, depth )
	  	
%MAKETREE Creates the decision tree
%   samples: the matrix of AUs activation
%   attributes: the list of AUs yet to be used for learning
%   targets: the list of remapped labels (1s/0s)
	  	
	  
depths(1) = depth+1;
depths(2) = depth+1;
	  	
if all(targets)
	  	
    tree = makeLeafNode(1);
	  	
elseif ~any(targets)
	  	
    tree = makeLeafNode(0);
	  	
elseif isempty(attributes)
	  	
    tree = makeLeafNode(majorityValue(targets));
	  	
else
	
    bestattribute = best_attribute(samples, attributes, targets);
	  	
    tree = makeBranchNode(bestattribute);    
    
    for val=0:1,
	  	
        index = samples(:,bestattribute) == val;
	  	
        childsamples = samples(index,:);
	  	
        childtargets = targets(index);
	  	
        if isempty(childsamples)
            tree.kids{val + 1} = makeLeafNode(majorityValue(targets));  	
        else
            [tree.kids{val + 1} depths(val+1)] = makeTree(childsamples, ...
                attributes(attributes~=bestattribute), childtargets,depth+1);
        end
	  	
    end
	  	
end
depth = max(depths);
end
	  	

	  	
function [ node ] = makeLeafNode( label )
	  	
    node.class = label;
	  	
    node.kids = [];
	  	
    node.op = [];
	  	
end
	  	

	  	
function [ node ] = makeBranchNode( attribute )
	  	
    node.class = [];
	  	
    node.kids = cell(1,2);
	  	
    node.op = attribute;
	  	
end
	  	
