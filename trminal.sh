#!/usr/bin/env bash
# setup_minimal_bw_bash.sh
# Minimal Black & White Bash prompt with path + arrow ()
# Works on Ubuntu/Debian with GNOME Terminal or any 256-color terminal

set -e

echo -e "\n🖋️ Installing FiraCode Nerd Font..."
sudo apt update -y && sudo apt install -y wget unzip fontconfig

mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts

if [ ! -f FiraCode.zip ]; then
  wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip -O FiraCode.zip
fi

unzip -oq FiraCode.zip -d FiraCode
fc-cache -fv >/dev/null
echo "✅ FiraCode Nerd Font installed."

# --------------------------------------------------------
echo -e "\n🎨 Configuring Bash prompt (Black & White minimalist)..."

cat >> ~/.bashrc <<'EOF'

if [ -n "$PS1" ]; then
  # צבעים
  GREEN="\[\033[1;32m\]"   # ירוק זוהר
  RESET="\[\033[0m\]"

  # פרומפט: רק הנתיב הנוכחי + סמל ירוק  (Nerd Font)
  PS1="${GREEN}\w\n ${RESET}"
fi


# השבת צבעים מיותרים בפקודות
alias ls='ls --color=never'
alias ll='ls -alF'
alias grep='grep --color=never'
alias egrep='egrep --color=never'
alias fgrep='fgrep --color=never'
# ================================================



mkdir -p ~/.local/share/fonts
cd ~/.local/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/FiraCode.zip -O FiraCode.zip
unzip -oq FiraCode.zip -d FiraCode
fc-cache -fv

EOF

source ~/.bashrc || true

echo -e "\n✅ Done!"
echo "🟢 Open a new terminal and enjoy your minimalist Bash prompt:"
echo "  ~/Documents"
echo "   "
echo "🎨 Tip: In your terminal settings → set font to 'FiraCode Nerd Font Regular'"
echo "🖤 Background: use 'Gray on Black' or 'Solarized Dark' theme for a pro look."