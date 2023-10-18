#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLAYLIST_FILE="$CURRENT_DIR/.spotify_playlists"
PATH="/usr/local/bin:$PATH:/usr/sbin"

source "$CURRENT_DIR/helpers.sh"

open_spotify() {
  open -a Spotify
}

next_track() {
  tell_spotify "next track"
}

prev_track() {
  tell_spotify "previous track"
}

play_pause() {
  tell_spotify "playpause"
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
    tell_spotify "play track \"spotify:playlist:$playlist_url\""
  else
    return
  fi
}

toggle_shuffle() {
  local is_shuffle=$(tell_spotify "shuffling")
  if [[ "$is_shuffle" = "true" ]]
  then
    tell_spotify "set shuffling to false"
  else
    tell_spotify "set shuffling to true"
  fi
}

toggle_repeat() {
  local is_repeat=$(tell_spotify "repeating")
  if [[ "$is_repeat" = "true" ]]
  then
    tell_spotify "set repeating to false"
  else
    tell_spotify "set repeating to true"
  fi
}

