# Prerequisites

If you would like to understand how the script works, look at the **Prerequisites** and the **How the script works** section in the **discord-installer** readme.

# Instructions

1. Clone this git repo in a desired directory and enter the discord-installer directory:
   
   ```bash
   cd ~
   git clone git@github.com:BenLam2000/42-scripts.git
   cd 42-scripts/discord-installer
   ```

2. Add execute permissions to the script and run it:
   
   ```bash
   chmod +x discord_installer.sh
   ./discord_installer.sh
   ```

3. Since the environment path has been updated in ~/.zshrc, reload it:
   
   ```bash
   source ~/.zshrc
   ```

4. You can now type `discord` anywhere in your terminal and it should install the necessary files (first time only) and the discord login screen should appear.

# Contributions and Bug Reports

If you find any bugs in my script, hit me up on Discord at `miloaisdinosaur`. Feel free to open a PR (pull request) if you have an idea to improve this script or if you have modified the script to work with a new app that many 42 students use!
