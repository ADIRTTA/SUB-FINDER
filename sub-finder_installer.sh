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
echo -e "${CYAN}🔍 SUB-FINDER INSTALLER by ADIRTTA${RESET}"
sleep 1

echo -e "${YELLOW}[*] Installing Python & Git...${RESET}"
pkg install python git -y > /dev/null 2>&1

echo -e "${YELLOW}[*] Cloning SUB-FINDER repository...${RESET}"
git clone https://github.com/ADIRTTA/SUB-FINDER.git > /dev/null 2>&1

cd SUB-FINDER || { echo -e "${RED}❌ Clone failed!${RESET}"; exit 1; }

echo -e "${YELLOW}[*] Setting permissions...${RESET}"
chmod +x * > /dev/null 2>&1

echo -e "${YELLOW}[*] Installing Python requirements...${RESET}"
pip install -r requirements.txt > /dev/null 2>&1

# Add command to ~/.bashrc or ~/.zshrc
echo -e "${YELLOW}[*] Creating SUB-FINDER shortcut command...${RESET}"
echo 'python3 ~/SUB-FINDER/sub-finder.py' > ~/.sub-finder-run
chmod +x ~/.sub-finder-run

# Add to bashrc/zshrc
if [ -f "$HOME/.bashrc" ]; then
    echo "alias SUB-FINDER='bash ~/.sub-finder-run'" >> ~/.bashrc
    source ~/.bashrc
elif [ -f "$HOME/.zshrc" ]; then
    echo "alias SUB-FINDER='bash ~/.sub-finder-run'" >> ~/.zshrc
    source ~/.zshrc
fi

echo -e "\n${GREEN}✅ Installation complete!${RESET}"
echo -e "${CYAN}👉 Now just type: ${YELLOW}SUB-FINDER${CYAN} from anywhere to launch the tool.${RESET}\n"
