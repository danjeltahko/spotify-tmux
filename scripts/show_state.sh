#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source "$CURRENT_DIR/helpers.sh"

show_spotify_state() {
  local spotify_shuffle_icon=$(get_tmux_option "@spotify-shuffle-icon" "󰒟")
  local spotify_playing_icon=$(get_tmux_option "@spotify-playing-icon" "󰝚")
  local spotify_repeat_icon=$(get_tmux_option "@spotify-repeat-icon" "󰕇")
  if [[ $(tell_spotify "running") = "true" ]]
  then
    if [[ $(tell_spotify "player state") = "playing" ]]
    then
      if [[ $(tell_spotify "repeating") = "true" ]]
      then
        echo "$spotify_repeat_icon "
      elif [[ $(tell_spotify "shuffling") = "true" ]]
      then
        echo "$spotify_shuffle_icon "
      else
        echo "$spotify_playing_icon "
      fi
    fi
  fi
}
show_spotify_state$@
