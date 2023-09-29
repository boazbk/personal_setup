#!/bin/bash

# Exit on error
set -e

# Check if nvim is installed
command -v nvim >/dev/null 2>&1 || { echo >&2 "Neovim is not installed. Aborting."; exit 1; }

# Create necessary directories
mkdir -p ~/.config/nvim/plugged

# Install vim-plug
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy the initial configuration file
cp init.vim ~/.config/nvim/init.vim

# Install plugins
nvim +PlugInstall +qall

# Install fzf
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install
