#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATH="/usr/local/bin:$PATH:/usr/sbin"

open_spotify() {
  $(open -a Spotify)
}

next_track() {
  $(osascript -e "tell application \"Spotify\" to next track")
}

prev_track() {
  $(osascript -e "tell application \"Spotify\" to previous track")
}

play_pause() {
  $(osascript -e "tell application \"Spotify\" to playpause")
}

play_playlist() {
  playlist_url=$1
  $(osascript -e "tell application \"Spotify\" to play track \"spotify:playlist:$playlist_url\"")
}

toggle_shuffle() {
  local is_shuffle=$(osascript -e "tell application \"Spotify\" to shuffling")
  if [ "$is_shuffle" = "true" ]
  then
    osascript -e "tell application \"Spotify\" to set shuffling to false"
  else
    osascript -e "tell application \"Spotify\" to set shuffling to true"
  fi
}

toggle_repeat() {
  local is_repeat=$(osascript -e "tell application \"Spotify\" to repeating")
  if [ "$is_repeat" = "true"]
  then
    osascript -e "tell application \"Spotify\" to set repeating to true"
  else
    osascript -e "tell application \"Spotify\" to set repeating to true"
  fi
}

