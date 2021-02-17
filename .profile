#                    __ _ _      
#   _ __  _ __ ___  / _(_) | ___ 
#  | '_ \| '__/ _ \| |_| | |/ _ \
# _| |_) | | | (_) |  _| | |  __/
#(_) .__/|_|  \___/|_| |_|_|\___|
#  |_|                           
#     Runs on login

## If bashrc exists, run it (by default it doesnt run outside x?)
#[[ -f ~/.bashrc ]] && . ~/.bashrc

## Append ~/.scripts to path
export PATH=$PATH:$HOME/.scripts:$HOME/.local/bin
export EDITOR="nvim"
export TERMINAL="alacritty"
export TERM="alacritty"
export BROWSER="firefox"
export MPD_HOST_NAME="$HOME/.config/mpd/socket"
export XDG_CONFIG_HOME="$HOME/.config"

export LANG="en_SE.UTF-8"
export LC_TIME="sv_SE.UTF-8"
export LC_ALL="en_US.UTF-8"


## If not running X login manager
## If in tty1 run startx, but not if windowmanager is running
#if [[ "$(tty)" = "/dev/tty1" ]]; then
#	pgrep awesome || startx
#fi



export MANGOHUD=1
