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

set_playlist_keybindings() {
  for i in 1 2 3 4 5 6 7 8 9
  do 
    tmux bind-key -T skt "$i" run -b "source $CURRENT_DIR/scripts/commands.sh && play_playlist $i"
  done
}

main() {

  # Spotify Prefix - Default <prefix> + S
  local spotify_prefix=$(get_tmux_option "@spotifyprefix" "S")
  # Spotify Commands
  local spotify_open=$(get_tmux_option "@spotify-open" "o")
  local spotify_shuffle=$(get_tmux_option "@spotify-shuffle" "s")
  local spotify_repeat=$(get_tmux_option "@spotify-repeat" "r")
  local spotify_playpause=$(get_tmux_option "@spotify-playpause" "p")
  local spotify_next=$(get_tmux_option "@spotify-next" "l")
  local spotify_prev=$(get_tmux_option "@spotify-prev" "h")
  # Spotify playlists
  local playlist_add=$(get_tmux_option "@spotify-add-playlist" "a")
  # Spotify key table (skt)
  tmux bind-key -T prefix "$spotify_prefix" switch-client -T skt
  # Regular commands
  tmux bind-key -T skt "$spotify_open" run -b "source $CURRENT_DIR/scripts/commands.sh && open_spotify"
  tmux bind-key -T skt "$spotify_shuffle" run -b "source $CURRENT_DIR/scripts/commands.sh && toggle_shuffle"
  tmux bind-key -T skt "$spotify_repeat" run -b "source $CURRENT_DIR/scripts/commands.sh && toggle_repeat"
  tmux bind-key -T skt "$spotify_playpause" run -b "source $CURRENT_DIR/scripts/commands.sh && play_pause"
  tmux bind-key -T skt "$spotify_next" run -b "source $CURRENT_DIR/scripts/commands.sh && next_track"
  tmux bind-key -T skt "$spotify_prev" run -b "source $CURRENT_DIR/scripts/commands.sh && prev_track"
  # Playlist commands
  tmux bind-key -T skt "$playlist_add" run -b "tmux neww 'source $CURRENT_DIR/scripts/playlist.sh && add_playlist'"
  set_playlist_keybindings
}

main
