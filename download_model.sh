#!/bin/bash

# Script to download a model into the correct ComfyUI subdirectory.

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <download_url> <target_subdirectory>"
    echo "  Example: $0 'URL_HERE' checkpoints"
    echo "  (Target subdirectory is relative to /data/ComfyUI/models)"
    exit 1
fi

DOWNLOAD_URL="$1"
TARGET_SUBDIR="$2"
BASE_MODEL_DIR="/data/ComfyUI/models"
TARGET_DIR="${BASE_MODEL_DIR}/${TARGET_SUBDIR}"

# Ensure target directory exists
echo "--> Checking/Creating directory: ${TARGET_DIR}"
mkdir -p "${TARGET_DIR}"
if [ $? -ne 0 ]; then
    echo "Error: Failed to create directory ${TARGET_DIR}"
    exit 1
fi

# Try to extract filename from content-disposition in URL
FILENAME=$(echo "${DOWNLOAD_URL}" | grep -o 'filename="[^"]*"' | sed -e 's/filename="//' -e 's/"$//')

# Fallback: get filename from the end of the URL path if the above failed
if [ -z "${FILENAME}" ]; then
    echo "--> Could not extract filename from content-disposition, trying basename..."
    FILENAME=$(basename "${DOWNLOAD_URL%%\?*}")
fi

# Decode potential URL encoding in the filename
if command -v python3 &> /dev/null; then
    # Use python to handle decoding robustly
    FILENAME=$(python3 -c "import sys, urllib.parse; print(urllib.parse.unquote(sys.argv[1]))" "${FILENAME}")
else
    echo "Warning: python3 not found for full filename URL decoding."
fi

# Final check if filename is valid
if [ -z "${FILENAME}" ] || [[ "${FILENAME}" == *"="* ]] || [[ "${FILENAME}" == *"%"* ]]; then
    echo "Error: Could not determine a valid filename from URL: ${DOWNLOAD_URL}"
    echo "       (Extracted name: '${FILENAME}')"
    echo "       Please download manually or check the URL."
    exit 1
fi

TARGET_FILE_PATH="${TARGET_DIR}/${FILENAME}"

echo "--> Attempting download:"
echo "      URL: [REDACTED - Use argument]"
echo "      To:  ${TARGET_FILE_PATH}"

# Download using wget, -c resumes, --progress shows bar, --trust-server-names helps sometimes
wget -O "${TARGET_FILE_PATH}" -c --progress=bar:force --trust-server-names "${DOWNLOAD_URL}"

# Check download status
if [ $? -eq 0 ]; then
    echo "--> Download successful: ${FILENAME}"
else
    echo "Error: Download failed for URL."
    # Optional: remove partial file: rm -f "${TARGET_FILE_PATH}"
    exit 1
fi

exit 0 