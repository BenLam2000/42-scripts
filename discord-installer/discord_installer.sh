#!/bin/bash

echo -ne '\n - Downloading archive from official Discord website...\n'
wget -O "$HOME/Downloads/discord.tar.gz" "https://discord.com/api/download?platform=linux&format=tar.gz"
echo -ne '\n - Extracting archive to $HOME/.local/share/...\n'
tar -xvf "$HOME/Downloads/discord.tar.gz" -C "$HOME/.local/share/"

echo -ne '\n Adding script that runs discord archive script to $HOME/.local/bin/discord...'
cat > $HOME/.local/bin/discord << 'EOF'
#!/usr/bin/bash
exec nohup $HOME/.local/share/Discord/discord --no-sandbox "$@" &
EOF

chmod +x $HOME/.local/bin/discord

echo -ne '\nYou can now run the "discord" command anywhere in the terminal to start the installation and should be brought to the log in screen\n'
