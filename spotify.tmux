#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PATH="/usr/local/bin:$PATH:/usr/sbin"
source "$CURRENT_DIR/scripts/helpers.sh"

spotify_interpolation=(
	"\#{spotify_track}"
	"\#{spotify_artist}"
  "\#{spotify_album}"
  "\#{spotify_state}"
)

spotify_commands=(
	"#($CURRENT_DIR/scripts/show_track.sh)"
	"#($CURRENT_DIR/scripts/show_artist.sh)"
  "#($CURRENT_DIR/scripts/show_album.sh)"
  "#($CURRENT_DIR/scripts/show_state.sh)"
)

set_tmux_option() {
	local option="$1"
	local value="$2"
	tmux set-option -gq "$option" "$value"
}

do_interpolation() {
	local all_interpolated="$1"
	for ((i=0; i<${#spotify_commands[@]}; i++)); do
		all_interpolated=${all_interpolated//${spotify_interpolation[$i]}/${spotify_commands[$i]}}
	done
	echo "$all_interpolated"
}

update_tmux_option() {
	local option="$1"
	local option_value="$(get_tmux_option "$option")"
	local new_option_value="$(do_interpolation "$option_value")"
	set_tmux_option "$option" "$new_option_value"
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
  
  update_tmux_option "status-right"
	update_tmux_option "status-left"
}

main
