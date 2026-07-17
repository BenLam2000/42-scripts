# Problem

Most if not all of 42KL PCs native discord app needs updating, which prompts you with 2 options: .deb (debian binary) or .tar.gz (archive file). Debian binaries won't work because it needs sudo permissions, which only bocals have access to. Archives can work without sudo and while you can download and extract it through the prompt, you will have to access the extracted folder to run the Discord program every time, which can be troublesome for some. As you know, programmers are very lazy people :P. The goal here is to find a way to make it so that we can run 'discord' from anywhere in the terminal.

# Prerequisites

### Environment variables

Environment variables are something like global variables recognized throughout your system, and can be viewed using `printenv`. One of the most commonly used ones is environment path. This is what a typical environment path looks like when you run `echo $PATH`:

```
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin 
```

### Understanding executables aka binaries

When you run a command like `ls` that can be run anywhere (not needing `./`), the shell looks through environment path in sequence (each path delimited by `:`). If a program called `ls` exists in one of these paths, it runs. You can verify from which exact path a command is run using `which <command>`. Most of these commands run from `usr/bin/`, but most of them in fact are just symlinks pointing to other paths, not binaries themselves. For example: 

```
user% which cc
/usr/bin/cc
user% ls -l /usr/bin/cc
lrwxrwxrwx 1 root root 20 Jan 31  2024 cc -> /etc/alternatives/cc
user% ls -l /etc/alternatives/cc
lrwxrwxrwx 1 root root 12 Jan 31  2024 /etc/alternatives/cc -> /usr/bin/gcc
```

<img width="400" alt="meme" src="https://github.com/user-attachments/assets/5693640f-0e57-4fc9-85f2-6cdc7be34fa0" />

# How the script works

This script downloads and extracts the .tar.gz archive file automatically and places it in within your user's .lcoal directory (since cadets only have write access to `/home/<user>/`). Note that the 'discord' program in the extracted folder is a shell script not a binary (you can verify for yourself). If you tried adding a symlink in `$HOME/.local/bin` to this "program" directly, the program would think you are currently running from the extracted folder and try to access other programs like "updater_bootstrap" from the current folder, which clearly fails. Instead, this created secondary script executes commands to run the Discord script, so when the checks are being done in that script, the path it is running from (`$0`) is the extracted folder, which contains all other necessary files. In the end, `$HOME/.local/bin` is added to the environment path, otherwise the shell wouldn't know where to look for the program when running the command `discord`.

This is a simple visualization of what happens when you run `discord` in terminal:

```
discord
-> $HOME/.local/bin/discord (user script)
-> $HOME/.local/share/Discord/discord (script from downloaded .tar.gz)
-> download programs and files from official server to $HOME/.config/discord (first-time only)
-> $HOME/.config/discord/Discord (actual binary)
```

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

# Beyond Discord

This concept for installing software in `$HOME/.local/` **SHOULD** work for all software that provides archive files (.tar.gz, .tar.xz, etc.). In fact, I have made the script in such a way that you can modify just a few variables at the top for it to work with other apps. So far I have only tested Discord and Marktext.

Appimage is another form of software distribution that is even simpler with just a single downloaded executable, but it uses a framework called FUSE, which unfortunately is not available on 42KL PCs (ask Bocal to install maybe?)

# Contributions and Bug Reports

If you find any bugs in my script, hit me up on Discord at `miloaisdinosaur`. Feel free to open a PR (pull request) if you have an idea to improve this script or if you have modified the script to work with a new app that many 42 students use!
