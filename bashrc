#  _               _              
# | |__   __ _ ___| |__  _ __ ___ 
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__ 
# |_.__/ \__,_|___/_| |_|_|  \___|
  
[[ $- != *i* ]] && return
PS1='[\u@\h \W]\$ '

# Define Editor
export EDITOR=nvim

export GSETTINGS_BACKEND=memory

# -----------------------------------------------------
# SSH and remote access
# -----------------------------------------------------
host='Redd'

if [ "$(hostname)" == "REDD" ]; then
    PEER='mav204@100.71.49.39'
elif [ "$(hostname)" == "BLU" ]; then
    PEER='mav204@100.95.8.21'
else
    echo "Unknown host: $(hostname)"
fi

# Start the ssh agent
eval "$(ssh-agent -s)"

# -----------------------------------------------------
# Sync and SSH
# -----------------------------------------------------
alias sync='rsync -az --delete --progress ~/sync $PEER:~/'
alias sync-pull='rsync -az --delete --progress $PEER:~/sync ~/'
alias peer-conn="ssh $PEER"
alias sync-bak='name=".bak/$(date +"%d-%b-%y_%IH:%MM:%SS")"; mk -p $name && cd $HOME && rsync -avz --progress ~/sync $name'
alias git-key-start='ssh-add ~/sync/.ssh-keys/git-key'

# -----------------------------------------------------
# ALIASES
# -----------------------------------------------------
alias c='clear'
alias nf='fastfetch'
alias lf='fastfetch -c ~/dotfiles/fastfetch/long.jsonc'
alias ff-img='fastfetch -c ~/dotfiles/fastfetch/main.jsonc --kitty-direct ~/dotfiles/fastfetch/arcowolinux.png --logo-height 25 --logo-width 50'
alias ff='fastfetch -c ~/dotfiles/fastfetch/main.jsonc -l ~/dotfiles/fastfetch/charizard_sm'
alias ls='eza --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias shutdown='systemctl poweroff'
alias v='$EDITOR'
alias vi='$EDITOR'
alias e='exit'
alias q='exit'
alias update='sudo pacman -Syu --noconfirm && yay -Syu --noconfirm'
alias install='sudo pacman -S --noconfirm'
alias uninstall='sudo pacman -Rns --noconfirm'
alias mk='mkdir'
alias mkx='f() { touch "$1" && chmod +x "$1"; }; f'
alias sudo='sudo-rs'

# -----------------------------------------------------
# File Shortcuts
# -----------------------------------------------------
alias dl-f='cd $HOME/Downloads && c && source ~/.bashrc'
alias doc-f='cd $HOME/Documents && c && source ~/.bashrc'
alias dot-bind='vi /home/mav204/dotfiles/hypr/conf/bind/default.conf'
alias h='cd && c && source ~/.bashrc'
alias bashrc='v ~/.bashrc'
alias sync-f='cd ~/sync'
alias dot="cd ~/dotfiles"
alias auto-start='v ~/dotfiles/hypr/conf/autostart/default.conf'
#alias thunar='GTK_THEME=Tokyonight-Dark-Storm thunar'

# -----------------------------------------------------
# wifi and networks
# -----------------------------------------------------
alias get-public-ip='curl ifconfig.me'
alias get-ip='ifconfig wlo1 | grep "inet " | awk "{print \$2}"'
alias wifi='nmcli'
alias wifi-scan='nmcli device wifi list'
alias wifi-conn-new='nmcli device wifi connect --ask'
alias wifi-disconn='nmcli con down --ask'
alias wifi-del='nmccpli connection delete --ask'
alias wifi-show='nmcli connection show'
alias wifi-on='nmcli radio wifi on && nmcli radio wifi'
alias wifi-off='nmcli radio wifi off && nmcli radio wifi'
alias wifi-conn='nmcli con up --ask'

# -----------------------------------------------------
# bluetooth
# -----------------------------------------------------
alias bt='bluetoothctl'
alias cmf-conn='bluetoothctl connect 3C:B0:ED:C1:30:1B'
alias sapphire-conn='bluetoothctl connect 40:DE:24:69:3F:F8'
alias bt-dev='bluetoothctl devices'
alias bt-on='bluetoothctl power on'
alias bt-off='bluetoothctl power off'

# -----------------------------------------------------
# hypr-commands
# -----------------------------------------------------
alias figletcp='~/dotfiles/hypr/scripts/figlet'
alias set-pf='~/dotfiles/hypr/scripts/set-profile-picture'
alias set-wp='~/dotfiles/hypr/scripts/set-wallpaper'
alias idle-on="~/dotfiles/hypr/scripts/idle-toggle 1"
alias idle-off="~/dotfiles/hypr/scripts/idle-toggle 0"
alias cava-clock="~/dotfiles/hypr/scripts/cava-clock"
alias dnd="swaync-client -d"

# -----------------------------------------------------
# START STARSHIP
# -----------------------------------------------------
eval "$(starship init bash)"

# -----------------------------------------------------
# PYWAL
# -----------------------------------------------------
cat ~/.cache/wal/sequences

# -----------------------------------------------------
# Fastfetch if on wm
# -----------------------------------------------------
if [[ $(tty) == *"pts"* ]]; then
    if [[ $TERM == "xterm-kitty" ]]; then
        ff-img
    elif [[ $TERM == "alacritty" ]]; then
        ff
    else
        echo "Running Terminal: $TERM"
        sleep 2
        clear
    fi
fi

# Created by `pipx` on 2025-06-13 15:51:34
export PATH="$PATH:/home/mav204/.local/bin"
