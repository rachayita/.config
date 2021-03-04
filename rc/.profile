export PATH="$HOME/.cargo/bin:$PATH"
#mapping menu key to Super_R and caps to escape
#xmodmap -e "keysym Menu = Super_R" -e "keysym Caps_Lock = Escape" 2>/dev/null &
#xmodmap -e "keysym Caps_Lock = Escape" 2>/dev/null &
xmodmap ~/.config/Xmodmap

#dmenufm
# FONTS
export FM_GENERIC_FONT="JetBrainsMono-7"
export FM_NOTIF_FONT="JetBrainsMono-7"
export FM_DANGER_FONT="JetBrainsMono-7"
# COLORs
export FM_GENERIC_COLOR="#005577"
export FM_ACTION_COLOR_LV1="#33691e"
export FM_ACTION_COLOR_LV2="#FF8C00"
export FM_ACTION_COLOR_BULK="#CB06CB"
export FM_SUDO_COLOR="red"
#default terminal
export TERMINAL=st
export EDITOR=vim
_byobu_sourced=1 . /usr/bin/byobu-launch 2>/dev/null || true
