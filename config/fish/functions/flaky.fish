function __flaky_log --argument-names color msg
  set_color "$color"
  echo -n "[flaky] "
  set_color normal
  echo "$msg"
end

function flaky --description "Rerun a flaky command (test) N times, stop on first failure"
  set max_runs 100
  set start 1

  if test "$argv[1]" = "--runs"
    set max_runs $argv[2]
    set start 3
  end

  set command (echo $argv[$start..] | string join " ")

  for i in (seq 1 $max_runs)
    __flaky_log blue "Run $i/$max_runs"
    eval "$command"
    if test $status -ne 0
      __flaky_log red "Failed on run $i"
      return $status
    end
  end
  __flaky_log blue "All $max_runs have passed successfully"
end
