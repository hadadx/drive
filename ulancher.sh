#!/bin/bash
# ==========================================================
# 🐉 Foot Terminal — Tokyo Night Setup Script for Ubuntu
# ==========================================================

echo "[INFO] Updating system..."
sudo apt update -y

echo "[INFO] Installing Foot terminal..."
sudo apt install -y foot wget unzip

# ----------------------------------------------------------
# 🅰️ Install FiraCode Nerd Font
# ----------------------------------------------------------
echo "[INFO] Installing FiraCode Nerd Font..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts || exit
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -o FiraCode.zip >/dev/null
fc-cache -fv

# ----------------------------------------------------------
# 🎨 Create Foot config directory
# ----------------------------------------------------------
echo "[INFO] Setting up Foot configuration..."
mkdir -p ~/.config/foot

cat > ~/.config/foot/foot.ini << 'EOF'
# ======================================
# 🐉 Foot Terminal — Tokyo Night Theme
# ======================================

font=FiraCode Nerd Font:size=12
dpi-aware=yes
pad=8x8
shell=/bin/bash

# שקיפות (אם compositor תומך בזה, כמו Hyprland)
alpha=0.92

# צבעים — Tokyo Night Storm
[colors]
background=1a1b26
foreground=c0caf5
regular0=15161E
regular1=f7768e
regular2=9ece6a
regular3=e0af68
regular4=7aa2f7
regular5=bb9af7
regular6=7dcfff
regular7=a9b1d6
bright0=414868
bright1=f7768e
bright2=9ece6a
bright3=e0af68
bright4=7aa2f7
bright5=bb9af7
bright6=7dcfff
bright7=c0caf5
EOF

# ----------------------------------------------------------
# ✅ Done
# ----------------------------------------------------------
echo
echo "=========================================================="
echo "✅ Foot Terminal Tokyo Night setup complete!"
echo
echo "🎨 Config file: ~/.config/foot/foot.ini"
echo "🅰️ Font: FiraCode Nerd Font (installed)"
echo "💡 To run: 'foot &'"
echo
echo "If you use Hyprland/Sway, transparency will be active automatically."
echo "=========================================================="
