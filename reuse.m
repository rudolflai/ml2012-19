function [ solved ] = reuse ( old_case, new_case )
  solved		  = new_case;
  solved.solution = old_case.solution;
end
