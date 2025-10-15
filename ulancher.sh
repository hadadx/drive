custom0="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['${custom0}']"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${custom0} name 'Launch Ulauncher'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${custom0} command '/usr/bin/ulauncher-toggle'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${custom0} binding '<Super>space'




# ========== 🗼 Tokyo Night Kitty Theme ========== #

# Font
font_family               JetBrainsMono Nerd Font
bold_font                 auto
italic_font               auto
bold_italic_font          auto
font_size                 14.0

# Window
background_opacity        0.88
confirm_os_window_close   0
window_border_width       1px
hide_window_decorations   titlebar-only
repaint_delay             6
input_delay               1

# Colors
foreground #c0caf5
background #1a1b26
cursor     #7aa2f7
url_color  #bb9af7
selection_foreground #1a1b26
selection_background #7aa2f7

# 16 ANSI Colors
color0  #1a1b26
color1  #f7768e
color2  #9ece6a
color3  #e0af68
color4  #7aa2f7
color5  #bb9af7
color6  #7dc4cc
color7  #a9b1d6
color8  #414868
color9  #f7768e
color10 #9ece6a
color11 #e0af68
color12 #7aa2f7
color13 #bb9af7
color14 #7dc4cc
color15 #c0caf5

# Tabs
tab_bar_style             powerline
tab_powerline_style       angled
active_tab_background     #7aa2f7
active_tab_foreground     #1a1b26
inactive_tab_background   #1a1b26
inactive_tab_foreground   #565f89
tab_bar_background        #16161e
tab_separator_color       #7aa2f7

# Cursor
cursor_shape              beam
cursor_blink_interval     0
cursor_stop_blinking_after 0

# Scrolling
scrollback_lines          10000

# Mouse
copy_on_select            yes
strip_trailing_spaces     always

# Performance
sync_to_monitor           no

# Keyboard shortcuts
kitty_mod ctrl+shift
map ctrl+shift+r reload_config
map ctrl+shift+t new_tab
map alt+1 goto_tab 1
map alt+2 goto_tab 2
map alt+3 goto_tab 3
map alt+w close_tab

# Background image (optional)
# background_image ~/.config/kitty/backgrounds/tokyonight.jpg
# background_image_layout scaled
# background_tint 0.4

# Shell
shell /usr/bin/bash


corner_radius 12.0
background_opacity 0.9
border_width 2.0
active_border_color #7aa2f7
inactive_border_color #1a1b26
hide_window_decorations yes
