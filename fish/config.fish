# Remove greeting
set fish_greeting
function fish_right_prompt; end

# Theme settings
# using bobthefish
set -g theme_color_scheme gruvbox
set -g theme_use_abbreviated_path no
set -g theme_title_use_abbreviated_path no
set -g theme_use_abbreviated_branch_name no
set -g theme_title_display_path no
set -g fish_prompt_pwd_dir_length 0
set -g theme_display_hostname ssh
set -g theme_display_user ssh
set -g theme_title_display_process yes
set -g theme_title_display_path yes
set -g theme_title_display_user no
set -g theme_title_use_abbreviated_path no
set -g theme_date_timezone Europe/Stockholm
set -g theme_date_format "+%a %H:%M:%S"
#set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes


# Paths
set PATH $HOME/.local/bin $PATH
set XDG_CONFIG_HOME $HOME/.config
set EDITOR nvim
set VISUAL st -e nvim
set MYNVIMRC $HOME/.config/nvim/init.vim

# Aliases
alias vi="nvim"
alias vim="nvim"
alias nvim="nvim"
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias sudp="sudo"
alias weather="curl wttr.in"
alias yay="yay --color=auto"

# Color all the things
alias ls="lsd --color=auto"
alias grep="grep --color=auto"
alias ip="ip --color=auto"
alias diff="diff --color=auto"
alias dmesg="dmesg --color=always"


# Color for less (and man)
#
set -xU LESS_TERMCAP_md (printf "\e[01;31m")
set -xU LESS_TERMCAP_me (printf "\e[0m")
set -xU LESS_TERMCAP_se (printf "\e[0m")
set -xU LESS_TERMCAP_so (printf "\e[01;44;33m")
set -xU LESS_TERMCAP_ue (printf "\e[0m")
set -xU LESS_TERMCAP_us (printf "\e[01;32m")

# Use Powerline prompt
#set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
#source /usr/share/powerline/bindings/fish/powerline-setup.fish
#powerline-setup

# Quicklfix for st del key
#tput smkx

#neofetch
#paleofetch
