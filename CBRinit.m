function [cbr] = CBRinit (examples, targets)
  cbr = cbr_create(length(unique(targets)));
  for i = 1:size(examples,1)
    new_case = cbr_new_case(examples(i, :), targets(i, :));
    cbr      = cbr_add(cbr, new_case);
  end
end

function [cbr] = cbr_create (emotion_count)
  cbr.emotion = {};
  for i = 1:emotion_count
    cbr.emotion{i} = struct('label', emolab2str(i), 'cases', [], 'index', []);
  end
end

function [cbr] = cbr_add (cbr, new_case)
  exist = 0;
  for i = 1:length(cbr.emotion)
    if (exist == 1) 
      break;
    end
    for j = 1:length(cbr.emotion{i}.cases)
      if (exist == 1)
        break;
      end;
      current_case = cbr.emotion{i}.cases(j);
      if (isequal(current_case.problem, new_case.problem))
        current_case.typicality = current_case.typicality + 1;
        if (new_case.solution > 0)
          current_case.solution = new_case.solution;
        end;
      end;
      exist = 1;
    end
  end
  if (exist == 0)
    cbr.emotion{new_case.solution}.cases = ... 
      [cbr.emotion{new_case.solution}.cases; new_case];
    cbr.emotion{new_case.solution}.index = ... 
      union(cbr.emotion{new_case.solution}.index, new_case.problem);
  end
end
