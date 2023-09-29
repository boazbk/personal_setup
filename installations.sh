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
    local OS="$(uname)"
    install_eza_on_mac(){
        command -v brew >/dev/null 2>&1 || { 
      echo >&2 "Homebrew is not installed. Installing now...";
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }
    brew install neovim

    }
    install_eza_on_ubuntu(){
         # Update repositories
    sudo apt update
    # Install gpg
    sudo apt install -y gpg
    # Create the necessary directory
    sudo mkdir -p /etc/apt/keyrings
    # Fetch and add the gpg key
    wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
    # Add the new repository
    echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
    # Set appropriate permissions
    sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
    # Update repositories again
    sudo apt update
    # Install eza
    sudo apt install -y eza

    }

    if [ "$OS" == "Darwin" ]; then install_eza_on_mac
  elif [ "$OS" == "Linux" ]; then install_eza_on_ubuntu
  else echo "Unsupported OS: $OS"; exit 1
  fi
    
}


# Function to install thefuck
install_thefuck() {
  local OS="$(uname)"

  install_thefuck_on_mac() {
    command -v brew >/dev/null 2>&1 || { 
      echo >&2 "Homebrew is not installed. Installing now...";
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }
    brew install thefuck
  }

  install_thefuck_on_ubuntu() {
    sudo apt update
    sudo apt install python3-dev python3-pip python3-setuptools -y
    sudo pip3 install thefuck
  }

  if [ "$OS" == "Darwin" ]; then install_thefuck_on_mac
  elif [ "$OS" == "Linux" ]; then install_thefuck_on_ubuntu
  else echo "Unsupported OS: $OS"; exit 1
  fi
}



# Function to install powerlevel10k
install_powerlevel10k() {
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
}



install_neovim() {
  local OS="$(uname)"

  install_neovim_on_mac() {
    command -v brew >/dev/null 2>&1 || { 
      echo >&2 "Homebrew is not installed. Installing now...";
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }
    brew install neovim
  }

  install_neovim_on_ubuntu() {
    sudo add-apt-repository ppa:neovim-ppa/unstable -y
    sudo apt update
    sudo apt install neovim -y
  }

  if [ "$OS" == "Darwin" ]; then install_neovim_on_mac
  elif [ "$OS" == "Linux" ]; then install_neovim_on_ubuntu
  else echo "Unsupported OS: $OS"; exit 1
  fi
}

install_fzf() {
  local OS="$(uname)"

  install_fzf_on_mac() {
    command -v brew >/dev/null 2>&1 || { 
      echo >&2 "Homebrew is not installed. Installing now...";
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }
    brew install fzf
  }

  install_fzf_on_ubuntu() {
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
  }

  if [ "$OS" == "Darwin" ]; then install_fzf_on_mac
  elif [ "$OS" == "Linux" ]; then install_fzf_on_ubuntu
  else echo "Unsupported OS: $OS"; exit 1
  fi
}

install_bat() {
  local OS="$(uname)"

  install_bat_on_mac() {
    command -v brew >/dev/null 2>&1 || { 
      echo >&2 "Homebrew is not installed. Installing now...";
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }
    brew install bat
  }

  install_bat_on_ubuntu() {
    sudo apt update
    sudo apt install bat -y
  }

  if [ "$OS" == "Darwin" ]; then install_bat_on_mac
  elif [ "$OS" == "Linux" ]; then install_bat_on_ubuntu
  else echo "Unsupported OS: $OS"; exit 1
  fi
}

install_htop() {
  local OS="$(uname)"

  install_htop_on_mac() {
    command -v brew >/dev/null 2>&1 || { 
      echo >&2 "Homebrew is not installed. Installing now...";
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    }
    brew install htop
  }

  install_htop_on_ubuntu() {
    sudo apt update
    sudo apt install htop -y
  }

  if [ "$OS" == "Darwin" ]; then install_htop_on_mac
  elif [ "$OS" == "Linux" ]; then install_htop_on_ubuntu
  else echo "Unsupported OS: $OS"; exit 1
  fi
}







# Install oh-my-zsh, zsh-autocompletion, eza, powerlevel10k, fzf, bat,  htop, neovim
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

