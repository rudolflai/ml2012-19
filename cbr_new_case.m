function [ new_case ] = cbr_new_case (example, target)
  new_case = struct('problem', find(example(1,:)), 'solution', target, 'typicality', 1);
end
