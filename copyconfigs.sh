#!/bin/sh
SETUP_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# bashrc
SOURCE_LINE="source $SETUP_DIR/dotfiles/.bashrc"
BASHRC_FILE=~/.bashrc
if ! grep -qF "$SOURCE_LINE" "$BASHRC_FILE"; then
  echo "$SOURCE_LINE" >> "$BASHRC_FILE"
  . "$BASHRC_FILE"
fi

# Environment
touch "$HOME/.ENV"
. "$HOME/.ENV"

# Dotfiles
cp "$SETUP_DIR/dotfiles/.inputrc" ~/.inputrc
cp "$SETUP_DIR/dotfiles/.nanorc" ~/.nanorc
cp "$SETUP_DIR/dotfiles/.tmux.conf" ~/.tmux.conf
cp -rT "$SETUP_DIR/dotfiles/.vim" ~/.vim
cp "$SETUP_DIR/dotfiles/.vimrc" ~/.vimrc
