#!/bin/bash
# Script to set up the home directory from the config repo

echo "Setting up home directory..."

# Determine the directory where this script is located
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

HOME_DIR="/home/ubuntu"
COMFYUI_DATA_DIR="/data/ComfyUI"

# Copy config files (adjust filenames if needed)
echo "--> Copying config files from ${SCRIPT_DIR}..."
cp "${SCRIPT_DIR}/start_comfyui.sh" "${HOME_DIR}/"
cp "${SCRIPT_DIR}/download_model.sh" "${HOME_DIR}/"
cp "${SCRIPT_DIR}/.gitignore" "${HOME_DIR}/" # Optional

# Ensure scripts are executable
chmod +x "${HOME_DIR}/start_comfyui.sh"
chmod +x "${HOME_DIR}/download_model.sh" # <-- Make sure this one is executable too!

# Create ComfyUI symlink (if it doesn't exist)
echo "--> Setting up ComfyUI symlink..."
if [ ! -L "${HOME_DIR}/ComfyUI" ]; then
  ln -s "${COMFYUI_DATA_DIR}" "${HOME_DIR}/ComfyUI"
  echo "    Symlink created."
else
  echo "    Symlink already exists."
fi

echo "Home directory setup complete."