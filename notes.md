# rust
- `rustup doc`
- gnu debugger(gdb) for rust

# s/w
- TestDisk: recover deleted files
- gitbucket
- imcompressor: image compressor
- dumpcap with wireshark
- alsamixer: for vol

# ss: port check
- > `sudo watch ss -tulpn`

# set screen resolution
- arandr: graphical resolution
- > `xrandr` shows current screen resolution
- > `xrandr -q`
- > `xrandr -d :0 --output <OUTPUT> --mode 1360x768`

# arch graphical driver
> xf86-video-vmware 

# enable tap click
- https://www.reddit.com/r/archlinux/comments/86g4ef/how_to_enable_tap_click/
- 40-libinput.conf or 30-touchpad.conf
 
```
Section "InputClass"
	Identifier "libinput touchpad catchall"
	MatchIsTouchpad "on"
	MatchDevicePath "/dev/input/event*"
	Option "Tapping" "True"
	Option "TappingDrag" "True"
	Option "ScrollMethod" "Edge"
	Option "AccelProfile" "linear"
	Option "AccelSpeed" "1"
	Option "DisableWhileTyping" "False"
	Driver "libinput"
EndSection
```

# commands
- sys info `inxi -F`
- rg for search in docs `ripgrep` 
- axel
- `entr` run arbitrary commands when files change
- `xev` to know key number
- copy to clipboard `some-command | xclip -sel clip`
- weather `curl wttr.in/city,country`
- news `curl getnews.tech/<topic>`
- `find "4DOS" wikipedia.txt | tee 4DOS.txt | sort > 4DOSsorted.txt`
- map menu key to super `exec xmodmap -e "keysym Menu = Super_R" 2>/dev/null &`
- `cat ~/.ssh/id_rsa.pub | ssh admin@server "sudo tee -a /root/.ssh/authorized_keys2 > /dev/null"`
- donot show untracked files locally `git config --local status.showUntrackedFiles no`

# 5 sec lag problem with intel gpu
- https://github.com/qutebrowser/qutebrowser/issues/4641
- https://github.com/qutebrowser/qutebrowser/issues/4809
- If not, create a new file in /etc/X11/xorg.conf.d/ called 20-modesetting.conf or whatever and add this:
```
Section "Device"
	Identifier 	"Intel Graphics"
	Driver		"modesetting"
	Option		"AccelMethod" "glamor"
	Option		"DRI"	"2"
EndSection
```

# rsync
> `rsync -avr source destination`
- no slash at path end

# mount android phone
- > `simple-mtpfs -l`
- > `simple-mtpfs --device 1 cell/`
- to unmount:
- > `fusermount -u cell/`

# install font manually:
- https://ehellman.github.io/blog/2013/04/16/manually-install-a-font-in-arch-linux/
- Unpack the file and move it to the shared fonts folder
> `mv font.ttf /usr/share/fonts/  or  ~/.local/share/fonts`
- Or if you want to install the font for a single user, move it to the .fonts directory in the home folder.
> `mv font.ttf ~/.fonts/`
- You might also have to update /etc/X11/xorg.conf or /etc/xorg.conf with the new directory
- Search for FontPath to find the correct location within the file to add your new path.
- Now, reload the font cache:
> `fc-cache -vf`

# freelance contract
- https://www.ashedryden.com/blog/contract

# connect AnnePro2 P1 via bluetooth
- press F2 + 1 for 5 sec
- > $ bt-device -l
- > $ bt-device -c <mac>

# ISO 8601: the better date format
- >   yyyy-mm-dd hh:mm:ss
- >   2021-12-22 23:44:56

# Try and redefine the ssh url for remote origin:
> `git remote set-url origin git@github.com:<url-repo>.git`
- And try again
> `ssh -T git@github.com`

# terminal background color
> #1e1e1e
