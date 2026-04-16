function __notify --argument-names app title content
  if test "$(uname)" = "Linux"
    notify-send -a "$app" "$title" "$content"
  else if test "$(uname)" = "Darwin"
    osascript -e "display notification \"$content\" with title \"$title\""
  end
end

function n --description "Notify about the command's success or failure"
  set app_name $argv[1]
  set command (echo $argv | string join " ")
  eval "$command"\
    && __notify $app_name "✅ Success" "$command"\
    || __notify $app_name "❌ Failure" "$command"
end
