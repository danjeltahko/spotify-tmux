tell_spotify() {
  local arg=$1
  osascript -e "tell application \"Spotify\" to $arg"
}

get_tmux_option() {
  local option="$1"
  local default="$2"
  local value=$(tmux show-option -gqv "$option")

  if [ -z "$value" ]
  then
    echo "$default"
  else
    echo "$value"
  fi
}

