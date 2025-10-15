#!/bin/bash
# ==========================================================
# 🐧 Ubuntu Tilix Setup Script — Tokyo Night Edition
# ==========================================================

echo "[INFO] Updating system..."
sudo apt update -y

echo "[INFO] Installing Tilix..."
sudo apt install -y tilix wget unzip curl

# ----------------------------------------------------------
# 🅰️ Install Nerd Font
# ----------------------------------------------------------
echo "[INFO] Installing FiraCode Nerd Font..."
mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts || exit
wget -q https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip -o FiraCode.zip >/dev/null
fc-cache -fv

# ----------------------------------------------------------
# 🎨 Install Tokyo Night color scheme for Tilix
# ----------------------------------------------------------
echo "[INFO] Installing Tokyo Night theme for Tilix..."
mkdir -p ~/.config/tilix/schemes
cd ~/.config/tilix/schemes || exit
wget -q https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/tilix/TokyoNight-Storm.json

# ----------------------------------------------------------
# ⚡ Install Starship prompt
# ----------------------------------------------------------
echo "[INFO] Installing Starship prompt..."
curl -sS https://starship.rs/install.sh | sh -s -- -y

mkdir -p ~/.config
cat > ~/.config/starship.toml << 'EOF'
# ===========================================
# 🌌 Tokyo Night theme for Starship prompt
# ===========================================
add_newline = false

[character]
success_symbol = "[❯](bold blue)"
error_symbol = "[✗](bold red)"

[directory]
style = "bold blue"
truncation_length = 3

[git_branch]
symbol = "🌿 "
style = "purple"

[cmd_duration]
format = "⏱️ [$duration]($style) "
style = "bold yellow"

[time]
disabled = false
format = "🕒 [$time]($style) "
style = "dimmed white"
EOF

# ----------------------------------------------------------
# 🧩 Enable Starship for bash/zsh
# ----------------------------------------------------------
if [[ -n "$ZSH_VERSION" ]]; then
  echo 'eval "$(starship init zsh)"' >> ~/.zshrc
elif [[ -n "$BASH_VERSION" ]]; then
  echo 'eval "$(starship init bash)"' >> ~/.bashrc
fi

# ----------------------------------------------------------
# ✅ Final message
# ----------------------------------------------------------
echo
echo "=========================================================="
echo "✅ Tilix Tokyo Night setup complete!"
echo "🎨 Open Tilix → Preferences → Profile → Appearance:"
echo "   • Color Scheme: TokyoNight-Storm"
echo "   • Font: FiraCode Nerd Font 13"
echo "   • Enable transparent background ✅"
echo
echo "⚡ Restart terminal to activate Starship."
echo "=========================================================="
