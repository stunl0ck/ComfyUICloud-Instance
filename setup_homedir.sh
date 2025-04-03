#!/bin/bash
# Script to set up the home directory from the persistent config

echo "Setting up home directory..."
CONFIG_DIR="/data/instance_config"
HOME_DIR="/home/ubuntu"
COMFYUI_DATA_DIR="/data/ComfyUI"

# Copy config files (adjust filenames if needed)
echo "--> Copying config files..."
cp "${CONFIG_DIR}/start_comfyui.sh" "${HOME_DIR}/"
cp "${CONFIG_DIR}/download_model.sh" "${HOME_DIR}/"
cp "${CONFIG_DIR}/.gitignore" "${HOME_DIR}/" # Optional, useful if you init git in home again
# Add any other files you want copied here

# Ensure scripts are executable
chmod +x "${HOME_DIR}/start_comfyui.sh"
chmod +x "${HOME_DIR}/download_model.sh"

# Create ComfyUI symlink (if it doesn't exist)
echo "--> Setting up ComfyUI symlink..."
if [ ! -L "${HOME_DIR}/ComfyUI" ]; then
  ln -s "${COMFYUI_DATA_DIR}" "${HOME_DIR}/ComfyUI"
  echo "    Symlink created."
else
  echo "    Symlink already exists."
fi

echo "Home directory setup complete." 