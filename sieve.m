function [ outrow ] = sieve( attribute, value, inrow)
    if inrow(attribute) == value
        outrow = inrow;
    else
        outrow = [];
    end
end