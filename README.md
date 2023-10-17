# Spotify Tmux Plugin
Control Spotify directly from your tmux session.

## Installation with Tmux Plugin Manager (TPM)
1. Add the plugin to your tmux.conf:
```bash
set -g @plugin 'danjeltahko/spotify-tmux'
```
2. Press prefix + <kbd>I</kbd> to install the plugin.

## Usage
Once installed, you can use the key binding to control Spotify. By default, the key binding is set to prefix + <kbd>s</kbd>.

You can customize the key binding by setting the @spotifybinding option in your tmux.conf:

```bash
set -g @spotifyprefix "your_preferred_key"
```
For example, to change the key binding to prefix + <kbd>Shift</kbd> + <kbd>s</kbd>, you'd add:

```bash
set -g @spotifyprefix "S"
```
## Requirements
* macOS with the Spotify application installed.
* AppleScript support (osascript command available).
