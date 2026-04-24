if status is-interactive
  set -gx fish_greeting
  if command -v fastfetch >/dev/null
    fastfetch
  end

  if command -v starship >/dev/null
    starship init fish | source
  end

  fish_vi_key_bindings
end

set --local local_fish_config "$HOME/.config/fish/config.local.fish"
if test -f "$local_fish_config"
  source "$local_fish_config"
end
