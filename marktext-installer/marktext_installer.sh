#!/usr/bin/bash

######################### MODIFY THIS ONLY ###################################
# VARIABLES
program='marktext'  # command to type to open program
program_bin='marktext'  # name of binary in archive file
download_link='https://github.com/marktext/marktext/releases/download/v0.19.1/marktext-linux-0.19.1.tar.gz'
##############################################################################

# COLOURS
GREEN='\033[0;32m'
NC='\033[0m'

# Download archive from Github
echo -ne "${GREEN}\n - Downloading archive...\n${NC}"
wget -O "$HOME/Downloads/${program}.tar.gz" "${download_link}"

# Extract archive to local share folder
echo -ne "${GREEN}\n - Extracting archive to $HOME/.local/share...\n${NC}"
if [[ ! -d "$HOME/.local/share" ]]; then
	mkdir -p "$HOME/.local/share"
fi
tar -xvf "$HOME/Downloads/${program}.tar.gz" -C "$HOME/.local/share"
extracted_dir=$(tar -tvf "$HOME/Downloads/${program}.tar.gz" | head -n 1 | awk '{print $6}' | tr -d '/')
mv "$HOME/.local/share/${extracted_dir}" "$HOME/.local/share/${program}"

# Create launch script
echo -ne "${GREEN}\n - Adding launcher script to $HOME/.local/bin...\n${NC}"
if [[ ! -d "$HOME/.local/bin" ]]; then
        mkdir -p "$HOME/.local/bin"
fi
cat > "$HOME/.local/bin/${program}" << EOF
#!/usr/bin/bash
exec nohup "$HOME/.local/share/${program}/${program_bin}" --no-sandbox "$@" > "$HOME/.local/share/${program}/output.log" 2>&1 &
EOF

# Add execute permissions if launch script lacks it
if [[ ! -x "$HOME/.local/bin/${program}" ]]; then
	chmod +x "$HOME/.local/bin/${program}"
	echo -ne "${GREEN}\n - Added execute permissions (+x) to $HOME/.local/bin/${program}\n${NC}"
fi

# Create .zshrc if it does not exist
if [[ ! -f "$HOME/.zshrc" ]]; then
    touch "$HOME/.zshrc"
	echo -ne "${GREEN}\n - Created $HOME/.zshrc\n${NC}"
fi

# Update environment path if it does not begin with '$HOME/.local/bin'
echo -ne "${GREEN}\n - Adding $HOME/.local/bin to beginning of environment path in $HOME/.zshrc\n${NC}"
cat >> $HOME/.zshrc << 'EOF'
if [[ "$PATH" != "$HOME/.local/bin"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi
EOF
