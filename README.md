# .config for arch
## basic installation
### pacman
```bash
sudo pacman -S xorg-server xorg-xinit xorg-xrandr xorg-xbacklight slock man-db btop \
fd base-devel git meld neovim firefox mpv vifm feh stow openbsd-netcat zathura less \
alacritty sxiv gdb ueberzug xclip neomutt ufw gufw zbar tig pass zed xdotool htop \
skim starship eza bat pass-otp unzip shotgun fastfetch lua-language-server ffmpeg bc \
zathura-pdf-poppler cronie dmenu gparted thunar networkmanager-dmenu taplo lazyjj \
bluez blueman pipewire pipewire-pulse dunst networkmanager fzf nano reflector jujutsu \
wget lynx ffmpegthumbnailer ripgrep gdu xdg-desktop-portal-gtk openssh signal-desktop \
ttf-jetbrains-mono ttf-jetbrains-mono-nerd rsync axel lshw rustup expac \
cups nss-mdns system-config-printer \
cargo-binstall cargo-update \
youtube-dl lxappearance chromium font-manager syncthing ntfs-3g typst jless hyperfine \
arch-install-scripts glow bsp-layout linux-firmware tcpdump termshark github-cli xterm \
rust-analyzer \
```

### aur
```bash paru-bin
git clone https://aur.archlinux.org/paru-bin.git && \
cd paru-bin && makepkg -si
```

- stint(cmd line color picker), mutt-wizard, simple-mtpfs-git, obinskit
- brother-mfc-l2700dw, 7-zip-full (7z), vscodium-bin, dmenufm, linux-wifi-hotspot
- portal-bin

### todo
- start NetworkManager, bluetooth, ufw, sshd and cronie services by systemctl
- browser addon: dark reader,vimium, ublock origin, firfox container, privacy badger, better darkmode
- linux-firmware for missing or deleted driver
- `Defaults:%wheel !authenticate` paste after Default in `visudo`
- `mw -a user@gmail.com -u user -n user -i imap.gmail.com -I 993 -s smtp.gmail.com -S 465`
  - aur: mutt-wizard

```bash
mkdir -p ~/.local/state/bash && touch ~/.local/state/bash/history && \
cd /mnt && \
sudo mkdir sda1 sda2 sda3 sda4 sdb1 sdb2 sdb3 sdb4 sdc1 sdc2 sdc3 cell pen && \
sudo chown -R $USER:$USER *
```

```bash reflector
sudo reflector --verbose --ipv4 --protocol https --score 20 --sort rate --save /etc/pacman.d/mirrorlist
```

### [make brightness editable](https://wiki.archlinux.org/title/Backlight)
```bash
sudo usermod -a -G audio,video,power $USER && /
sudo echo 'ACTION=="add", SUBSYSTEM=="backlight", RUN+="/bin/chgrp video $sys$devpath/brightness", RUN+="/bin/chmod g+w $sys$devpath/brightness"' | sudo tee /etc/udev/rules.d/backlight.rules
```

