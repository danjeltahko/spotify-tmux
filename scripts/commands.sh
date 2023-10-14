#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAYLIST_FILE="$CURRENT_DIR/.spotify_playlists"
PATH="/usr/local/bin:$PATH:/usr/sbin"

open_spotify() {
  open -a Spotify
}

next_track() {
  osascript -e "tell application \"Spotify\" to next track"
}

prev_track() {
  osascript -e "tell application \"Spotify\" to previous track"
}

play_pause() {
  osascript -e "tell application \"Spotify\" to playpause"
}

get_url() {
  local id=$1
  local url=$(grep "^$id" "$PLAYLIST_FILE" | cut -d ':' -f 3)
  echo "$url"
}

play_playlist() {
  local playlist_id=$1
  local playlist_url=$(get_url "$playlist_id")
  if [[ ! -z $playlist_url ]]
  then
    $(osascript -e "tell application \"Spotify\" to play track \"spotify:playlist:$playlist_url\"")
  else
    return
  fi
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
    osascript -e "tell application \"Spotify\" to set repeating to false"
  else
    osascript -e "tell application \"Spotify\" to set repeating to true"
  fi
}

