#!/bin/bash
# 🧠 הגדרת קיצור Super+Space לפתיחת Ulauncher ב-GNOME

# מסלול לקיצור במערכת ההגדרות
custom0="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"

# מוסיף את הקיצור לרשימת הקיצורים המוגדרים
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['${custom0}']"

# הגדרות הקיצור
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${custom0} name 'Launch Ulauncher'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${custom0} command 'ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${custom0} binding '<Super>space'

echo "✅ Ulauncher הוגדר לפעול עם Super+Space"


