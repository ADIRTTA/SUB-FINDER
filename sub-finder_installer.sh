#!/bin/bash

#===========================#
#  SUB-FINDER INSTALLER 🛠️ #
#===========================#

clear
echo
echo "🔍 SUB-FINDER INSTALLER by ADIRTTA"
echo "--------------------------------------"
sleep 1

echo "[+] Cloning SUB-FINDER tool..."
git clone https://github.com/ADIRTTA/SUB-FINDER.git > /dev/null 2>&1

cd SUB-FINDER || { echo "❌ Clone failed!"; exit 1; }

echo "[+] Installing requirements..."
pip install -r requirements.txt > /dev/null 2>&1

echo "[+] Creating launcher script..."
echo "python3 \$HOME/SUB-FINDER/sub-finder.py" > $HOME/.sub-finder-run
chmod +x $HOME/.sub-finder-run

echo "[+] Adding shortcut command..."

# Add shortcut to all known shells
for file in "$HOME/.bashrc" "$HOME/.zshrc" "$HOME/.profile"; do
  if [ -f "$file" ] && ! grep -q "alias SUB-FINDER=" "$file"; then
    echo "alias SUB-FINDER='bash \$HOME/.sub-finder-run'" >> "$file"
  fi
done

# Fish shell support
if [ -d "$HOME/.config/fish/functions" ]; then
  echo "function SUB-FINDER; python3 \$HOME/SUB-FINDER/sub-finder.py; end" > "$HOME/.config/fish/functions/SUB-FINDER.fish"
fi

echo
echo "✅ SUB-FINDER Installed Successfully!"
echo "👉 Type: SUB-FINDER"
echo "🔄 If not working, run: source ~/.bashrc OR restart Termux"
echo
