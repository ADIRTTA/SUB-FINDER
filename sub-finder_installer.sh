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

echo -e "${YELLOW}[*] Installing Python & Git...${RESET}"
pkg install python git -y > /dev/null 2>&1

echo -e "${YELLOW}[*] Cloning SUB-FINDER repository...${RESET}"
git clone https://github.com/ADIRTTA/SUB-FINDER.git > /dev/null 2>&1

cd SUB-FINDER || { echo -e "${RED}❌ Clone failed!${RESET}"; exit 1; }

echo -e "${YELLOW}[*] Setting permissions...${RESET}"
chmod +x * > /dev/null 2>&1

echo -e "${YELLOW}[*] Installing Python requirements...${RESET}"
pip3 install -r requirements.txt > /dev/null 2>&1

# Create shortcut script
echo -e "${YELLOW}[*] Creating SUB-FINDER shortcut...${RESET}"
echo "python3 \$HOME/SUB-FINDER/sub-finder.py" > $HOME/.sub-finder-run
chmod +x $HOME/.sub-finder-run

# Add alias to shell profile
PROFILE=""
if [ -f "$HOME/.bashrc" ]; then
    PROFILE="$HOME/.bashrc"
elif [ -f "$HOME/.zshrc" ]; then
    PROFILE="$HOME/.zshrc"
else
    PROFILE="$HOME/.profile"
fi

if ! grep -q "alias SUB-FINDER=" "$PROFILE"; then
    echo "alias SUB-FINDER='bash ~/.sub-finder-run'" >> "$PROFILE"
fi

echo -e "\n${GREEN}✅ Installation complete!${RESET}"
echo -e "${CYAN}👉 Now type: ${YELLOW}SUB-FINDER${CYAN} to launch the tool.${RESET}"
echo -e "${YELLOW}🔄 If not working, restart Termux or run: ${RESET}source $PROFILE\n"
