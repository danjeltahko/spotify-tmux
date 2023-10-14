#!/usr/bin/env bash
CURRENT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
PLAYLIST_FILE="$CURRENT_DIR/.spotify_playlists"

show_list() {
  [ -f "$PLAYLIST_FILE" ] || return
  while IFS=":" read -r key name id;
  do
    echo "$key:$name";
  done < "$PLAYLIST_FILE"
}

get_id() {
  local url=$1
  local id=$(echo "$url" | sed -n 's|^https://open\.spotify\.com/playlist/\([^?]*\).*|\1|p')
  echo "$id"
}

add_playlist() {
  while true;
  do
    echo -n "Enter Spotify playlist: "
    read url
    local playlist_id=$(get_id "$url")
  
    if [ ! -z $playlist_id ]
    then
      echo -n "Playlist name : "
      read playlist_name

      show_list
      echo -n ":"
      read -r selected_key
    
      # Check if the key is valid
      if ! [[ "$selected_key" =~ ^[1-9]$ ]];
      then
        return
      fi
      # Remove the line with the selected key if it exists
      sed -i.bak "/^$selected_key:/d" "$PLAYLIST_FILE"

      # Append new playlist entry
      echo "$selected_key:$playlist_name:$playlist_id" >> "$PLAYLIST_FILE"

      # Sort the file by key
      sort -o "$PLAYLIST_FILE" "$PLAYLIST_FILE"
     
      # Close window if inside tmux
      tmux kill-window
      exit 0
    
    else
      return
    fi
  done
}
