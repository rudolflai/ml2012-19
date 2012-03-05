function [ solved ] = reuse ( old_case, new_case )
%REUSE Attach the solution of closestcase to newcase and returns
%solvedcase
  solved		  = new_case;
  solved.solution = old_case.solution;
end
