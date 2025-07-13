#!/bin/bash

#=========================#
#   SUB-FINDER INSTALLER  #
#=========================#

GREEN='\033[1;32m'
RED='\033[1;31m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RESET='\033[0m'

clear
echo -e "${CYAN}🔍 SUB-FINDER INSTALLER by BLACK ZERO${RESET}"
sleep 1

echo -e "${YELLOW}[*] Updating Termux packages...${RESET}"
pkg update -y > /dev/null 2>&1 || { echo -e "${RED}❌ pkg update failed! Check your internet.${RESET}"; exit 1; }

echo -e "${YELLOW}[*] Cloning SUB-FINDER repository...${RESET}"
git clone https://github.com/ADIRTTA/SUB-FINDER.git > /dev/null 2>&1 || { echo -e "${RED}❌ Git clone failed.${RESET}"; exit 1; }

cd SUB-FINDER || { echo -e "${RED}❌ SUB-FINDER folder not found.${RESET}"; exit 1; }

echo -e "${YELLOW}[*] Setting permissions...${RESET}"
chmod +x * > /dev/null 2>&1

echo -e "${YELLOW}[*] Installing Python dependencies...${RESET}"
pip3 install -r requirements.txt > /dev/null 2>&1 || { echo -e "${RED}❌ pip install failed.${RESET}"; exit 1; }

echo -e "${YELLOW}[*] Creating SUB-FINDER shortcut...${RESET}"
echo "python3 \$HOME/SUB-FINDER/sub-finder.py" > $HOME/.sub-finder-run
chmod +x $HOME/.sub-finder-run

# Detect shell config
PROFILE="$HOME/.bashrc"
[ -f "$HOME/.zshrc" ] && PROFILE="$HOME/.zshrc"
[ ! -f "$PROFILE" ] && touch "$PROFILE"

if ! grep -q "alias SUB-FINDER=" "$PROFILE"; then
    echo "alias SUB-FINDER='bash ~/.sub-finder-run'" >> "$PROFILE"
fi

echo -e "\n${GREEN}✅ Installation complete!${RESET}"
echo -e "${CYAN}👉 Type: ${YELLOW}SUB-FINDER${CYAN} to run the tool.${RESET}"
echo -e "${YELLOW}🔄 Restart Termux or run: ${RESET}source $PROFILE\n"
