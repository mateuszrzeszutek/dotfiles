if status is-interactive
  if command -v starship >/dev/null
    starship init fish | source
  end
  fish_vi_key_bindings
end
