# .config
backup for arch config

## [LICENSE](LICENSE)
The repo is under MIT License

## pacman
```bash
sudo pacman -S xorg-server xorg-xinit xorg-xrandr xterm xorg-xbacklight less \
fd base-devel git meld neovim firefox mpv vifm youtube-dl feh stow lxappearance\
alacritty chromium sxiv gdb ueberzug xclip neomutt font-manager syncthing ufw gufw \
cups openbsd-netcat zathura unzip shotgun zbar tig pass  xdotool  ntfs-3g typst \
skim starship eza bat pass-otp nss-mdns system-config-printer jless htop fastfetch \
hyperfine zathura-pdf-poppler cronie dmenu gparted thunar github-cli \
bluez blueman pipewire pipewire-pulse dunst networkmanager fzf nano reflector \
arch-install-scripts wget lynx bc ffmpegthumbnailer ripgrep glow bsp-layout gdu\
zed xdg-desktop-portal-gtk linux-firmware tcpdump termshark signal-desktop openssh \
ttf-jetbrains-mono ttf-iosevka-nerd ttf-font-awesome rsync axel lshw rust-analyzer \
lua-language-server taplo
```

### aur
- paru-bin, stint(cmd line color picker), mutt-wizard, simple-mtpfs-git, obinskit
- brother-mfc-l2700dw, 7-zip-full (7z), vscodium-bin, dmenufm, linux-wifi-hotspot
- portal-bin

### todo
- start NetworkManager, bluetooth, ufw, sshd and cronie services by systemctl
- browser addon: dark reader,vimium, ublock origin, firfox container, better darkmode
- linux-firmware for missing or deleted driver
```bash
mkdir -p ~/.local/state/bash && touch ~/.local/state/bash/history
```
```bash
sudo reflector --verbose --ipv4 --protocol https --score 20 --sort rate --save /etc/pacman.d/mirrorlist
```

