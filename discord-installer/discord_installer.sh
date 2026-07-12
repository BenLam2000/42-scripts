#!/bin/bash

echo -ne '\n - Downloading archive from official Discord website...\n'
wget -O "$HOME/Downloads/discord.tar.gz" "https://discord.com/api/download?platform=linux&format=tar.gz"
echo -ne '\n - Extracting archive to $HOME/.local/share/...\n'
if [ ! -d $HOME/.local/share ]; then
	mkdir -p $HOME/.local/share
fi
tar -xvf "$HOME/Downloads/discord.tar.gz" -C "$HOME/.local/share/"

echo -ne '\n - Adding script that runs discord archive script to $HOME/.local/bin/discord...'
if [ ! -d $HOME/.local/bin ]; then
	mkdir -p $HOME/.local/bin
fi

cat > $HOME/.local/bin/discord << 'EOF'
#!/usr/bin/bash
exec nohup $HOME/.local/share/Discord/discord --no-sandbox "$@" > $HOME/.config/discord/output.log 2>&1 &
EOF

chmod +x $HOME/.local/bin/discord

# creating .zshrc file (runs every time a terminal is opened with zsh as shell) if it does not exist
if [ ! -f $HOME/.zshrc ]; then
	touch $HOME/.zshrc
fi

# updating environment path
echo -ne '\n - Adding $HOME/.local/bin to environment path in ~/.zshrc\n'
cat << 'EOF' >> $HOME/.zshrc
if [[ "$PATH" != *"$HOME/.local/bin"* ]]; then
	export PATH="$PATH:$HOME/.local/bin"
fi
EOF
