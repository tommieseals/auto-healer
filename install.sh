#!/bin/bash
# Auto-Healer Installer

set -e

INSTALL_DIR="/usr/local/bin"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/auto-healer"

echo "Installing Auto-Healer..."

# Create config directory
mkdir -p "$CONFIG_DIR"

# Install script
if [ -w "$INSTALL_DIR" ]; then
    cp auto-healer "$INSTALL_DIR/auto-healer"
    chmod +x "$INSTALL_DIR/auto-healer"
else
    sudo cp auto-healer "$INSTALL_DIR/auto-healer"
    sudo chmod +x "$INSTALL_DIR/auto-healer"
fi

# Copy example config if no config exists
if [ ! -f "$CONFIG_DIR/config.yaml" ]; then
    cp configs/config.yaml.example "$CONFIG_DIR/config.yaml"
    echo "Created config at $CONFIG_DIR/config.yaml"
    echo "Edit this file to configure your services!"
fi

echo "Installed! Run: auto-healer check"

