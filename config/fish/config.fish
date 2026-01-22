if status is-interactive
  set -fx fish_greeting
  if command -v fastfetch >/dev/null
    fastfetch
  end

  if command -v starship >/dev/null
    starship init fish | source
  end

  fish_vi_key_bindings
end
