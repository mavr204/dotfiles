#!/bin/bash

set -e  # Exit on error (optional, but good for installers)

dot_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function back_dot() {
    read -p "Do you want to back up your dotfiles? [y/n]: " ch
    if [[ "$ch" =~ ^[Yy]$ ]]; then
        echo "Backing up existing dotfiles..."
        rsync -az --delete --progress "$HOME/dotfiles" "$HOME/dotfiles.bak"
    else
        echo "Skipping backup."
    fi
}

function link_dotfile() {
    local target="$1"
    local link="$2"

    if [[ -e "$link" || -L "$link" ]]; then
        echo "Removing existing: $link"
        rm -rf "$link"
    fi

    ln -s "$target" "$link"
    echo "Linked: $link -> $target"
}

# === package installation steps ===

sudo pacman -Syu && yay -Syu
sudo pacman -S --noconfirm alacritty cava fastfetch hyprland starship neovim wofi waybar swaync hyprlock hyprcursor hyprpaper git nautilus rsync kitty figlet hypridle imagemagick eza brightnessctl libnotify pavucontrol bluez bluez-utils blueman pipewire pipewire-pulse pipewire-alsa wireplumber alsa-utils playerctl gnome-keyring ufw seahorse tailscale ssh kdeconnect lutris python3 jdk-openjdk gcc vlc git thunar ffmpegthumbnailer poppler-glib libopenraw less lib32-mesa
sudo systemctl enable --now ufw
sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw allow 20/tcp
sudo ufw allow 1714:1764/udp
sudo ufw allow 1714:1764/tcp

sudo systemctl enable --now sshd
sudo systemctl enable --now tailscaled

# Install yay (AUR helper)
git clone https://aur.archlinux.org/yay-git.git
cd yay-git
#makepkg -si --noconfirm
cd ..
rm -rf yay-git

yay -S --noconfirm clock-rs-git hyprsysteminfo hypragentpolkit pywal-16 wlogout hyprshade vscode auto-cpufreq pacseek spotify

yay -Sy --noconfirm brave-bin

# === Backup existing dotfiles if present ===
if [[ -d "$HOME/dotfiles" ]]; then
    back_dot
fi

echo "Installer running from: $dot_dir"

# === Copy this script directory into ~/dotfiles ===
if [ "$dot_dir" != "$HOME" ]; then
    mkdir -p "$HOME/dotfiles"
    rsync -az --delete "$script_dir/" "$HOME/dotfiles/"
fi

# === Symlinks ===
# Clean existing configs and create new links
link_dotfile "$HOME/dotfiles/alacritty" "$HOME/.config/alacritty"
link_dotfile "$HOME/dotfiles/kitty" "$HOME/.config/kitty"
link_dotfile "$HOME/dotfiles/cava" "$HOME/.config/cava"
link_dotfile "$HOME/dotfiles/clock-rs" "$HOME/.config/clock-rs"
link_dotfile "$HOME/dotfiles/fastfetch" "$HOME/.config/fastfetch"
link_dotfile "$HOME/dotfiles/hypr" "$HOME/.config/hypr"
link_dotfile "$HOME/dotfiles/swaync" "$HOME/.config/swaync"
link_dotfile "$HOME/dotfiles/waybar" "$HOME/.config/waybar"
link_dotfile "$HOME/dotfiles/wofi" "$HOME/.config/wofi"
link_dotfile "$HOME/dotfiles/wlogout" "$HOME/.config/wlogout"
link_dotfile "$HOME/dotfiles/vim" "$HOME/.config/vim"
link_dotfile "$HOME/dotfiles/nvim" "$HOME/.config/nvim"
link_dotfile "$HOME/dotfiles/starship/starship.toml" "$HOME/.config/starship.toml"
link_dotfile "$HOME/dotfiles/wal" "$HOME/.config/wal"
link_dotfile "$HOME/dotfiles/GTK/gtk-4.0" "$HOME/.config/gtk-4.0"
link_dotfile "$HOME/dotfiles/GTK/gtk-3.0" "$HOME/.config/gtk-3.0"
link_dotfile "$HOME/dotfiles/bashrc" "$HOME/.bashrc"
link_dotfile "$HOME/dotfiles/GTK/GTK-Themes" "$HOME/.themes"
link_dotfile "$HOME/dotfiles/GTK/icons" "$HOME/.icons"

mkdir -p "$HOME/.cache"
mkdir -p "$HOME/.local/share"
link_dotfile "$HOME/dotfiles/hypr/wal-cache" "$HOME/.cache/wal"
link_dotfile "$HOME/dotfiles/fonts" "$HOME/.local/share/fonts"

mkdir -p "$HOME/sync/{Documents,Downloads}"

# Prepare sync-folder
if [[ -d "$HOME/Documents" ]]; then
    rm -rf "$HOME/Documents"
fi

if [[ -d "$HOME/Downloads/dl-sync" ]]; then
    rm -rf "$HOME/dl-sync"
fi

ln -s "$HOME/sync/Documents" "$HOME/Documents"
ln -s "$HOME/sync/Downloads" "$HOME/Downloads/dl-sync"

# Lid Action Setter
su root
mkdir /etc/systemd/logind.conf.d
ln -s /home/mav204/dotfiles/hypr/conf/lid-action.conf /etc/systemd/logind.conf.d/lid-action.conf
ln -s /home/mav204/dotfiles/hypr/scripts/set-lid-action /usr/local/bin/set-lid-action
echo "HandleLidSwitch=ignore" > /etc/systemd/logind.conf.d/lid-action.conf
echo "HandleLidSwitchExternalPower=ignore" > /etc/systemd/logind.conf.d/lid-action.conf
echo "HandleLidSwitchDocked=ignore" > /etc/systemd/logind.conf.d/lid-action.conf

# Reboot
echo "All done!"

read -p "Do you want to restart now? [y/n]: " choice

if [[ "$choice" =~ ^[Yy]$ ]]; then
    systemctl reboot
else
    echo "Skipping reboot."
fi

