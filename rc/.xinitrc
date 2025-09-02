source /etc/X11/xinit/xinitrc

if pgrep -x "bspwm" > /dev/null
then
    killall bspwm
fi

xmodmap ~/.config/myrc/Xmodmap & # mapping menu key to Super_R and caps to escape
xsetroot -cursor_name left_ptr &
feh --bg-fill --no-fehbg ~/.config/.bg.jpg &
bspwm

