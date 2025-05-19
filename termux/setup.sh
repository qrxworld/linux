#!/bin/sh
SETUP_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# Packages
awk '{print $1}' "$SETUP_DIR/packages.csv" | pkg install -

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
  sv-enable sshd
fi

# Configs
. $SETUP_DIR/copyconfigs.sh

# Git
git config --global init.defaultBranch main
git config --global pull.rebase false
git config --global submodule.recurse true
