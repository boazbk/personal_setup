#!/bin/bash

# Function to install Homebrew on macOS
install_brew() {
    command -v brew >/dev/null 2>&1 && { echo "Homebrew is already installed"; return; }
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Function to install oh-my-zsh
install_oh_my_zsh() {
    [ -d "$HOME/.oh-my-zsh" ] && { echo "oh-my-zsh is already installed"; return; }
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Function to install zsh-autocompletion
install_zsh_autocompletion() {
    [ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions" ] && { echo "zsh-autocompletion is already installed"; return; }
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

# Function to install eza
install_eza() {
    local OS="$(uname)"
    install_eza_on_mac(){
        command -v eza >/dev/null 2>&1 && { echo "eza is already installed"; return; }
        command -v brew >/dev/null 2>&1 || {
          echo >&2 "Homebrew is not installed. Installing now...";
          /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        }
        brew install eza
    }
    install_eza_on_ubuntu(){
        command -v eza >/dev/null 2>&1 && { echo "eza is already installed"; return; }
        sudo apt update
        sudo apt install -y gpg
        sudo mkdir -p /etc/apt/keyrings
        wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
        echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
        sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
        sudo apt update
        sudo apt install -y eza
    }

    if [ "$OS" == "Darwin" ]; then install_eza_on_mac
    elif [ "$OS" == "Linux" ]; then install_eza_on_ubuntu
    else echo "Unsupported OS: $OS"; exit 1
    fi
}

# Function to install thefuck
# Function to install thefuck
install_thefuck() {
    command -v thefuck >/dev/null 2>&1 && { echo "thefuck is already installed"; return; }
    local OS="$(uname)"
    if [ "$OS" = "Linux" ]; then
        sudo apt-get update && sudo apt-get install -y python3-dev python3-pip python3-setuptools
        sudo pip3 install thefuck
    elif [ "$OS" = "Darwin" ]; then
        brew install thefuck
    fi
}


# Function to install powerlevel10k
install_powerlevel10k() {
    [ -d "${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k" ] && { echo "powerlevel10k is already installed"; return; }
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
}

# Function to install neovim
install_neovim() {
    command -v nvim >/dev/null 2>&1 && { echo "neovim is already installed"; return; }
    local OS="$(uname)"
    if [ "$OS" = "Linux" ]; then
        sudo apt install neovim
    elif [ "$OS" = "Darwin" ]; then
        brew install neovim
    fi
}

# Function to install fzf
install_fzf() {
    command -v fzf >/dev/null 2>&1 && { echo "fzf is already installed"; return; }
    local OS="$(uname)"
    if [ "$OS" = "Linux" ]; then
        sudo apt-get update && sudo apt-get install -y fzf
    elif [ "$OS" = "Darwin" ]; then
        brew install fzf
    fi
}

# Function to install bat
install_bat() {
    command -v bat >/dev/null 2>&1 && { echo "bat is already installed"; return; }
    local OS="$(uname)"
    if [ "$OS" = "Linux" ]; then
        sudo apt-get update && sudo apt-get install -y bat
    elif [ "$OS" = "Darwin" ]; then
        brew install bat
    fi
}

# Function to install htop
install_htop() {
    command -v htop >/dev/null 2>&1 && { echo "htop is already installed"; return; }
    local OS="$(uname)"
    if [ "$OS" = "Linux" ]; then
        sudo apt-get update && sudo apt-get install -y htop
    elif [ "$OS" = "Darwin" ]; then
        brew install htop
    fi
}


# Calls to installation functions
echo "Installing oh my zsh"
install_oh_my_zsh
echo "Installing zsh autocompletion"
install_zsh_autocompletion
echo "Installing eza"
install_eza
echo "Installing powerlevel10k"
install_powerlevel10k
echo "Installing fzf"
install_fzf
echo "Installing bat"
install_bat
echo  "Installing htop"
install_htop
echo "installing neovim"
install_neovim
echo "installing thef"
install_thefuck
