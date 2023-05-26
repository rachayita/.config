source /etc/X11/xinit/xinitrc

if pgrep -x "bspwm" > /dev/null
then
    killall bspwm
fi

xsetroot -cursor_name left_ptr &

# source ~/.config/myrc/profile &

#mapping menu key to Super_R and caps to escape
xmodmap ~/.config/myrc/Xmodmap &

feh --bg-fill --no-fehbg ~/.config/.bg.jpg &
bspwm

