#!/usr/bin/env bash
# install_ulauncher_super_space.sh
# Ubuntu GNOME (Xorg): Install Ulauncher, bind Super+Space, and enable autostart.

set -euo pipefail

log() { printf "\n[INFO] %s\n" "$*"; }
ok()  { printf "[OK] %s\n" "$*"; }
warn(){ printf "[WARN] %s\n" "$*"; }
err() { printf "[ERR] %s\n" "$*"; }

if [[ $EUID -eq 0 ]]; then
  err "Do NOT run as root. Run as your regular user."
  exit 1
fi

log "Updating apt and installing prerequisites"
sudo apt update
sudo dnf install -y software-properties-common

log "Adding Universe + Ulauncher PPA and installing Ulauncher"
sudo add-apt-repository -y universe
sudo add-apt-repository -y ppa:agornostal/ulauncher
sudo apt update
sudo apt install -y ulauncher

log "Enabling autostart for Ulauncher"
mkdir -p ~/.config/autostart
if [[ -f /usr/share/applications/ulauncher.desktop ]]; then
  cp -f /usr/share/applications/ulauncher.desktop ~/.config/autostart/
else
  cat > ~/.config/autostart/ulauncher.desktop <<'DESK'
[Desktop Entry]
Type=Application
Name=Ulauncher
Exec=ulauncher --hide-window
X-GNOME-Autostart-enabled=true
Terminal=false
Categories=Utility;
DESK
fi
ok "Autostart entry created at ~/.config/autostart/ulauncher.desktop"

log "Freeing Super+Space from input switching (GNOME)"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"

if gsettings list-schemas | grep -q org.freedesktop.ibus.general.hotkey; then
  log "Clearing IBus triggers that may grab Super+Space"
  gsettings set org.freedesktop.ibus.general.hotkey triggers "[]"
fi

log "Creating custom keybinding: Super+Space -> ulauncher-toggle"
BASE="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"
KEY="$BASE/ulauncher/"
LIST="$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings)"

if [[ "$LIST" == "@as []" || "$LIST" == "[]" ]]; then
  NEW="['$KEY']"
else
  NEW="$(LIST="$LIST" python3 - "$KEY" <<'PY'
import ast, os, sys
k = sys.argv[1]
s = os.environ["LIST"]
arr = [] if s in ("@as []","[]") else ast.literal_eval(s)
if k not in arr:
    arr.append(k)
print(str(arr).replace('"',"'"))
PY
)"
fi
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$NEW"

gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY name 'Ulauncher'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY command 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY binding '<Super>space'

ok "Keybinding set."

log "Current status:"
echo -n "custom-keybindings: "
gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings
echo -n "name: "
gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY name
echo -n "command: "
gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY command
echo -n "binding: "
gsettings get org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$KEY binding

cat <<'TIP'

Done.

If you're on GNOME Xorg:
  1) Press Alt+F2, type: r , hit Enter (restart GNOME Shell)
  2) Ensure Ulauncher is running (it should autostart; you can also run "ulauncher &")
  3) Test Super+Space from any window

If it doesn't trigger:
  - Check for extensions that might intercept the shortcut (e.g., tiling extensions). Temporarily disable and retest:
      gnome-extensions list --enabled
      gnome-extensions disable <extension-uuid>
      Alt+F2 -> r -> Enter
  - Verify the key event arrives:
      xev -event keyboard   (look for Mod4 + space)
TIP


