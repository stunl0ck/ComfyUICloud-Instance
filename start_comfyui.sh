#!/bin/bash
# Simple script to start ComfyUI

echo \"Starting ComfyUI...\"
cd /data/ComfyUI || exit 1
source venv/bin/activate
python main.py --listen
echo \"ComfyUI stopped.\"
