# ComfyUI Instance Config (TLDR Version)

**What is this?** Config files for this EC2 instance, stored persistently in `/data/instance_config`.

**Related Repo:** Infrastructure (Terraform, main `user_data.sh`, IAM) is managed by the `ComfyUICloud` repository.

---

**First time/New Instance? (Should be automated by `user_data.sh`)**

1.  Ensure `/data` is mounted.
2.  Run: `bash /data/instance_config/setup_homedir.sh`
    *   Copies scripts (`start_comfyui.sh`, etc) to home dir (`~`).
    *   Creates `~/ComfyUI` link -> `/data/ComfyUI`.

---

**How ComfyUI Runs:**

*   Managed by **systemd** via `/etc/systemd/system/comfyui.service`.
*   Starts automatically on boot.
*   **DO NOT** typically run `./start_comfyui.sh` manually (use systemd commands).
*   Access UI via SSM port forward: `http://localhost:8188`

**Common Commands:**

*   `sudo systemctl status comfyui.service` (Check status)
*   `sudo systemctl restart comfyui.service` (Restart after changes)
*   `sudo systemctl stop comfyui.service` (Stop it)
*   `sudo systemctl start comfyui.service` (Start it if stopped)
*   `journalctl -u comfyui.service -n 100 --no-pager` (View last 100 log lines)

**If you edit `/etc/systemd/system/comfyui.service` (use `sudo nano ...`):**
  Run these commands *after saving*:
  1. `sudo systemctl daemon-reload`
  2. `sudo systemctl restart comfyui.service`

---

**Utility Scripts (run from `~`):**

*   `./download_model.sh 'URL' 'subdir'`: Downloads model from URL into `/data/ComfyUI/models/subdir` (e.g., `./download_model.sh '...' 'checkpoints'`).

---

**Where stuff lives:**

*   **This Repo's Files:** `/data/instance_config`
*   **ComfyUI App & Venv:** `/data/ComfyUI`
*   **Models:** `/data/ComfyUI/models/`
*   **Convenience Link:** `~/ComfyUI` points to `/data/ComfyUI`
