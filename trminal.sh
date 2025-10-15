PS1='\[\e[38;2;51;204;255m\]\$ \[\e[0m\]'




PS1='\[\e[38;2;189;147;249m\]\u@\h\[\e[0m\]:\[\e[38;2;139;233;253m\]\w\[\e[0m\]\[\e[38;2;255;121;198m\] \$ \[\e[0m\]'


# 🗼 Tokyo Night Theme for Hyprland

# Colors
$background = rgb(26,27,38)    # #1a1b26
$foreground = rgb(192,202,245) # #c0caf5
$accent     = rgb(122,162,247) # #7aa2f7
$purple     = rgb(187,154,247) # #bb9af7
$cyan       = rgb(125,196,204) # #7dc4cc
$red        = rgb(247,118,142) # #f7768e
$green      = rgb(158,206,106) # #9ece6a
$yellow     = rgb(224,175,104) # #e0af68

# Decorations
decoration {
    rounding = 10
    blur = yes
    blur_size = 12
    blur_passes = 3
    shadow = yes
    col.shadow = rgba(0,0,0,0.35)
}

# Borders
general {
    border_size = 2
    col.active_border = $accent
    col.inactive_border = rgba(26,27,38,0.7)
    col.group_border_active = $accent
    col.group_border_inactive = rgba(26,27,38,0.5)
}

# Animations
animations {
    enabled = yes
    animation = windows, 1, 6, default, slide
    animation = workspaces, 1, 4, default, slide
}

# Startup
exec-once = waybar &
exec-once = hyprpaper &







# 🗼 Tokyo Night for Kitty

font_family JetBrainsMono Nerd Font
font_size 14.0

foreground #c0caf5
background #1a1b26
cursor #7aa2f7
background_opacity 0.85

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
active_tab_background   #7aa2f7
active_tab_foreground   #1a1b26
inactive_tab_background #1a1b26
inactive_tab_foreground #565f89


/* 🗼 Tokyo Night Waybar */
* {
  font-family: "JetBrains Mono", monospace;
  font-size: 12px;
  color: #c0caf5;
}

window#waybar {
  background: #1a1b26;
  border-bottom: 2px solid #7aa2f7;
}

#workspaces button.focused {
  background: #7aa2f7;
  color: #1a1b26;
  border-radius: 6px;
}

#clock, #network, #pulseaudio, #cpu, #memory {
  color: #bb9af7;
  padding: 0 10px;
}





