function __venv_dir
  if git rev-parse --show-toplevel 2>/dev/null
    set dir (git rev-parse --show-toplevel)
  else
    set dir (pwd)
  end

  for v in venv .venv virtualenv
    if test -e "$dir/$v/bin/activate.fish"
      echo "$dir/$v"
      break
    end
  end
end 

function __venv_log --argument-names msg
  set_color blue
  echo -n "[venv] "
  set_color normal
  echo "$msg"
end

function venv --argument-names cmd --description "Activate or deactivate Python virtualenv"
  switch "$cmd"
    case on
      set venv_dir (__venv_dir)
      if test -e "$venv_dir/bin/activate.fish"
        if test -n "$VIRTUAL_ENV"
          __venv_log "already active"
        else
          source "$venv_dir/bin/activate.fish"
          __venv_log "activated"
        end
      else
        __venv_log "not a python virtualenv project"
        return 1
      end
    case off
      if test -n "$VIRTUAL_ENV"
        deactivate
        __venv_log "deactivated"
      end
    case "*"
      __venv_log "usage: venv (on|off)"
      return 1
  end
end
