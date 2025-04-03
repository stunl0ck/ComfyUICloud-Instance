"# ComfyUI Cloud Instance Config

Simple setup files for the EC2 instance.

- `start_comfyui.sh`: Script to launch ComfyUI.
- Requires ComfyUI installed in `/data/ComfyUI`
- Requires SSM port forwarding to access `http://localhost:8188`

---

**Persistent Configuration:**

The config files (this README, start scripts, `.git` history) are stored persistently in `/data/instance_config`.

On a new instance boot (after `/data` is mounted), run:
`bash /data/instance_config/setup_homedir.sh`

This script copies the necessary files (`start_comfyui.sh`, etc.) to `/home/ubuntu` and creates the `~/ComfyUI -> /data/ComfyUI` symlink."
