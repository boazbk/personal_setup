#!/bin/zsh

# Function to check if a command exists
command_exists () {
    command -v "$1" >/dev/null 2>&1
}

# Check for the "eza" utility
if command_exists eza; then
    echo "'eza' is already installed!"
else
    echo "'eza' is not installed. Attempting to install now..."

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

    if command_exists eza; then
        echo "'eza' installed successfully!"
    else
        echo "Failed to install 'eza'. Please check if it's available in your package manager or install manually."
    fi
fi
