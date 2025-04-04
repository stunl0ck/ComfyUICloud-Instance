#!/bin/bash
# Script to set up the home directory from the config repo

echo "Setting up home directory..."
-# CONFIG_DIR="/data/instance_config"
+
+# Determine the directory where this script is located
+SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
+
HOME_DIR="/home/ubuntu"
COMFYUI_DATA_DIR="/data/ComfyUI"

# Copy config files (adjust filenames if needed)
-echo "--> Copying config files..."
-cp "${CONFIG_DIR}/start_comfyui.sh" "${HOME_DIR}/"
-cp "${CONFIG_DIR}/download_model.sh" "${HOME_DIR}/"
-cp "${CONFIG_DIR}/.gitignore" "${HOME_DIR}/" # Optional, useful if you init git in home again
+echo "--> Copying config files from ${SCRIPT_DIR}..."
+cp "${SCRIPT_DIR}/start_comfyui.sh" "${HOME_DIR}/"
+cp "${SCRIPT_DIR}/download_model.sh" "${HOME_DIR}/"
+cp "${SCRIPT_DIR}/.gitignore" "${HOME_DIR}/" # Optional

# Ensure scripts are executable
chmod +x "${HOME_DIR}/start_comfyui.sh"

# ... (rest of the script remains the same) ...
