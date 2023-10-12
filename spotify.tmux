#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATH="/usr/local/bin:$PATH:/usr/sbin"


get_tmux_option() {
  local option value default
  option="$1"
  default="$2"
  value=$(tmux show-option -gqv "$option")

  if [ -n "$value" ]
  then
    if [ "$value" = "null" ]
    then
      echo ""

    else
      echo "$value"
    fi
  
  else 
    echo "$default"
  fi
}

main() {
  local open_spotify=$(get_tmux_option "@spotifybinding" "s")
  tmux bind-key -T prefix "$open_spotify" run -b "source $CURRENT_DIR/scripts/spotify.sh"
}

main