### ~/.local/share/fonts
- `fc-cache -vf`
- pacman: [ttf-jetbrains-mono](https://www.jetbrains.com/lp/mono/)
- pacman: [ttf-iosevka-nerd](https://www.nerdfonts.com/font-downloads)

### ~/.local/share/icons
- [Fancy-Dark-Icons](https://www.gnome-look.org/p/1598639)
- [ArchCursor](https://www.gnome-look.org/p/999929)
  - aur: xcursor-arch-simple

### ~/.local/share/themes
- [Sweet-Dark](https://www.gnome-look.org/p/1253385)

## printer setup
- install nss-mdns
- Start/restart avahi-daemon.service and cups.service
- Replace the hosts line in /etc/nsswitch.conf with
    ```bash
    hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns
    ```
- [port for cups network printing](https://www.cups.org/doc/firewalls.html)
   - 631/tcp  ipp/ipps
   - 161/udp  snmp
   - 443/tcp  ipps
- [localhost](http://localhost:631)

## qemu
- install `qemu virt-manager dnsmasq vde2`
- select `qemu-full`
- `sudo systemctl enable --now libvirtd.service`
- `sudo usermod -aG libvirt $USER`

### [for internet connection](https://www.youtube.com/watch?v=dLqIx-a2sPM)
- `sudo ufw allow in on virbr0`
- `sudo ufw allow out on virbr0`
- `sudoedit /etc/ufw/sysctl.conf`
  - uncomment `net/ipv4/ip_forward=1`
- `sudoedit /etc/default/ufw`
  - change `DEFAULT_FORWARD_POLICY` from "DROP" to "ACCEPT"
- `sudo ufw reload`

## bluetooth settings
- [blutooth auto power on after boot/resume/before login](https://wiki.archlinux.org/title/Bluetooth)
- `sudoedit /etc/bluetooth/main.conf`
    ```bash
    [Policy]
    AutoEnable=true
    ```

## [autologin](https://wiki.archlinux.org/title/Getty#Prompt_only_the_password_for_a_default_user_in_virtual_console_login)
- `sudo mkdir /etc/systemd/system/getty@tty1.service.d`
- `sudoedit /etc/systemd/system/getty@tty1.service.d/autologin.conf`
- change it to your username

    ```bash
    [Service]
    ExecStart=
    ExecStart=-/sbin/agetty -o '-p -f -- \\u' --noclear --autologin username %I $TERM
    ```

## [enable tap click](https://www.reddit.com/r/archlinux/comments/86g4ef/how_to_enable_tap_click/)
- 40-libinput.conf or 30-touchpad.conf

    ```bash
    Section "InputClass"
    Identifier "libinput touchpad catchall"
    MatchIsTouchpad "on"
    MatchDevicePath "/dev/input/event*"
    Option "Tapping" "True"
    Option "TappingDrag" "True"
    # Option "ScrollMethod" "Edge"
    Option "ScrollMethod" "TwoFinger"
    Option "AccelProfile" "linear"
    Option "AccelSpeed" "0.5"
    Option "DisableWhileTyping" "False"
    Driver "libinput"
    EndSection
    ```

## set screen resolution
- arandr: graphical resolution
- `xrandr` shows current screen resolution
- ` xrandr -q `
- ` xrandr -s 1360x768 `
- or ` xrandr -d :0 --output <OUTPUT> --mode 1360x768 `

## [5 sec lag problem with intel gpu](https://github.com/qutebrowser/qutebrowser/issues/4641)
[1](https://github.com/qutebrowser/qutebrowser/issues/4809)
- If not, create a new file in /etc/X11/xorg.conf.d/ called 20-modesetting.conf or whatever and add this:
    ```bash
    Section "Device"
    Identifier  "Intel Graphics"
    Driver      "modesetting"
    Option      "AccelMethod" "glamor"
    Option      "DRI"    "2"
    EndSection
    ```

## mount android phone
- `simple-mtpfs -l`
- `simple-mtpfs --device 1 cell/`
- to unmount: `fusermount -u cell/`

## connect AnnePro2 P1 via bluetooth
- press F2 + 1 for 5 sec
- `bt-device -l`
- `bt-device -c <mac>`

## Try and redefine the ssh url for remote origin:
- `git remote set-url origin ssh://git@github.com/username/<url-repo>.git`
- `ssh -T git@github.com`

## [make brightness editable](https://wiki.archlinux.org/title/Backlight)
- add below setting in new file `/etc/udev/rules.d/backlight.rules`
    ```bash
    ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"
    ```

## mutt-wizard
> `mw -a user@gmail.com -u user -n user -i imap.gmail.com -I 993 -s smtp.gmail.com -S 465`

## gen ssh keys
```bash
mkdir ~/.ssh
chmod 700 ~/.ssh
ssh-keygen -t rsa
```

## base64
- `echo -n 'data' | base64`
  - results `ZGF0YQ==`
- `echo -n ZGF0YQ== | base64 -d`
  - results `data`

## .ssh/config format for multiple keys
```conf
Host ANY_NAME
HostName HOST or IP
User USER_NAME
IdentityFile "PATH TO id_rsa FILE"
```
## change pinentry permanently
- `vim ~/.gnupg/gpg-agent.conf `
    ```
    pinentry-program /usr/bin/pinentry-tty
    ```

## move tabs at bottom in firefox
1. Find your Firefox profile directory
From the Help menu, select More Troubleshooting Information. The Troubleshooting Information tab will open.
Under the Application Basics section next to "Profile Folder", click "Show in Finder". A window will open that contains your profile folder.
2. Create a chrome/ directory in the profile directory.
3. Create userChrome.css custom css rules file in chrome/ directory
Copy the contents of below file (from @jonhoo's configuration files on github) into a file called userChrome.css in the newly created chrome directory.
https://raw.githubusercontent.com/jonhoo/configs/master/gui/.mozilla/firefox/chrome/userChrome.css
4. Enable custom css in firefox about:config settings
type "about:config" into Firefox's URL bar
Click "Accept the Risk and Continue"
In the settings search bar, look for toolkit.legacyUserProfileCustomizations.stylesheets, and toggle the boolean to true
Restart Firefox

## optional
- https://github.com/polybar/polybar-scripts.git    bspwm/scripts
- https://github.com/cirala/vifmimg fir vifm image preview
- imcompressor: image compressor
- dumpcap with wireshark or termshark
- xf86-video-vmware  #arch graphical driver
- https://github.com/Julien-cpsn/ATAC
- https://github.com/quantumsheep/sshs
- https://github.com/SpatiumPortae/portal

## vim
- `set wildignore+=**/node_modules/**` ignore files or folders
- `:w !sudo tee "%"` root priviledge for saving doc in vim
- `:5,17s/^/#/` comment line 5-17
- `:%s/^/#/` comment all lines
- `gx` opens links under cursor
- `%s/find/replace/gci`
    %: Indicates the entire file
    s: Stands for substitute
    g: Replaces all occurrences in each line
    i: Case insensitive
    c: Confirm each replacement

## nvimdiff
- ]c          - next difference
- [c          - previous difference
- do          - diff obtain
- dp          - diff put
- zo          - open folded text
- zc          - close folded text
- zR          - unfold all lines
- zr          - open all folds
- zm          - close all folds
- :diffoff!   - to end diff mode
    :syn off     - to remove colors
- :diffupdate - to remove leftover spacing issues)
- :only       - once you’re done reviewing all conflicts, this shows only the middle/merged file
- :set diffopt+=iwhite      - to avoid whitespace comparison
- :set diffopt+=context:0   - you can influence how many identical lines are kept around changes (default: 6 lines above and below) via the context value of the diffopt option. So, to completely fold all identical lines
- :windo diffthis - to begin diffing on all visible windows which executes :diffthis on each window.
- default identifiers that can be selected using diffget
  - LO local master copy
  - RE remote master to be merged
  - BA common ancestor of remote and local changes.
- :diffupdate - re-scan the files for differences
  - choose which version you want to keep with :diffget //2 or :diffget //3
  - //2 and //3 are unique identifiers for target/master copy and merge/branch copy file names
- If you were trying to do a git pull when you ran into merge conflicts:
  - type `git rebase –continue`

## commands
- `inxi -F`sys info
- `ripgrep` rg for search in docs
- `entr` run arbitrary commands when files change
- `xev` to know key number
- `some-command | xclip -sel clip` copy to clipboard
- `curl wttr.in/city,country`
- `find "4DOS" wikipedia.txt | tee 4DOS.txt | sort > 4DOSsorted.txt`
- `exec xmodmap -e "keysym Menu = Super_R" 2>/dev/null &` map menu key to super
- `cat ~/.ssh/id_rsa.pub | ssh admin@server "sudo tee -a /root/.ssh/authorized_keys2 > /dev/null"`
- `git config --local status.showUntrackedFiles no` donot show untracked files locally
- `lshw -c video` cmd to show video driver
- `netstat -lntpu` list open network ports and the processes
- `curl ifconfig.me` get your ip
- `xrandr --output eDP-1 --brightness 0.5` adjust brightness
- `dd if=file.iso of=/dev/sdb bs=512k status=progress` create bootable usb
- `gtk-update-icon-cache -f -t ~/.icons/<theme_name>` run to update the icon cache
- `sudo mkfs.vfat /dev/sdb1`   to format usb drive with FAT32
- terminal background blue color #1e1e1e
- freelance contract: https://www.ashedryden.com/blog/contract
- `rsync -avr source destination`   no slash at path end
- `ln -s file link`
- if ~/.pki isn't present then $XDG_DATA_HOME/pki/nssdb will be used instead
  - no sources mentioned for environmental variable
- `journalctl -u cronie.service`
- `alacritty -e nvim` to open doc in neovim directly
- `df -h` to see free space and `lsblk` to see mount points

