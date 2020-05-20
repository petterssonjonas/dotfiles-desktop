# Remove greeting
set fish_greeting

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
#set -g theme_powerline_fonts no
#set -g theme_nerd_fonts yes
### Make right side of prompt powerline as well
#
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
alias ....="cd ../../"
alias ls="lsd --color=auto"
alias grep="grep --color=auto"
alias sudp="sudo"

# Use Powerline prompt
#set fish_function_path $fish_function_path "/usr/share/powerline/bindings/fish"
#source /usr/share/powerline/bindings/fish/powerline-setup.fish
#powerline-setup

#Quicklfix for st del key
tput smkx


#neofetch
paleofetch
