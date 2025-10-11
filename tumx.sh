#!/usr/bin/env bash

sudo apt install -y tmux

echo "[INFO] Creating tmux config with matching navigation"
cat > ~/.tmux.conf <<'TMUX'
set -g mouse on

# Use Alt+Arrow to move between panes (matches WezTerm)
bind -n M-Left  select-pane -L
bind -n M-Right select-pane -R
bind -n M-Up    select-pane -U
bind -n M-Down  select-pane -D

# Alt+Enter vertical split, Alt+\ horizontal split
bind -n M-Enter split-window -v
bind -n M-\\    split-window -h

# Resize panes with Alt+Shift+Arrows
bind -n M-S-Left  resize-pane -L 3
bind -n M-S-Right resize-pane -R 3
bind -n M-S-Up    resize-pane -U 2
bind -n M-S-Down  resize-pane -D 2

# Quality of life
setw -g aggressive-resize on
set -g history-limit 20000
TMUX

echo "[OK]"