### ~/.local/share/fonts
- `fc-cache -vf`
- pacman: [ttf-jetbrains-mono](https://www.jetbrains.com/lp/mono/)
- pacman:[ttf-jetbrains-mono-nerd](https://www.nerdfonts.com/font-downloads)
- pacman: [ttf-iosevka-nerd](https://www.nerdfonts.com/font-downloads) has freezing issue

### ~/.local/share/icons
- [Fancy-Dark-Icons](https://www.gnome-look.org/p/1598639)
- [ArchCursor](https://www.gnome-look.org/p/999929)
  - aur: xcursor-arch-simple

### ~/.local/share/themes
- [Sweet-Dark](https://www.gnome-look.org/p/1253385)

### [blutooth auto power on after boot/resume/before-login](https://wiki.archlinux.org/title/Bluetooth)
- `sudoedit /etc/bluetooth/main.conf`
- set `AutoEnable=true` under `[Policy]`

### [autologin](https://wiki.archlinux.org/title/Getty#Prompt_only_the_password_for_a_default_user_in_virtual_console_login)
```bash
sudo mkdir -p /etc/systemd/system/getty@tty1.service.d && \
sudo echo -e "[Service]\nExecStart=\nExecStart=-/sbin/agetty -o '-p -f -- \\\\\\u' --noclear --autologin username %I \$TERM" > /etc/systemd/system/getty@tty1.service.d/autologin.conf && \
# change it to your username
sudoedit /etc/systemd/system/getty@tty1.service.d/autologin.conf
```

### printer setup
```bash
sudo pacman -S nss-mdns && \
sudo systemctl enable --now avahi-daemon.service && \
sudo systemctl enable --now cups.service && \
# Replace the hosts line in
sudoedit /etc/nsswitch.conf
# with
hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns
```

- aur: `brother-mfc-l2700dw`
- [port for cups network printing](https://www.cups.org/doc/firewalls.html)
   - 631/tcp  ipp/ipps
   - 161/udp  snmp
   - 443/tcp  ipps
- [localhost](http://localhost:631)

### qemu
```bash
sudo pacman -S qemu-full virt-manager dnsmasq vde2 && \
sudo systemctl enable --now libvirtd.service && \
sudo usermod -aG libvirt $USER && \
# [for internet connection](https://www.youtube.com/watch?v=dLqIx-a2sPM)
sudo ufw allow in on virbr0 && \
sudo ufw allow out on virbr0 && \
sudoedit /etc/ufw/sysctl.conf
  # uncomment `net/ipv4/ip_forward=1`
sudoedit /etc/default/ufw
  # change `DEFAULT_FORWARD_POLICY` from "DROP" to "ACCEPT"
sudo ufw reload
```

## [enable tap click](https://www.reddit.com/r/archlinux/comments/86g4ef/how_to_enable_tap_click/)
- 40-libinput.conf or 30-touchpad.conf
- `sudoedit /usr/share/X11/xorg.conf.d/40-libinput.conf`
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

## connect AnnePro2 P1 via bluetooth
- press F2 + 1 for 5 sec
- `bt-device -l`
- `bt-device -c <mac>`

## Try and redefine the ssh url for remote origin:
- `git remote set-url origin ssh://git@github.com/rachayita/<url-repo>.git`
- `ssh -T git@github.com`

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
- `nvim ~/.gnupg/gpg-agent.conf `
```conf
pinentry-program /usr/bin/pinentry-tty
```

## optional
- [arch install](https://www.howtogeek.com/766168/how-to-install-arch-linux-on-a-pc/)
- [bspwm/scripts](https://github.com/polybar/polybar-scripts.git)
- [vifm image preview](https://github.com/cirala/vifmimg)
- [ATAC](https://github.com/Julien-cpsn/ATAC)
- [sshs](https://github.com/quantumsheep/sshs)
- [portal](https://github.com/SpatiumPortae/portal)
- [shpool](https://github.com/shell-pool/shpool)
- [ethersync](https://github.com/ethersync/ethersync)
- [magic-wormhole](https://github.com/magic-wormhole/magic-wormhole.rs)
- imcompressor: image compressor
- dumpcap with wireshark or termshark
- mdbook: convert markdown to book
- xf86-video-amdgpu
- xf86-video-ati

## commands
- `inxi -F` sys info
- `ripgrep` rg for search in docs
- `entr` run arbitrary commands when files change
- `xev` to know key number
- `some-command | xclip -sel clip` copy to clipboard
- `curl wttr.in/city,country`
- `find "4DOS" wikipedia.txt | tee 4DOS.txt | sort > 4DOSsorted.txt`
- `exec xmodmap -e "keysym Menu = Super_R" 2>/dev/null &` map menu key to super
- `cat ~/.ssh/id_rsa.pub | ssh admin@server "sudo tee -a /root/.ssh/authorized_keys2 > /dev/null"`
- `lshw -c video` cmd to show video driver
- `netstat -lntpu` list open network ports and the processes
- `curl ifconfig.me` get your ip
- `xrandr --output eDP-1 --brightness 0.5` adjust brightness
- `dd if=file.iso of=/dev/sdb bs=512k status=progress` create bootable usb
- `gtk-update-icon-cache -f -t ~/.icons/<theme_name>` run to update the icon cache
- `sudo mkfs.vfat /dev/sdb1`   to format usb drive with FAT32
- freelance contract: https://www.ashedryden.com/blog/contract
- `rsync -avr source destination`   no slash at path end
- `ln -s file link`
- if ~/.pki isn't present then $XDG_DATA_HOME/pki/nssdb will be used instead
  - no sources mentioned for environmental variable
- `journalctl -u cronie.service`
- `alacritty -e nvim` to open doc in neovim directly
- `df -h` to see free space and `lsblk` to see mount points
- `diff -s folder1 folder2`
- `printenv` to show globals
- `pass otp -c mail`
* `bat /sys/class/power_supply/BAT1/capacity`
* `bat /sys/class/backlight/intel_backlight/actual_brightness`
* `sudoedit /etc/pacman.conf` uncomment color for colorful paru

## SemVer's fundamental rules: MAJOR.MINOR.PATCH
1. MAJOR version when you make incompatible API changes
2. MINOR version when you add functionality in a backward-compatible manner
3. PATCH version when you make backward-compatible bug fixes

## move tabs at bottom in firefox
1. Find your Firefox profile directory
From the Help menu, select More Troubleshooting Information. The Troubleshooting Information tab will open.
Under the Application Basics section next to "Profile Folder", click "Show in Finder". A window will open that contains your profile folder.
2. Create a chrome/ directory in the profile directory.
3. Create userChrome.css custom css rules file in chrome/ directory
Copy contents from [@jonhoo's configuration](https://raw.githubusercontent.com/jonhoo/configs/master/gui/.mozilla/firefox/chrome/userChrome.css) into userChrome.css in new created chrome directory.
4. Enable custom css in firefox about:config settings
type "about:config" into Firefox's URL bar
Click "Accept the Risk and Continue"
5. In the settings search bar, look for toolkit.legacyUserProfileCustomizations.stylesheets, and toggle the boolean to true
Restart Firefox

## [LICENSE](LICENSE)
The repo is under MIT License
