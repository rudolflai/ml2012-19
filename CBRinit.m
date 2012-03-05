function [cbr] = CBRinit (examples, targets)
%CBRINIT Trains a CBR system
%   examples: matrix of AUs returned by the loaddata
%   targets: vector of labels returned by loaddata

  cbr = cbr_create(length(unique(targets)));
  for i = 1:size(examples,1)
    new_case = cbr_new_case(examples(i, :), targets(i, :));
    cbr      = retain(cbr, new_case);
  end
end

function [cbr] = cbr_create (emotion_count)
  cbr.emotion = {};
  for i = 1:emotion_count
    cbr.emotion{i} = struct('label', emolab2str(i), 'cases', [], 'index', []);
  end
end


