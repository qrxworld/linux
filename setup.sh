#!/bin/sh
SETUP_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# Packages
awk '{print $1}' "$SETUP_DIR/packages.csv" | sudo pacman -S --needed -

# Touchpad
sudo touch /etc/X11/xorg.conf.d/30-touchpad.conf
sudo tee /etc/X11/xorg.conf.d/30-touchpad.conf << 'EOF'
Section "InputClass"
    Identifier "touchpad"
    Driver "libinput"
    MatchIsTouchpad "on"
    Option "Tapping" "on"
    Option "TapButton2" "2"  # Two-finger tap for right-click
    Option "TapButton3" "3"  # Three-finger tap for middle-click
EndSection
EOF

# Display
cp $SETUP_DIR/dotfiles/.Xresources ~
xrdb -merge ~/.Xresources

# Configs, fonts, emojis
cp -r $SETUP_DIR/dotfiles/.config ~
source ~/.bashrc
fc-cache -fv

# Ensure .xinitrc exists and is executable
if [ ! -f "$HOME/.xinitrc" ]; then
  echo "exec i3" | sudo tee "$HOME/.xinitrc" > /dev/null
  chmod +x "$HOME/.xinitrc"
  chown "$USERNAME:$USERNAME" "$HOME/.xinitrc"
fi

# SSH
lines=(
  "PubkeyAuthentication yes"
  "PasswordAuthentication no"
  "ChallengeResponseAuthentication no"
)
sshfile="/etc/ssh/sshd_config"
hasAddedLine=0

for line in "${lines[@]}"; do
  # Use awk with -v to pass the variable safely
  if ! awk -v l="$line" '$0 == l {found=1} END{exit !found}' "$sshfile"; then
    echo "Adding '$line' to $sshfile"
    echo "$line" | sudo tee -a "$sshfile" > /dev/null
    hasAddedLine=1
  fi
done

if [ "$hasAddedLine" -eq 1 ]; then
  sudo systemctl start sshd
  sudo systemctl enable sshd
  sudo systemctl restart sshd
fi

# Firewall
# only allows local home connections
# TODO use a manifest of IPs to harden it even more
if ! command -v ufw >/dev/null; then
  sudo pacman -S ufw
  sudo systemctl enable ufw
  sudo systemctl start ufw

  sudo ufw enable
  sudo ufw default deny incoming
  sudo ufw default allow outgoing
  # SSH
  sudo ufw allow from 10.0.0.0/24 to any port 22
  # Local dev
  sudo ufw allow from 10.0.0.0/24 to any port 8000 
  # Local dev (alt)
  sudo ufw allow from 10.0.0.0/24 to any port 8001
  # kiwix server
  sudo ufw allow from 10.0.0.0/24 to any port 8080
  # ollama
  sudo ufw allow from 10.0.0.0/24 to any port 11434
fi

# Permissions
sudo usermod -aG video $USER

# Configs
. $SETUP_DIR/copyconfigs.sh

# Git
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global submodule.recurse true
git config --global credential.helper /usr/lib/git-core/git-credential-libsecret

# AUR Helper (yay) and Brave Browser
if ! command -v yay >/dev/null; then
  echo "Installing yay AUR helper..."
  
  # Install prerequisites for building yay
  sudo pacman -S --needed base-devel git
  
  # Clone yay repository
  cd /tmp
  git clone https://aur.archlinux.org/yay.git
  cd yay
  
  # Build and install yay
  makepkg -si --noconfirm
  
  # Clean up
  cd /
  rm -rf /tmp/yay
  
  echo "yay installed successfully"
fi

# Install Brave Browser using yay
if ! command -v brave >/dev/null; then
  echo "Installing Brave Browser..."
  yay -S --noconfirm brave-bin
  echo "Brave Browser installed successfully"
fi

## Large Language Models
if ! command -v ollama >/dev/null; then
  curl -fsSL 'https://ollama.com/install.sh' | sh
  ollama pull 'hf.co/unsloth/qwen3-0.6b-gguf:q4_k_m'
  #ollama pull 'hf.co/unsloth/Qwen3-1.7B-GGUF:Q4_K_M'
  #ollama pull 'hf.co/unsloth/Qwen3-4B-GGUF:Q4_K_M'
  #ollama pull 'hf.co/unsloth/Qwen3-30B-A3B-GGUF:Q4_K_M'
fi
export OLLAMA_MODELS="/home/shared/.ollama/models"
