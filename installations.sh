#!/bin/bash

# Function to install Homebrew on macOS
install_brew() {
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

# Function to install oh-my-zsh
install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
}

# Function to install zsh-autocompletion
install_zsh_autocompletion() {
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
}

# Function to install eza
install_eza() {
    brew install eza || ./eza-install.sh
}

# Function to install powerlevel10k
install_powerlevel10k() {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
}

# Function to install fzf
install_fzf() {
    brew install fzf || sudo apt-get install fzf -y
}

# Function to install bat
install_bat() {
    brew install bat || sudo apt-get install bat -y
}


# Function to install thef
install_thef() {
    brew install thefuck || pip install thefuck --user
}

install_neovim() {
  # Detect the OS
  local OS="$(uname)"

  install_on_mac() {
    # Check if Homebrew is installed
    command -v brew >/dev/null 2>&1 || { 
      echo >&2 "Homebrew is not installed. Installing now...";
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }

    # Install Neovim using Homebrew
    brew install neovim
  }

  install_on_ubuntu() {
    # Add the Neovim PPA
    sudo add-apt-repository ppa:neovim-ppa/unstable -y

    # Update the package list
    sudo apt update
    
    # Install Neovim
    sudo apt install neovim -y
  }

  # Install Neovim based on the OS
  if [ "$OS" == "Darwin" ]; then
    install_on_mac
  elif [ "$OS" == "Linux" ]; then
    # Assuming Ubuntu here, modify as needed for other Linux distributions
    install_on_ubuntu
  else
    echo "Unsupported operating system: $OS"
    exit 1
  fi
}

# Function to install htop
install_htop() {
    brew install htop || sudo apt-get install htop -y
}

# Determine OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "Detected macOS..."
    # Check if Homebrew is installed, if not, install it
    command -v brew >/dev/null 2>&1 || {
        echo "Homebrew not found. Installing..."
        install_brew
    }
else
    echo "Detected Linux..."
fi

# Install oh-my-zsh, zsh-autocompletion, eza, powerlevel10k, fzf, bat, and htop
install_oh_my_zsh
install_zsh_autocompletion
install_eza
install_powerlevel10k
install_fzf
install_bat
install_htop
install_neovim

