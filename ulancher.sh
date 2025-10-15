custom0="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['${custom0}']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${custom0} name 'Launch Ulauncher'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${custom0} command '/usr/bin/ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${custom0} binding '<Super>space'
