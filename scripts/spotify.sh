#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATH="/usr/local/bin:$PATH:/usr/sbin"

open_spotify() {
  $(open -a Spotify)
}

next_track() {
  $(osascript -e "tell application \"Spotify\" to next track")
}

previous_track() {
  $(osascript -e "tell application \"Spotify\" to previous track")
}

play_pause() {
  $(osascript -e "tell application \"Spotify\" to playpause")
}

play_playlist() {
  playlist_url=$1
  $(osascript -e "tell application \"Spotify\" to play track \"spotify:playlist:$playlist_url\"")
}

play_playlist "39SkDShQClZe351D6Ymjvt"

